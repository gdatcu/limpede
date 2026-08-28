import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/friend_quest.dart';
import '../providers/auth_provider.dart';

part 'friend_quest_provider.g.dart';

@riverpod
class FriendQuestNotifier extends _$FriendQuestNotifier {
  static const _storageKey = 'limpede_active_friend_quest_v1';

  @override
  Future<FriendQuest> build() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_storageKey);

    if (jsonStr != null) {
      try {
        final map = jsonDecode(jsonStr) as Map<String, dynamic>;
        return FriendQuest.fromJson(map);
      } catch (e) {
        debugPrint('Error parsing saved friend quest: $e');
      }
    }

    // Default active cooperative mission
    const defaultQuest = FriendQuest(
      id: 'quest_warriors_w1',
      title: 'Duo Dynamo',
      description: 'Complete 25 lessons & drills together',
      partnerName: 'Elena R.',
      partnerEmoji: '👩‍🎨',
      userContribution: 8,
      partnerContribution: 12,
      targetGoal: 25,
      sharedStreakDays: 5,
      daysRemaining: 3,
      rewardDroplets: 25,
    );

    await _saveQuest(defaultQuest);
    return defaultQuest;
  }

  Future<void> _saveQuest(FriendQuest quest) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_storageKey, jsonEncode(quest.toJson()));
    } catch (e) {
      debugPrint('Error saving friend quest: $e');
    }
  }

  Future<void> incrementUserProgress([int amount = 1]) async {
    final current = state.value;
    if (current == null) return;

    final updated = current.copyWith(
      userContribution: current.userContribution + amount,
    );

    state = AsyncValue.data(updated);
    await _saveQuest(updated);
  }

  Future<void> sendHighFive() async {
    final current = state.value;
    if (current == null) return;

    final updated = current.copyWith(
      lastNudgeSentAt: DateTime.now(),
    );

    state = AsyncValue.data(updated);
    await _saveQuest(updated);
  }

  Future<void> claimReward() async {
    final current = state.value;
    if (current == null || !current.isCompleted || current.isClaimed) return;

    try {
      final userProfile = ref.read(currentUserProfileProvider).asData?.value;
      if (userProfile != null) {
        final updatedProfile = userProfile.copyWith(
          gems: userProfile.gems + current.rewardDroplets,
        );
        final supabase = ref.read(supabaseServiceProvider);
        await supabase.upsertUserProfile(updatedProfile);
        ref.invalidate(currentUserProfileProvider);
      }

      final updated = current.copyWith(isClaimed: true);
      state = AsyncValue.data(updated);
      await _saveQuest(updated);
    } catch (e) {
      debugPrint('Error claiming friend quest reward: $e');
    }
  }
}
