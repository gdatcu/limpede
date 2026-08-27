import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class FeedbackService {
  final AudioPlayer _audioPlayer;
  bool soundEnabled;
  bool hapticEnabled;

  FeedbackService({
    AudioPlayer? audioPlayer,
    this.soundEnabled = true,
    this.hapticEnabled = true,
  }) : _audioPlayer = audioPlayer ?? AudioPlayer();

  Future<void> playCorrectFeedback() async {
    if (hapticEnabled) {
      await HapticFeedback.lightImpact();
    }
    if (soundEnabled) {
      try {
        await _audioPlayer.stop();
        await _audioPlayer.play(AssetSource('audio/correct.mp3'));
      } catch (_) {
        // Graceful fallback
      }
    }
  }

  Future<void> playWrongFeedback() async {
    if (hapticEnabled) {
      await HapticFeedback.heavyImpact();
    }
    if (soundEnabled) {
      try {
        await _audioPlayer.stop();
        await _audioPlayer.play(AssetSource('audio/wrong.mp3'));
      } catch (_) {
        // Graceful fallback
      }
    }
  }

  Future<void> playLevelUpFeedback() async {
    if (hapticEnabled) {
      await HapticFeedback.mediumImpact();
    }
    if (soundEnabled) {
      try {
        await _audioPlayer.stop();
        await _audioPlayer.play(AssetSource('audio/correct.mp3'));
      } catch (_) {
        // Graceful fallback
      }
    }
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
