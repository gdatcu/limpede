import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/mascot_character.dart';
import '../utils/mascot_dialogue_engine.dart';

class MascotState {
  final MascotCharacter character;
  final MascotMood mood;
  final Offset gazeTarget; // (-1.0 to 1.0)
  final String? speechQuote;
  final int tapCount;
  final int comboStreak;

  const MascotState({
    required this.character,
    this.mood = MascotMood.idle,
    this.gazeTarget = Offset.zero,
    this.speechQuote,
    this.tapCount = 0,
    this.comboStreak = 0,
  });

  MascotState copyWith({
    MascotCharacter? character,
    MascotMood? mood,
    Offset? gazeTarget,
    String? speechQuote,
    bool clearSpeech = false,
    int? tapCount,
    int? comboStreak,
  }) {
    return MascotState(
      character: character ?? this.character,
      mood: mood ?? this.mood,
      gazeTarget: gazeTarget ?? this.gazeTarget,
      speechQuote: clearSpeech ? null : (speechQuote ?? this.speechQuote),
      tapCount: tapCount ?? this.tapCount,
      comboStreak: comboStreak ?? this.comboStreak,
    );
  }
}

class MascotStateNotifier extends StateNotifier<MascotState> {
  static const String _prefKey = 'pref_active_mascot_id';
  Timer? _speechTimer;
  Timer? _moodResetTimer;
  Timer? _tapWindowTimer;

  MascotStateNotifier()
      : super(const MascotState(character: MascotCharacter.pede)) {
    _loadSavedCompanion();
  }

  Future<void> _loadSavedCompanion() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedIdStr = prefs.getString(_prefKey);
      if (savedIdStr != null) {
        final mascot = MascotCharacter.fromString(savedIdStr);
        state = state.copyWith(character: mascot);
      }
    } catch (_) {}
  }

  /// Switch the active companion and persist choice
  Future<void> selectMascot(MascotId id) async {
    final mascot = MascotCharacter.fromId(id);
    state = state.copyWith(character: mascot, mood: MascotMood.celebrating);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefKey, id.name);
    } catch (_) {}

    say(
      MascotDialogueEngine.getQuote(
        mascotId: id,
        trigger: MascotDialogueTrigger.idleTap,
      ),
      duration: const Duration(milliseconds: 3000),
    );

    _scheduleMoodReset(const Duration(milliseconds: 2000));
  }

  /// Set the continuous gaze target Offset(-1.0 to 1.0)
  void setGaze(Offset normalized) {
    final clamped = Offset(
      normalized.dx.clamp(-1.0, 1.0),
      normalized.dy.clamp(-1.0, 1.0),
    );
    state = state.copyWith(gazeTarget: clamped);
  }

  /// Set mood directly with optional auto-revert to idle
  void setMood(MascotMood newMood, {Duration? resetAfter}) {
    state = state.copyWith(mood: newMood);
    if (resetAfter != null) {
      _scheduleMoodReset(resetAfter);
    }
  }

  /// Trigger speech bubble with auto-dismiss
  void say(String quote, {Duration duration = const Duration(milliseconds: 3500)}) {
    _speechTimer?.cancel();
    state = state.copyWith(speechQuote: quote);
    _speechTimer = Timer(duration, () {
      if (mounted) {
        state = state.copyWith(clearSpeech: true);
      }
    });
  }

  /// Handle direct user tap on the mascot (giggles, spins, or dizzy if spammed)
  void onTapMascot({String nativeLanguage = 'English'}) {
    final currentTaps = state.tapCount + 1;
    _tapWindowTimer?.cancel();
    _tapWindowTimer = Timer(const Duration(milliseconds: 1500), () {
      if (mounted) state = state.copyWith(tapCount: 0);
    });

    if (currentTaps >= 5) {
      // Dizzy state from rapid tapping!
      state = state.copyWith(
        mood: MascotMood.dizzy,
        tapCount: 0,
      );
      say(
        state.character.id == MascotId.nyx
            ? 'Okay, now I\'m actually dizzy. Stop it. 🌀'
            : 'Whoaaa! Everything is spinning! 💫🌀',
        duration: const Duration(milliseconds: 2500),
      );
      _scheduleMoodReset(const Duration(milliseconds: 2800));
      return;
    }

    // Normal tap: celebrate/giggle and say idle quote
    state = state.copyWith(
      mood: MascotMood.celebrating,
      tapCount: currentTaps,
    );

    final quote = MascotDialogueEngine.getQuote(
      mascotId: state.character.id,
      trigger: MascotDialogueTrigger.idleTap,
      nativeLanguage: nativeLanguage,
    );
    say(quote, duration: const Duration(milliseconds: 3200));
    _scheduleMoodReset(const Duration(milliseconds: 1800));
  }

  /// Trigger answer result feedback in lessons / SRS reviews
  void triggerAnswerResult({
    required bool isCorrect,
    required int comboStreak,
    Duration responseTime = const Duration(seconds: 4),
    String nativeLanguage = 'English',
  }) {
    state = state.copyWith(comboStreak: comboStreak);

    if (isCorrect) {
      // Check for speed bonus (< 2.8 seconds)
      final isSpeedy = responseTime < const Duration(milliseconds: 2800);

      MascotDialogueTrigger trigger;
      if (comboStreak >= 10) {
        trigger = MascotDialogueTrigger.streak10;
        state = state.copyWith(mood: MascotMood.streakFire);
      } else if (comboStreak >= 5) {
        trigger = MascotDialogueTrigger.streak5;
        state = state.copyWith(mood: MascotMood.streakFire);
      } else if (comboStreak >= 3) {
        trigger = MascotDialogueTrigger.streak3;
        state = state.copyWith(mood: MascotMood.celebrating);
      } else if (isSpeedy) {
        trigger = MascotDialogueTrigger.speedBonus;
        state = state.copyWith(mood: MascotMood.celebrating);
      } else {
        trigger = MascotDialogueTrigger.correctAnswer;
        state = state.copyWith(mood: MascotMood.celebrating);
      }

      final quote = MascotDialogueEngine.getQuote(
        mascotId: state.character.id,
        trigger: trigger,
        nativeLanguage: nativeLanguage,
        customStreak: comboStreak,
      );
      say(quote, duration: const Duration(milliseconds: 3000));
      _scheduleMoodReset(const Duration(milliseconds: 2200));
    } else {
      // Wrong answer
      state = state.copyWith(
        mood: MascotMood.sympathetic,
        comboStreak: 0,
      );

      final quote = MascotDialogueEngine.getQuote(
        mascotId: state.character.id,
        trigger: MascotDialogueTrigger.wrongAnswer,
        nativeLanguage: nativeLanguage,
      );
      say(quote, duration: const Duration(milliseconds: 3500));
      _scheduleMoodReset(const Duration(milliseconds: 2500));
    }
  }

  /// Trigger a specialized event (e.g. lessonStart, lessonComplete, matchMadness)
  void triggerEvent(
    MascotDialogueTrigger trigger, {
    String nativeLanguage = 'English',
    Duration duration = const Duration(milliseconds: 3500),
  }) {
    switch (trigger) {
      case MascotDialogueTrigger.lessonStart:
        state = state.copyWith(mood: MascotMood.anticipating);
        _scheduleMoodReset(const Duration(milliseconds: 3000));
        break;
      case MascotDialogueTrigger.lessonComplete:
        state = state.copyWith(mood: MascotMood.streakFire);
        _scheduleMoodReset(const Duration(milliseconds: 4000));
        break;
      case MascotDialogueTrigger.matchMadness:
        state = state.copyWith(mood: MascotMood.streakFire);
        _scheduleMoodReset(const Duration(milliseconds: 3000));
        break;
      case MascotDialogueTrigger.mistakesWorkout:
        state = state.copyWith(mood: MascotMood.thinking);
        _scheduleMoodReset(const Duration(milliseconds: 3000));
        break;
      default:
        state = state.copyWith(mood: MascotMood.idle);
        break;
    }

    final quote = MascotDialogueEngine.getQuote(
      mascotId: state.character.id,
      trigger: trigger,
      nativeLanguage: nativeLanguage,
    );
    say(quote, duration: duration);
  }

  void _scheduleMoodReset(Duration delay) {
    _moodResetTimer?.cancel();
    _moodResetTimer = Timer(delay, () {
      if (mounted) {
        state = state.copyWith(mood: MascotMood.idle);
      }
    });
  }

  @override
  void dispose() {
    _speechTimer?.cancel();
    _moodResetTimer?.cancel();
    _tapWindowTimer?.cancel();
    super.dispose();
  }
}

final mascotStateNotifierProvider =
    StateNotifierProvider<MascotStateNotifier, MascotState>((ref) {
  return MascotStateNotifier();
});
