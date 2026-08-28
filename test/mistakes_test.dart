import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:limpede/models/srs_models.dart';
import 'package:limpede/providers/mistake_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('Mistakes Inbox & Smart Review Tests', () {
    const pair1 = SentencePair(
      id: 'mistake_1',
      sourceText: 'I have a cat',
      targetText: 'Tengo un gato',
      languageCode: 'es',
      topicCategory: 'Animals',
      difficultyLevel: 'A1',
    );

    const pair2 = SentencePair(
      id: 'mistake_2',
      sourceText: 'She is my sister',
      targetText: 'Ella es mi hermana',
      languageCode: 'es',
      topicCategory: 'Family',
      difficultyLevel: 'A1',
    );

    test('Records mistakes and avoids duplicates', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(mistakeNotifierProvider.notifier);
      await notifier.recordMistake(pair1);
      await notifier.recordMistake(pair1); // Duplicate attempt

      final mistakes = container.read(mistakeNotifierProvider).value;
      expect(mistakes, isNotNull);
      expect(mistakes!.length, 1);
      expect(mistakes.first.id, 'mistake_1');
    });

    test('Resolves mistakes upon correct answer', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(mistakeNotifierProvider.notifier);
      await notifier.recordMistake(pair1);
      await notifier.recordMistake(pair2);

      expect(container.read(mistakeNotifierProvider).value!.length, 2);

      // Resolve pair1
      await notifier.resolveMistake('mistake_1');
      final remaining = container.read(mistakeNotifierProvider).value!;
      expect(remaining.length, 1);
      expect(remaining.first.id, 'mistake_2');
    });

    test('Clears all mistakes', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(mistakeNotifierProvider.notifier);
      await notifier.recordMistake(pair1);
      await notifier.recordMistake(pair2);
      await notifier.clearAllMistakes();

      expect(container.read(mistakeNotifierProvider).value!.isEmpty, true);
    });
  });
}
