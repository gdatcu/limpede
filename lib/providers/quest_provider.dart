import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/quest.dart';
import 'auth_provider.dart';
import 'feedback_provider.dart';
import 'league_provider.dart';

part 'quest_provider.g.dart';

@Riverpod(keepAlive: true)
class QuestController extends _$QuestController {
  String _todayDateKey() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  String get _storageKey => 'daily_quests_${_todayDateKey()}';

  @override
  Future<List<DailyQuest>> build() async {
    return _loadDailyQuests();
  }

  List<DailyQuest> _defaultQuests() {
    return const [
      DailyQuest(
        id: 'quest_reviews',
        type: QuestType.completeReviews,
        title: 'Daily Review Mastery',
        description: 'Complete 2 Daily Review sessions',
        currentProgress: 0,
        targetProgress: 2,
        xpReward: 15,
        gemReward: 10,
      ),
      DailyQuest(
        id: 'quest_accuracy',
        type: QuestType.scoreAccuracy,
        title: 'Flawless Accuracy',
        description: 'Score 90%+ in any standard lesson',
        currentProgress: 0,
        targetProgress: 1,
        xpReward: 20,
        gemReward: 10,
      ),
      DailyQuest(
        id: 'quest_xp',
        type: QuestType.earnXp,
        title: 'XP Powerhouse',
        description: 'Earn 50 XP today',
        currentProgress: 0,
        targetProgress: 50,
        xpReward: 25,
        gemReward: 15,
      ),
    ];
  }

  Future<List<DailyQuest>> _loadDailyQuests() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonStr = prefs.getString(_storageKey);
      if (jsonStr != null && jsonStr.isNotEmpty) {
        final List<dynamic> decoded = jsonDecode(jsonStr) as List<dynamic>;
        return decoded
            .map((j) => DailyQuest.fromJson(j as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      debugPrint('Notice loading daily quests: $e');
    }
    return _defaultQuests();
  }

  Future<void> _saveQuests(List<DailyQuest> quests) async {
    state = AsyncValue.data(quests);
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonStr = jsonEncode(quests.map((q) => q.toJson()).toList());
      await prefs.setString(_storageKey, jsonStr);
    } catch (e) {
      debugPrint('Notice saving daily quests: $e');
    }
  }

  Future<void> incrementReviewCount() async {
    final current = state.value ?? _defaultQuests();
    final updated = current.map((q) {
      if (q.type == QuestType.completeReviews && !q.isCompleted) {
        return q.copyWith(currentProgress: q.currentProgress + 1);
      }
      return q;
    }).toList();
    await _saveQuests(updated);
  }

  Future<void> recordLessonProgress({
    required bool isReview,
    required int accuracyPercent,
    required int xpEarned,
  }) async {
    final current = state.value ?? _defaultQuests();
    final updated = current.map((q) {
      if (q.type == QuestType.completeReviews && isReview && !q.isCompleted) {
        return q.copyWith(currentProgress: q.currentProgress + 1);
      }
      if (q.type == QuestType.scoreAccuracy && accuracyPercent >= 90 && !q.isCompleted) {
        return q.copyWith(currentProgress: 1);
      }
      if (q.type == QuestType.earnXp && !q.isCompleted) {
        return q.copyWith(currentProgress: (q.currentProgress + xpEarned).clamp(0, q.targetProgress));
      }
      return q;
    }).toList();

    await _saveQuests(updated);
  }

  Future<bool> claimReward(String questId) async {
    final current = state.value ?? [];
    final questIndex = current.indexWhere((q) => q.id == questId);
    if (questIndex < 0) return false;

    final quest = current[questIndex];
    if (!quest.isCompleted || quest.isClaimed) return false;

    final user = ref.read(authNotifierProvider).value;
    final userId = user?.id ?? 'guest_local';

    final supabase = ref.read(supabaseServiceProvider);
    await supabase.claimQuestReward(
      userId: userId,
      gemReward: quest.gemReward,
      xpReward: quest.xpReward,
    );

    final feedback = ref.read(feedbackServiceProvider);
    feedback.playLevelUpFeedback();

    final updated = List<DailyQuest>.from(current);
    updated[questIndex] = quest.copyWith(isClaimed: true);
    await _saveQuests(updated);

    ref.invalidate(currentUserProfileProvider);
    ref.invalidate(leagueControllerProvider);
    return true;
  }
}
