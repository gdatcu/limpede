import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/srs_models.dart';
import '../providers/auth_provider.dart';
import '../providers/course_provider.dart';
import '../providers/league_provider.dart';
import '../providers/quest_provider.dart';
import '../services/services.dart';

part 'srs_lesson_provider.g.dart';

class SrsLessonDeck {
  final String topic;
  final String targetLanguage;
  final List<SentencePair> sentencePairs;
  final Map<String, SrsReviewItem> existingSrsItems;
  final bool isSrsReviewSession;

  SrsLessonDeck({
    required this.topic,
    required this.targetLanguage,
    required this.sentencePairs,
    required this.existingSrsItems,
    this.isSrsReviewSession = false,
  });
}

@riverpod
SyncEngineService syncEngineService(Ref ref) {
  return SyncEngineService();
}

@riverpod
Future<int> dueSrsCount(Ref ref) async {
  final userProfile = ref.watch(currentUserProfileProvider).asData?.value;
  final userId = userProfile?.id ?? 'local_user';
  final courseState = ref.watch(courseStateNotifierProvider);
  final syncEngine = ref.watch(syncEngineServiceProvider);

  // Try local-first query
  final localDue = await syncEngine.getDueReviewsLocal(
    userId: userId,
    languageCode: courseState.queryLanguageCode,
  );
  if (localDue.isNotEmpty) {
    return localDue.length;
  }

  final supabaseService = ref.watch(supabaseServiceProvider);
  final items = await supabaseService.fetchDueSrsItems(userId: userId);
  return items.length;
}

@riverpod
class SrsLessonController extends _$SrsLessonController {
  @override
  AsyncValue<SrsLessonDeck> build() {
    return const AsyncValue.loading();
  }

  Future<void> loadLessonDeck({
    required String topic,
    String? targetLanguage,
    bool isSrsReviewSession = false,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final userProfile = ref.read(currentUserProfileProvider).asData?.value;
      final userId = userProfile?.id ?? 'local_user';
      final supabaseService = ref.read(supabaseServiceProvider);
      final syncEngine = ref.read(syncEngineServiceProvider);
      final courseState = ref.read(courseStateNotifierProvider);

      final queryLangCode = courseState.queryLanguageCode;

      // Fetch sentence pairs (microlesson limit of 10)
      List<SentencePair> pairs = await supabaseService.fetchSentencePairs(
        topicCategory: topic,
        languageCode: queryLangCode,
        limit: 10,
      );

      // Persist fetched pairs into local SQLite
      if (pairs.isNotEmpty) {
        await syncEngine.saveSentencePairs(pairs);
      }

      // Fetch due SRS items for current user
      final dueItems = await supabaseService.fetchDueSrsItems(userId: userId);
      final Map<String, SrsReviewItem> srsMap = {
        for (var item in dueItems) item.sentenceId: item
      };

      if (isSrsReviewSession) {
        List<SentencePair> reviewPairs = [];
        for (var srsItem in dueItems) {
          final pair = await supabaseService.fetchSentencePairById(srsItem.sentenceId);
          if (pair != null && pair.languageCode == queryLangCode) {
            reviewPairs.add(pair);
          }
        }
        if (reviewPairs.isNotEmpty) {
          final practicePairs = await supabaseService.fetchSentencePairs(
            topicCategory: 'Basics: Saying hello and goodbye',
            languageCode: queryLangCode,
            limit: 10,
          );
          final combined = [...reviewPairs];
          for (var p in practicePairs) {
            if (!combined.any((item) => item.id == p.id)) {
              combined.add(p);
            }
          }
          pairs = combined;
        } else {
          pairs = await supabaseService.fetchSentencePairs(
            topicCategory: 'Basics: Saying hello and goodbye',
            languageCode: queryLangCode,
            limit: 10,
          );
        }
      } else if (dueItems.isNotEmpty) {
        final duePairsForTopic = <SentencePair>[];
        for (var srsItem in dueItems) {
          final pair = await supabaseService.fetchSentencePairById(srsItem.sentenceId);
          if (pair != null &&
              pair.languageCode == queryLangCode &&
              !pairs.any((p) => p.id == pair.id)) {
            duePairsForTopic.add(pair);
          }
        }
        pairs = [...duePairsForTopic, ...pairs];
      }

      if (pairs.length > 10) {
        pairs = pairs.take(10).toList();
      }

      return SrsLessonDeck(
        topic: topic,
        targetLanguage: courseState.targetLanguage,
        sentencePairs: pairs,
        existingSrsItems: srsMap,
        isSrsReviewSession: isSrsReviewSession,
      );
    });
  }

  Future<void> recordAnswer({
    required SentencePair sentencePair,
    required int grade,
  }) async {
    final userProfile = ref.read(currentUserProfileProvider).asData?.value;
    final userId = userProfile?.id ?? 'local_user';
    final syncEngine = ref.read(syncEngineServiceProvider);

    // 1. Record local-first into Drift SQLite & queue background sync
    await syncEngine.recordAnswerLocalFirst(
      userId: userId,
      pair: sentencePair,
      grade: grade,
    );

    // 2. Update memory state
    final currentDeck = state.value;
    final existingItem = currentDeck?.existingSrsItems[sentencePair.id] ??
        SrsReviewItem(
          id: 'srs_${sentencePair.id}',
          userId: userId,
          sentenceId: sentencePair.id,
          nextReviewDate: DateTime.now(),
          intervalDays: 0,
          easeFactor: 2.5,
          consecutiveCorrect: 0,
        );

    final updatedSrsItem = SrsEngine.calculateNextReview(
      item: existingItem,
      grade: grade,
    );

    if (currentDeck != null) {
      final updatedMap = Map<String, SrsReviewItem>.from(currentDeck.existingSrsItems);
      updatedMap[sentencePair.id] = updatedSrsItem;
      state = AsyncValue.data(SrsLessonDeck(
        topic: currentDeck.topic,
        targetLanguage: currentDeck.targetLanguage,
        sentencePairs: currentDeck.sentencePairs,
        existingSrsItems: updatedMap,
        isSrsReviewSession: currentDeck.isSrsReviewSession,
      ));
    }

    ref.invalidate(dueSrsCountProvider);
  }

  Future<void> finishLesson({
    required String topic,
    int heartsRemaining = 5,
  }) async {
    final currentDeck = state.value;
    final isReview = currentDeck?.isSrsReviewSession ?? false;
    final xpEarned = isReview ? 30 : 25;
    final accuracyPercent = ((heartsRemaining / 5) * 100).round();

    final authNotifier = ref.read(authNotifierProvider.notifier);
    await authNotifier.completeLesson(
      topic: topic,
      xpEarned: xpEarned,
      isReview: isReview,
    );

    // Record progress on daily quests
    final questNotifier = ref.read(questControllerProvider.notifier);
    await questNotifier.recordLessonProgress(
      isReview: isReview,
      accuracyPercent: accuracyPercent,
      xpEarned: xpEarned,
    );

    ref.invalidate(currentUserProfileProvider);
    ref.invalidate(leagueControllerProvider);
  }
}
