import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:limpede/models/achievement.dart';
import 'package:limpede/models/user_profile.dart';
import 'package:limpede/providers/achievement_provider.dart';
import 'package:limpede/providers/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('Milestone Trophy Room & Achievement Tests', () {
    test('Achievement model progress calculations', () {
      const achievement = Achievement(
        id: 'test_streak',
        title: 'Flame Keeper',
        description: 'Reach a 7-day streak',
        iconEmoji: '🔥',
        currentValue: 5,
        targetValue: 7,
      );

      expect(achievement.isUnlocked, false);
      expect(achievement.progressRatio, closeTo(5 / 7, 0.01));

      final unlocked = achievement.copyWith(currentValue: 7);
      expect(unlocked.isUnlocked, true);
      expect(unlocked.progressRatio, 1.0);
    });

    test('Evaluates user profile stats into achievements', () async {
      const user = UserProfile(
        id: 'test_user',
        username: 'Alex',
        streak: 8,
        xp: 300,
        gems: 50,
        leagueTier: 'silver',
      );

      final container = ProviderContainer(
        overrides: [
          currentUserProfileProvider.overrideWith((ref) => user),
        ],
      );
      addTearDown(container.dispose);

      final sub = container.listen(achievementNotifierProvider, (_, __) {});
      addTearDown(sub.close);

      final achievements = await container.read(achievementNotifierProvider.future);
      expect(achievements, isNotEmpty);

      final streakAchievement = achievements.firstWhere((a) => a.id == 'streak_flame');
      expect(streakAchievement.currentValue, 8);
      expect(streakAchievement.isUnlocked, true);

      final xpAchievement = achievements.firstWhere((a) => a.id == 'xp_titan');
      expect(xpAchievement.currentValue, 300);
      expect(xpAchievement.isUnlocked, true);

      final leagueAchievement = achievements.firstWhere((a) => a.id == 'league_conqueror');
      expect(leagueAchievement.isUnlocked, true);
    });
  });
}
