import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:limpede/models/srs_models.dart';
import 'package:limpede/providers/match_madness_provider.dart';

void main() {
  group('Match Madness Blitz Mode Tests', () {
    final testPairs = List.generate(
      10,
      (i) => SentencePair(
        id: 'pair_$i',
        sourceText: 'Source $i',
        targetText: 'Target $i',
        languageCode: 'es',
        topicCategory: 'Greetings',
        difficultyLevel: 'A1',
      ),
    );

    test('Initializes with 60 seconds and 5 pairs (10 tiles)', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final controller = container.read(matchMadnessControllerProvider.notifier);
      controller.startBlitz(testPairs);

      final state = container.read(matchMadnessControllerProvider);
      expect(state.timeRemainingSeconds, 60);
      expect(state.sourceTiles.length, 5);
      expect(state.targetTiles.length, 5);
      expect(state.score, 0);
      expect(state.multiplier, 1.0);
    });

    test('Correct match increases score, total matches, and combo multiplier', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final controller = container.read(matchMadnessControllerProvider.notifier);
      controller.startBlitz(testPairs);

      // Perform 3 correct matches
      for (int i = 0; i < 3; i++) {
        final state = container.read(matchMadnessControllerProvider);
        final source = state.sourceTiles.first;
        final target = state.targetTiles.firstWhere((t) => t.pairId == source.pairId);

        controller.selectTile(source);
        controller.selectTile(target);
      }

      final stateAfter = container.read(matchMadnessControllerProvider);
      expect(stateAfter.totalMatches, 3);
      expect(stateAfter.comboStreak, 3);
      expect(stateAfter.multiplier, 1.5);
      expect(stateAfter.score, greaterThan(0));
    });

    test('Wrong match resets combo streak to 0 and multiplier to 1.0', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final controller = container.read(matchMadnessControllerProvider.notifier);
      controller.startBlitz(testPairs);

      // 1 correct match
      final state = container.read(matchMadnessControllerProvider);
      final source = state.sourceTiles.first;
      final targetCorrect = state.targetTiles.firstWhere((t) => t.pairId == source.pairId);

      controller.selectTile(source);
      controller.selectTile(targetCorrect);

      expect(container.read(matchMadnessControllerProvider).comboStreak, 1);

      // 1 wrong match
      final state2 = container.read(matchMadnessControllerProvider);
      final source2 = state2.sourceTiles.first;
      final targetWrong = state2.targetTiles.firstWhere((t) => t.pairId != source2.pairId);

      controller.selectTile(source2);
      controller.selectTile(targetWrong);

      final stateAfterWrong = container.read(matchMadnessControllerProvider);
      expect(stateAfterWrong.comboStreak, 0);
      expect(stateAfterWrong.multiplier, 1.0);
    });
  });
}
