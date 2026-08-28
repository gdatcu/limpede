import 'package:flutter_test/flutter_test.dart';
import 'package:limpede/models/mascot_character.dart';
import 'package:limpede/providers/mascot_state_controller.dart';
import 'package:limpede/utils/mascot_dialogue_engine.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Mascot Squad & Model Tests', () {
    test('Catalog contains all 5 distinct mascots', () {
      expect(MascotCharacter.allMascots.length, 5);

      final ids = MascotCharacter.allMascots.map((m) => m.id).toSet();
      expect(ids, {
        MascotId.pede,
        MascotId.nyx,
        MascotId.volta,
        MascotId.kora,
        MascotId.boba,
      });

      // Verify Pede is configured properly
      const pede = MascotCharacter.pede;
      expect(pede.name, 'Pede');
      expect(pede.emoji, contains('⚡'));
      expect(pede.headFeature, MascotHeadFeature.lightningAntenna);
    });

    test('MascotCharacter.fromString fallback and matching', () {
      expect(MascotCharacter.fromString('nyx').id, MascotId.nyx);
      expect(MascotCharacter.fromString('VOLTA').id, MascotId.volta);
      expect(MascotCharacter.fromString('unknown_id').id, MascotId.pede);
      expect(MascotCharacter.fromString(null).id, MascotId.pede);
    });
  });

  group('Mascot Dialogue Engine Tests', () {
    test('Generates quotes for all mascots and triggers in English and Romanian', () {
      for (final mascot in MascotCharacter.allMascots) {
        for (final trigger in MascotDialogueTrigger.values) {
          final enQuote = MascotDialogueEngine.getQuote(
            mascotId: mascot.id,
            trigger: trigger,
            nativeLanguage: 'English',
          );
          expect(enQuote, isNotEmpty);

          final roQuote = MascotDialogueEngine.getQuote(
            mascotId: mascot.id,
            trigger: trigger,
            nativeLanguage: 'Romanian',
          );
          expect(roQuote, isNotEmpty);
        }
      }
    });

    test('Personality differentiation between mascots', () {
      final nyxQuote = MascotDialogueEngine.getQuote(
        mascotId: MascotId.nyx,
        trigger: MascotDialogueTrigger.correctAnswer,
      );
      expect(nyxQuote, anyOf(contains('impressed'), contains('acceptable'), contains('bad'), contains('paying attention')));

      final voltaQuote = MascotDialogueEngine.getQuote(
        mascotId: MascotId.volta,
        trigger: MascotDialogueTrigger.streak5,
      );
      expect(voltaQuote, anyOf(contains('5'), contains('CINEMA'), contains('STREAK'), contains('🔥')));
    });
  });

  group('Mascot State Controller Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('Default initial state is Pede and Idle', () {
      final controller = MascotStateNotifier();
      addTearDown(controller.dispose);

      expect(controller.state.character.id, MascotId.pede);
      expect(controller.state.mood, MascotMood.idle);
      expect(controller.state.gazeTarget.dx, 0.0);
    });

    test('Switches active mascot and triggers celebration', () async {
      final controller = MascotStateNotifier();
      addTearDown(controller.dispose);

      await controller.selectMascot(MascotId.nyx);

      expect(controller.state.character.id, MascotId.nyx);
      expect(controller.state.mood, MascotMood.celebrating);
      expect(controller.state.speechQuote, isNotNull);
    });

    test('Trigger answer result updates streak and mood', () {
      final controller = MascotStateNotifier();
      addTearDown(controller.dispose);

      // Correct answer with streak 5
      controller.triggerAnswerResult(
        isCorrect: true,
        comboStreak: 5,
        responseTime: const Duration(seconds: 2),
      );

      expect(controller.state.comboStreak, 5);
      expect(controller.state.mood, MascotMood.streakFire);
      expect(controller.state.speechQuote, isNotNull);

      // Wrong answer resets streak
      controller.triggerAnswerResult(
        isCorrect: false,
        comboStreak: 0,
        responseTime: const Duration(seconds: 4),
      );

      expect(controller.state.comboStreak, 0);
      expect(controller.state.mood, MascotMood.sympathetic);
    });

    test('Rapid tapping triggers dizzy state', () {
      final controller = MascotStateNotifier();
      addTearDown(controller.dispose);

      // Tap 5 times rapidly
      for (int i = 0; i < 5; i++) {
        controller.onTapMascot();
      }

      expect(controller.state.mood, MascotMood.dizzy);
      expect(controller.state.speechQuote, contains('spinning'));
    });
  });
}
