import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:limpede/database/app_database.dart';
import 'package:limpede/models/srs_models.dart';
import 'package:limpede/services/sync_engine_service.dart';

void main() {
  late AppDatabase db;
  late SyncEngineService syncEngine;

  setUp(() {
    // Create an in-memory Drift database for testing
    db = AppDatabase(NativeDatabase.memory());
    syncEngine = SyncEngineService(db: db);
  });

  tearDown(() async {
    await db.close();
  });

  group('Drift SQLite Local-First Sync Engine Tests', () {
    final testPairs = [
      const SentencePair(
        id: 'test_pair_1',
        sourceText: 'Hello, how are you?',
        targetText: '¡Hola! ¿Cómo estás?',
        languageCode: 'es',
        topicCategory: 'Greetings',
        difficultyLevel: 'A1',
      ),
      const SentencePair(
        id: 'test_pair_2',
        sourceText: 'Good morning!',
        targetText: '¡Buenos días!',
        languageCode: 'es',
        topicCategory: 'Greetings',
        difficultyLevel: 'A1',
      ),
    ];

    test('Batch saves and retrieves sentence pairs from SQLite', () async {
      await syncEngine.saveSentencePairs(testPairs);

      final retrieved = await syncEngine.getSentencePairsForTopic(
        topicCategory: 'Greetings',
        languageCode: 'es',
      );

      expect(retrieved.length, 2);
      expect(retrieved.first.targetText, '¡Hola! ¿Cómo estás?');
    });

    test('Records answer local-first with SM-2 and enqueues sync mutation', () async {
      await syncEngine.saveSentencePairs(testPairs);

      // Record Grade 5 (Perfect) answer
      await syncEngine.recordAnswerLocalFirst(
        userId: 'user_123',
        pair: testPairs.first,
        grade: 5,
      );

      // Verify local SRS item created in SQLite
      final srsRows = await db.select(db.localSrsItems).get();
      expect(srsRows.length, 1);
      final srs = srsRows.first;
      expect(srs.userId, 'user_123');
      expect(srs.sentenceId, 'test_pair_1');
      expect(srs.intervalDays, 1);
      expect(srs.easeFactor, greaterThan(2.5));
      expect(srs.consecutiveCorrect, 1);
      expect(srs.isSynced, false);

      // Verify mutation queued in SyncQueueItems
      final queueRows = await db.select(db.syncQueueItems).get();
      expect(queueRows.length, 1);
      expect(queueRows.first.action, 'RECORD_ANSWER');
      expect(queueRows.first.status, 'PENDING');
      expect(queueRows.first.payload, contains('test_pair_1'));
    });

    test('Queries due reviews from local SQLite joined with sentence pairs', () async {
      await syncEngine.saveSentencePairs(testPairs);

      // Record answer
      await syncEngine.recordAnswerLocalFirst(
        userId: 'user_123',
        pair: testPairs.first,
        grade: 5,
      );

      // Manually set nextReviewDate in the past to simulate due item
      await (db.update(db.localSrsItems)
            ..where((tbl) => tbl.sentenceId.equals('test_pair_1')))
          .write(
        LocalSrsItemsCompanion(
          nextReviewDate: Value(DateTime.now().subtract(const Duration(days: 2))),
        ),
      );

      final dueReviews = await syncEngine.getDueReviewsLocal(
        userId: 'user_123',
        languageCode: 'es',
      );

      expect(dueReviews.length, 1);
      expect(dueReviews.first.sentenceId, 'test_pair_1');
    });
  });
}
