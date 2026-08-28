import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import '../database/app_database.dart';
import '../models/srs_models.dart';
import 'srs_engine.dart';
import 'supabase_service.dart';

class SyncEngineService {
  static final SyncEngineService _instance = SyncEngineService._internal();
  factory SyncEngineService({AppDatabase? db, SupabaseService? supabaseService}) {
    if (db != null) _instance._db = db;
    if (supabaseService != null) _instance._supabaseService = supabaseService;
    return _instance;
  }
  SyncEngineService._internal();

  AppDatabase? _db;
  SupabaseService? _supabaseService;
  bool _isSyncing = false;

  AppDatabase get db => _db ??= AppDatabase();
  SupabaseService get supabaseService => _supabaseService ??= SupabaseService();

  /// Batch upsert sentence pairs into local SQLite
  Future<void> saveSentencePairs(List<SentencePair> pairs) async {
    try {
      await db.batch((batch) {
        batch.insertAllOnConflictUpdate(
          db.localSentencePairs,
          pairs.map((p) => LocalSentencePairsCompanion.insert(
                id: p.id,
                sourceText: p.sourceText,
                targetText: p.targetText,
                languageCode: p.languageCode,
                difficultyLevel: Value(p.difficultyLevel),
                topicCategory: p.topicCategory,
                grammarNotes: Value(p.grammarNotes),
                updatedAt: Value(DateTime.now()),
              )),
        );
      });
      debugPrint('SyncEngine: Cached ${pairs.length} sentence pairs into SQLite.');
    } catch (e) {
      debugPrint('SyncEngine saveSentencePairs Error: $e');
    }
  }

  /// Query local sentence pairs for a topic & language code
  Future<List<SentencePair>> getSentencePairsForTopic({
    required String topicCategory,
    required String languageCode,
  }) async {
    try {
      final query = db.select(db.localSentencePairs)
        ..where((tbl) =>
            tbl.topicCategory.equals(topicCategory) &
            tbl.languageCode.equals(languageCode));

      final rows = await query.get();
      return rows
          .map((r) => SentencePair(
                id: r.id,
                sourceText: r.sourceText,
                targetText: r.targetText,
                languageCode: r.languageCode,
                difficultyLevel: r.difficultyLevel,
                topicCategory: r.topicCategory,
                grammarNotes: r.grammarNotes,
              ))
          .toList();
    } catch (e) {
      debugPrint('SyncEngine getSentencePairsForTopic Error: $e');
      return [];
    }
  }

  /// Instant local-first SRS answer recording with SM-2 & sync queue
  Future<void> recordAnswerLocalFirst({
    required String userId,
    required SentencePair pair,
    required int grade,
  }) async {
    try {
      // 1. Check existing local SRS item or create new
      final existing = await (db.select(db.localSrsItems)
            ..where((tbl) =>
                tbl.userId.equals(userId) &
                tbl.sentenceId.equals(pair.id)))
          .getSingleOrNull();

      final srsItemId = existing?.id ?? 'srs_${pair.id}';
      final existingItem = existing != null
          ? SrsReviewItem(
              id: existing.id,
              sentenceId: existing.sentenceId,
              userId: existing.userId,
              nextReviewDate: existing.nextReviewDate,
              intervalDays: existing.intervalDays,
              easeFactor: existing.easeFactor,
              consecutiveCorrect: existing.consecutiveCorrect,
            )
          : SrsReviewItem(
              id: srsItemId,
              sentenceId: pair.id,
              userId: userId,
              nextReviewDate: DateTime.now(),
              intervalDays: 0,
              easeFactor: 2.5,
              consecutiveCorrect: 0,
            );

      // 2. Calculate next review via pure deterministic SM-2
      final updatedSrsItem = SrsEngine.calculateNextReview(
        item: existingItem,
        grade: grade,
      );

      // 3. Update local SQLite table immediately (0ms latency)
      await db.into(db.localSrsItems).insertOnConflictUpdate(
            LocalSrsItemsCompanion.insert(
              id: srsItemId,
              sentenceId: pair.id,
              userId: userId,
              nextReviewDate: Value(updatedSrsItem.nextReviewDate),
              intervalDays: Value(updatedSrsItem.intervalDays),
              easeFactor: Value(updatedSrsItem.easeFactor),
              consecutiveCorrect: Value(updatedSrsItem.consecutiveCorrect),
              isSynced: const Value(false),
            ),
          );

      // 4. Enqueue mutation for background sync
      final payload = jsonEncode(updatedSrsItem.toJson());

      await db.into(db.syncQueueItems).insert(
            SyncQueueItemsCompanion.insert(
              action: 'RECORD_ANSWER',
              payload: payload,
              createdAt: Value(DateTime.now()),
              status: const Value('PENDING'),
            ),
          );

      debugPrint('SyncEngine: Answer recorded local-first for "${pair.sourceText}".');

      // 5. Trigger non-blocking background queue flush
      syncPendingQueue();
    } catch (e) {
      debugPrint('SyncEngine recordAnswerLocalFirst Error: $e');
    }
  }

  /// Query all due reviews from local SQLite
  Future<List<SrsReviewItem>> getDueReviewsLocal({
    required String userId,
    required String languageCode,
  }) async {
    try {
      final now = DateTime.now();

      final query = db.select(db.localSrsItems).join([
        innerJoin(
          db.localSentencePairs,
          db.localSentencePairs.id.equalsExp(db.localSrsItems.sentenceId),
        ),
      ])
        ..where(db.localSrsItems.userId.equals(userId) &
            db.localSrsItems.nextReviewDate.isSmallerOrEqualValue(now) &
            db.localSentencePairs.languageCode.equals(languageCode));

      final rows = await query.get();

      return rows.map((row) {
        final srs = row.readTable(db.localSrsItems);

        return SrsReviewItem(
          id: srs.id,
          sentenceId: srs.sentenceId,
          userId: srs.userId,
          nextReviewDate: srs.nextReviewDate,
          intervalDays: srs.intervalDays,
          easeFactor: srs.easeFactor,
          consecutiveCorrect: srs.consecutiveCorrect,
        );
      }).toList();
    } catch (e) {
      debugPrint('SyncEngine getDueReviewsLocal Error: $e');
      return [];
    }
  }

  /// Flush pending offline mutations to Supabase in background
  Future<void> syncPendingQueue() async {
    if (_isSyncing) return;
    _isSyncing = true;

    try {
      final pending = await (db.select(db.syncQueueItems)
            ..where((tbl) => tbl.status.equals('PENDING'))
            ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt)]))
          .get();

      if (pending.isEmpty) {
        _isSyncing = false;
        return;
      }

      debugPrint('SyncEngine: Flushing ${pending.length} pending mutations to Supabase...');

      for (final item in pending) {
        try {
          if (item.action == 'RECORD_ANSWER') {
            final data = jsonDecode(item.payload) as Map<String, dynamic>;
            final srsItem = SrsReviewItem.fromJson(data);

            // Push to remote Supabase
            await supabaseService.upsertSrsReviewItem(srsItem);

            // Mark local SRS item synced
            await (db.update(db.localSrsItems)
                  ..where((tbl) => tbl.sentenceId.equals(srsItem.sentenceId)))
                .write(const LocalSrsItemsCompanion(isSynced: Value(true)));
          }

          // Mark queue item synced
          await (db.update(db.syncQueueItems)..where((tbl) => tbl.id.equals(item.id)))
              .write(const SyncQueueItemsCompanion(status: Value('SYNCED')));
        } catch (e) {
          debugPrint('SyncEngine: Remote sync deferred (offline/unreachable): $e');
        }
      }
    } catch (e) {
      debugPrint('SyncEngine syncPendingQueue Error: $e');
    } finally {
      _isSyncing = false;
    }
  }
}
