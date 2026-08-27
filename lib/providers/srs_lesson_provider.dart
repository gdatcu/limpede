import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/srs_models.dart';
import '../providers/auth_provider.dart';
import '../providers/course_provider.dart';
import '../providers/league_provider.dart';
import '../providers/quest_provider.dart';
import '../services/services.dart';
import '../services/srs_engine.dart';

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
Future<int> dueSrsCount(Ref ref) async {
  final userProfile = ref.watch(currentUserProfileProvider).asData?.value;
  final userId = userProfile?.id ?? 'local_user';
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
      final courseState = ref.read(courseStateNotifierProvider);

      // Query language code based on mode:
      // isReverseMode == false (English -> Foreign): query targetLanguage code (e.g. 'de')
      // isReverseMode == true (Foreign -> English): query nativeLanguage code (e.g. 'ro')
      final queryLangCode = courseState.queryLanguageCode;

      // Fetch deterministic sentence pairs for selected topic (microlesson limit of 10)
      List<SentencePair> pairs = await supabaseService.fetchSentencePairs(
        topicCategory: topic,
        languageCode: queryLangCode,
        limit: 10,
      );

      // Fetch due SRS items for current user
      final dueItems = await supabaseService.fetchDueSrsItems(userId: userId);
      final Map<String, SrsReviewItem> srsMap = {
        for (var item in dueItems) item.sentenceId: item
      };

      if (isSrsReviewSession) {
        // Build dedicated review deck using due sentence pairs for active query language
        List<SentencePair> reviewPairs = [];
        for (var srsItem in dueItems) {
          final pair = await supabaseService.fetchSentencePairById(srsItem.sentenceId);
          if (pair != null && pair.languageCode == queryLangCode) {
            reviewPairs.add(pair);
          }
        }
        if (reviewPairs.isNotEmpty) {
          // Fill deck with extra practice pairs from general topic if due items < 5
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
          // If no due items exist, load general practice pairs for the active query language
          pairs = await supabaseService.fetchSentencePairs(
            topicCategory: 'Basics: Saying hello and goodbye',
            languageCode: queryLangCode,
            limit: 10,
          );
        }
      } else if (dueItems.isNotEmpty) {
        // Mix in due SRS items matching active query language ONLY
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
    final supabaseService = ref.read(supabaseServiceProvider);

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

    await supabaseService.upsertSrsReviewItem(updatedSrsItem);

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
