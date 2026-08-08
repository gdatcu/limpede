import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isInitialized = false;

  Future<void> _initTts() async {
    if (_isInitialized) return;
    try {
      await _flutterTts.setSpeechRate(0.45);
      await _flutterTts.setVolume(1.0);
      await _flutterTts.setPitch(1.0);
      _isInitialized = true;
    } catch (e) {
      debugPrint('TTS Initialization Notice: $e');
    }
  }

  String _getLanguageCode(String targetLanguage) {
    final lang = targetLanguage.trim().toLowerCase();
    if (lang.contains('spanish') || lang.contains('es')) {
      return 'es-ES';
    } else if (lang.contains('french') || lang.contains('fr')) {
      return 'fr-FR';
    } else if (lang.contains('german') || lang.contains('de')) {
      return 'de-DE';
    } else if (lang.contains('japanese') || lang.contains('ja')) {
      return 'ja-JP';
    } else if (lang.contains('romanian') || lang.contains('ro')) {
      return 'ro-RO';
    } else {
      return 'en-US';
    }
  }

  Future<void> speak({
    required String text,
    required String targetLanguage,
  }) async {
    try {
      await _initTts();
      final langCode = _getLanguageCode(targetLanguage);
      await _flutterTts.setLanguage(langCode);
      await _flutterTts.speak(text);
    } catch (e) {
      debugPrint('TTS Speak Error (handled gracefully): $e');
    }
  }

  Future<void> stop() async {
    try {
      await _flutterTts.stop();
    } catch (e) {
      debugPrint('TTS Stop Error: $e');
    }
  }
}
