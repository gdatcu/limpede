import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/achievement.dart';
import '../providers/auth_provider.dart';

part 'achievement_provider.g.dart';

@riverpod
class AchievementNotifier extends _$AchievementNotifier {
  static const _claimedKey = 'user_claimed_achievements_v1';

  @override
  Future<List<Achievement>> build() async {
    final userProfile = ref.watch(currentUserProfileProvider).asData?.value;
    final claimedIds = await _loadClaimedIds();

    final streak = userProfile?.streak ?? 0;
    final xp = userProfile?.xp ?? 0;
    final leagueTier = (userProfile?.leagueTier ?? 'bronze').toLowerCase();

    // Map league tier to level
    int leagueTierLevel = 1;
    if (leagueTier == 'silver') leagueTierLevel = 2;
    if (leagueTier == 'gold') leagueTierLevel = 3;
    if (leagueTier == 'obsidian') leagueTierLevel = 4;
    if (leagueTier == 'diamond') leagueTierLevel = 5;

    return [
      Achievement(
        id: 'streak_flame',
        title: 'Flame Keeper',
        description: 'Maintain an active study streak of 7 days',
        iconEmoji: '🔥',
        currentValue: streak,
        targetValue: 7,
        tier: streak >= 7 ? 2 : 1,
        maxTier: 3,
        dropletReward: 20,
        isClaimed: claimedIds.contains('streak_flame'),
      ),
      Achievement(
        id: 'xp_titan',
        title: 'XP Titan',
        description: 'Accumulate 250 total learning XP',
        iconEmoji: '⚡',
        currentValue: xp,
        targetValue: 250,
        tier: xp >= 250 ? 2 : 1,
        maxTier: 3,
        dropletReward: 25,
        isClaimed: claimedIds.contains('xp_titan'),
      ),
      Achievement(
        id: 'polyglot_wordsmith',
        title: 'Polyglot Mind',
        description: 'Earn 100 XP from vocabulary drills',
        iconEmoji: '📚',
        currentValue: xp,
        targetValue: 100,
        tier: xp >= 100 ? 2 : 1,
        maxTier: 3,
        dropletReward: 15,
        isClaimed: claimedIds.contains('polyglot_wordsmith'),
      ),
      Achievement(
        id: 'league_conqueror',
        title: 'League Conqueror',
        description: 'Promote to Silver League or higher',
        iconEmoji: '👑',
        currentValue: leagueTierLevel,
        targetValue: 2,
        tier: leagueTierLevel >= 2 ? 2 : 1,
        maxTier: 4,
        dropletReward: 30,
        isClaimed: claimedIds.contains('league_conqueror'),
      ),
      Achievement(
        id: 'ear_master',
        title: 'Golden Ear',
        description: 'Reach a 3-day listening & practice streak',
        iconEmoji: '👂',
        currentValue: streak >= 3 ? 3 : streak,
        targetValue: 3,
        tier: 1,
        maxTier: 2,
        dropletReward: 15,
        isClaimed: claimedIds.contains('ear_master'),
      ),
    ];
  }

  Future<Set<String>> _loadClaimedIds() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final list = prefs.getStringList(_claimedKey);
      return list?.toSet() ?? {};
    } catch (e) {
      debugPrint('Error loading claimed achievements: $e');
      return {};
    }
  }

  Future<void> claimAchievement(String id) async {
    final currentList = state.value ?? [];
    final achievement = currentList.firstWhere((a) => a.id == id);

    if (!achievement.isUnlocked || achievement.isClaimed) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      final claimed = await _loadClaimedIds();
      claimed.add(id);
      await prefs.setStringList(_claimedKey, claimed.toList());

      // Credit droplets/gems to user profile
      final userProfile = ref.read(currentUserProfileProvider).asData?.value;
      if (userProfile != null) {
        final currentGems = userProfile.gems;
        final updatedProfile = userProfile.copyWith(
          gems: currentGems + achievement.dropletReward,
        );
        final supabaseService = ref.read(supabaseServiceProvider);
        await supabaseService.upsertUserProfile(updatedProfile);
        ref.invalidate(currentUserProfileProvider);
      }

      // Update state in memory
      final updatedList = currentList.map((a) {
        if (a.id == id) {
          return a.copyWith(isClaimed: true);
        }
        return a;
      }).toList();

      state = AsyncValue.data(updatedList);
    } catch (e) {
      debugPrint('Error claiming achievement: $e');
    }
  }
}
