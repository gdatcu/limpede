import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:limpede/models/friend_quest.dart';
import 'package:limpede/providers/friend_quest_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('Friend Quests & Shared Streak Duos Tests', () {
    test('Combined progress and completion calculations', () {
      const quest = FriendQuest(
        id: 'test_quest',
        title: 'Duo Dynamo',
        description: 'Complete 25 lessons together',
        partnerName: 'Elena R.',
        userContribution: 10,
        partnerContribution: 10,
        targetGoal: 25,
      );

      expect(quest.totalProgress, 20);
      expect(quest.progressRatio, 0.8);
      expect(quest.isCompleted, false);

      final completedQuest = quest.copyWith(userContribution: 15);
      expect(completedQuest.totalProgress, 25);
      expect(completedQuest.progressRatio, 1.0);
      expect(completedQuest.isCompleted, true);
    });

    test('Increments user contribution', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final sub = container.listen(friendQuestNotifierProvider, (_, __) {});
      addTearDown(sub.close);

      final initial = await container.read(friendQuestNotifierProvider.future);
      final initialUserContribution = initial.userContribution;

      await container.read(friendQuestNotifierProvider.notifier).incrementUserProgress(2);

      final updated = await container.read(friendQuestNotifierProvider.future);
      expect(updated.userContribution, initialUserContribution + 2);
    });
  });
}
