import 'package:flutter_test/flutter_test.dart';
import 'package:limpede/models/league.dart';
import 'package:limpede/models/quest.dart';
import 'package:limpede/models/user_profile.dart';

void main() {
  group('Gamification: League Tier & Cohort Tests', () {
    test('LeagueTier string parsing and hierarchy', () {
      expect(LeagueTier.fromString('bronze'), LeagueTier.bronze);
      expect(LeagueTier.fromString('Silver'), LeagueTier.silver);
      expect(LeagueTier.fromString('gold'), LeagueTier.gold);
      expect(LeagueTier.fromString('OBSIDIAN'), LeagueTier.obsidian);
      expect(LeagueTier.fromString('diamond'), LeagueTier.diamond);
      expect(LeagueTier.fromString('unknown'), LeagueTier.bronze);

      expect(LeagueTier.bronze.nextTier, LeagueTier.silver);
      expect(LeagueTier.silver.nextTier, LeagueTier.gold);
      expect(LeagueTier.diamond.nextTier, isNull);
      expect(LeagueTier.bronze.previousTier, isNull);
    });

    test('LeagueMember zone calculations (Top 7 promote, Bottom 5 demote)', () {
      const topMember = LeagueMember(
        userId: 'user_1',
        username: 'Elena',
        weeklyXp: 150,
        rank: 1,
        tier: LeagueTier.silver,
      );
      expect(topMember.zone, LeagueZone.promotion);

      const rank7Member = LeagueMember(
        userId: 'user_7',
        username: 'Lucas',
        weeklyXp: 90,
        rank: 7,
        tier: LeagueTier.silver,
      );
      expect(rank7Member.zone, LeagueZone.promotion);

      const safeMember = LeagueMember(
        userId: 'user_12',
        username: 'Marc',
        weeklyXp: 50,
        rank: 12,
        tier: LeagueTier.silver,
      );
      expect(safeMember.zone, LeagueZone.safe);

      const bottomMember = LeagueMember(
        userId: 'user_28',
        username: 'Alex',
        weeklyXp: 10,
        rank: 28,
        tier: LeagueTier.silver,
      );
      expect(bottomMember.zone, LeagueZone.demotion);

      // Bronze tier should not demote
      const bronzeBottomMember = LeagueMember(
        userId: 'user_30',
        username: 'Novice',
        weeklyXp: 0,
        rank: 30,
        tier: LeagueTier.bronze,
      );
      expect(bronzeBottomMember.zone, LeagueZone.safe);
    });
  });

  group('Gamification: Daily Quests Tests', () {
    test('DailyQuest progress and completion ratio', () {
      const quest = DailyQuest(
        id: 'quest_xp',
        type: QuestType.earnXp,
        title: 'Earn 50 XP',
        description: 'Earn 50 XP today',
        currentProgress: 25,
        targetProgress: 50,
        xpReward: 25,
        gemReward: 15,
      );

      expect(quest.isCompleted, isFalse);
      expect(quest.progressRatio, 0.5);

      final completedQuest = quest.copyWith(currentProgress: 50);
      expect(completedQuest.isCompleted, isTrue);
      expect(completedQuest.progressRatio, 1.0);
    });

    test('DailyQuest JSON serialization and deserialization', () {
      const quest = DailyQuest(
        id: 'quest_reviews',
        type: QuestType.completeReviews,
        title: 'Daily Review Mastery',
        description: 'Complete 2 SRS reviews',
        currentProgress: 2,
        targetProgress: 2,
        xpReward: 15,
        gemReward: 10,
        isClaimed: true,
      );

      final json = quest.toJson();
      final fromJson = DailyQuest.fromJson(json);

      expect(fromJson.id, 'quest_reviews');
      expect(fromJson.type, QuestType.completeReviews);
      expect(fromJson.isCompleted, isTrue);
      expect(fromJson.isClaimed, isTrue);
      expect(fromJson.gemReward, 10);
    });
  });

  group('Gamification: UserProfile Model Extensions', () {
    test('UserProfile defaults and custom fields', () {
      const profile = UserProfile(
        id: 'user_abc',
        username: 'Learner',
      );

      expect(profile.gems, 50);
      expect(profile.streakFreezes, 0);
      expect(profile.weeklyXp, 0);
      expect(profile.leagueTier, 'bronze');

      final equipped = profile.copyWith(
        gems: 150,
        streakFreezes: 2,
        weeklyXp: 85,
        leagueTier: 'gold',
      );

      expect(equipped.gems, 150);
      expect(equipped.streakFreezes, 2);
      expect(equipped.weeklyXp, 85);
      expect(equipped.leagueTier, 'gold');
    });
  });
}
