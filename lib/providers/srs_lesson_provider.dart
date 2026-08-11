import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/srs_models.dart';
import '../providers/auth_provider.dart';
import '../services/services.dart';
import '../utils/language_utils.dart';
import 'user_provider.dart';

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
    required String targetLanguage,
    bool isSrsReviewSession = false,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final userProfile = ref.read(currentUserProfileProvider).asData?.value;
      final userId = userProfile?.id ?? 'local_user';
      final supabaseService = ref.read(supabaseServiceProvider);
      final normalizedLangCode = LanguageUtils.normalizeLanguageCode(targetLanguage);

      // Fetch deterministic sentence pairs for selected topic (microlesson limit of 10)
      List<SentencePair> pairs = await supabaseService.fetchSentencePairs(
        topicCategory: topic,
        languageCode: targetLanguage,
        limit: 10,
      );

      // Fetch due SRS items for current user
      final dueItems = await supabaseService.fetchDueSrsItems(userId: userId);
      final Map<String, SrsReviewItem> srsMap = {
        for (var item in dueItems) item.sentenceId: item
      };

      if (isSrsReviewSession) {
        // Build dedicated review deck using due sentence pairs for the current target language
        List<SentencePair> reviewPairs = [];
        for (var srsItem in dueItems) {
          final pair = await supabaseService.fetchSentencePairById(srsItem.sentenceId);
          if (pair != null && pair.languageCode == normalizedLangCode) {
            reviewPairs.add(pair);
          }
        }
        if (reviewPairs.isNotEmpty) {
          pairs = reviewPairs;
        }
      } else if (dueItems.isNotEmpty) {
        // Mix in due SRS items matching the selected target language ONLY
        final duePairsForTopic = <SentencePair>[];
        for (var srsItem in dueItems) {
          final pair = await supabaseService.fetchSentencePairById(srsItem.sentenceId);
          if (pair != null &&
              pair.languageCode == normalizedLangCode &&
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
        targetLanguage: targetLanguage,
        sentencePairs: pairs,
        existingSrsItems: srsMap,
        isSrsReviewSession: isSrsReviewSession,
      );
    });
  }

  bool _isValidUuid(String? id) {
    if (id == null) return false;
    final RegExp uuidRegExp = RegExp(
      r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
    );
    return uuidRegExp.hasMatch(id);
  }

  Future<void> recordAnswer({
    required SentencePair sentencePair,
    required int grade, // 0 = fail, 3 = hard, 5 = perfect
  }) async {
    final userProfile = ref.read(currentUserProfileProvider).asData?.value;
    final supabaseUser = ref.read(supabaseServiceProvider).currentUser;
    final userId = (userProfile != null && _isValidUuid(userProfile.id))
        ? userProfile.id
        : (supabaseUser != null ? supabaseUser.id : 'guest_local');
    final supabaseService = ref.read(supabaseServiceProvider);

    final currentData = state.asData?.value;
    final existingItem = currentData?.existingSrsItems[sentencePair.id] ??
        SrsReviewItem(
          sentenceId: sentencePair.id,
          userId: userId,
          nextReviewDate: DateTime.now(),
        );

    final updatedSrsItem = SrsEngine.calculateNextReview(
      item: existingItem,
      grade: grade,
    );

    // Save updated SRS metrics back to Supabase (and auto-seed sentence pair)
    await supabaseService.upsertSrsReviewItem(
      updatedSrsItem,
      sentencePair: sentencePair,
    );

    // Refresh due SRS count
    ref.invalidate(dueSrsCountProvider);
  }


  Future<void> finishLesson({required String topic, int xpEarned = 25}) async {
    final userProfile = ref.read(currentUserProfileProvider).asData?.value;
    final userId = userProfile?.id ?? 'local_user';
    final supabaseService = ref.read(supabaseServiceProvider);

    await supabaseService.completeLessonAndAwardXp(
      userId: userId,
      topic: topic,
      xpEarned: xpEarned,
    );

    ref.invalidate(dueSrsCountProvider);
    ref.invalidate(currentUserProfileProvider);
    ref.invalidate(completedTopicsProvider);
  }
}

