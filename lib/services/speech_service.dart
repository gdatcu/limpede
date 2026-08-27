import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechRecognitionService {
  final SpeechToText _speech = SpeechToText();
  bool _isInitialized = false;
  bool _isListening = false;

  bool get isListening => _isListening;
  bool get isAvailable => _isInitialized;

  Future<bool> initialize() async {
    if (_isInitialized) return true;
    try {
      _isInitialized = await _speech.initialize(
        onError: (val) => debugPrint('SpeechRecognition onError: $val'),
        onStatus: (val) {
          if (val == 'done' || val == 'notListening') {
            _isListening = false;
          }
        },
      );
      return _isInitialized;
    } catch (e) {
      debugPrint('SpeechRecognition init error: $e');
      _isInitialized = false;
      return false;
    }
  }

  String _normalizeLocale(String targetLanguage) {
    final lang = targetLanguage.trim().toLowerCase();
    if (lang.contains('spanish') || lang == 'es') return 'es_ES';
    if (lang.contains('french') || lang == 'fr') return 'fr_FR';
    if (lang.contains('german') || lang == 'de') return 'de_DE';
    if (lang.contains('italian') || lang == 'it') return 'it_IT';
    if (lang.contains('romanian') || lang == 'ro') return 'ro_RO';
    if (lang.contains('portuguese') || lang == 'pt') return 'pt_PT';
    if (lang.contains('russian') || lang == 'ru') return 'ru_RU';
    if (lang.contains('japanese') || lang == 'ja') return 'ja_JP';
    if (lang.contains('turkish') || lang == 'tr') return 'tr_TR';
    return 'en_US';
  }

  Future<void> startListening({
    required String targetLanguage,
    required Function(String recognizedWords, double confidence) onResult,
  }) async {
    final hasInit = await initialize();
    if (!hasInit) return;

    try {
      _isListening = true;
      final localeId = _normalizeLocale(targetLanguage);
      await _speech.listen(
        onResult: (result) {
          onResult(result.recognizedWords, result.confidence);
        },
        listenOptions: SpeechListenOptions(
          listenMode: ListenMode.confirmation,
          cancelOnError: true,
          partialResults: true,
          localeId: localeId,
        ),
      );
    } catch (e) {
      debugPrint('Error starting speech listening: $e');
      _isListening = false;
    }
  }

  Future<void> stopListening() async {
    try {
      await _speech.stop();
      _isListening = false;
    } catch (e) {
      debugPrint('Error stopping speech: $e');
    }
  }

  static String stripDiacritics(String str) {
    const withDia = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    const withoutDia = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';
    for (int i = 0; i < withDia.length; i++) {
      str = str.replaceAll(withDia[i], withoutDia[i]);
    }
    return str;
  }

  static String cleanString(String text) {
    final noDiacritics = stripDiacritics(text);
    return noDiacritics
        .toLowerCase()
        .replaceAll(RegExp(r'[^\p{L}\p{N}\s]', unicode: true), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  static int levenshteinDistance(String s1, String s2) {
    if (s1 == s2) return 0;
    if (s1.isEmpty) return s2.length;
    if (s2.isEmpty) return s1.length;

    List<int> v0 = List<int>.filled(s2.length + 1, 0);
    List<int> v1 = List<int>.filled(s2.length + 1, 0);

    for (int i = 0; i <= s2.length; i++) {
      v0[i] = i;
    }

    for (int i = 0; i < s1.length; i++) {
      v1[0] = i + 1;

      for (int j = 0; j < s2.length; j++) {
        int cost = (s1[i] == s2[j]) ? 0 : 1;
        v1[j + 1] = math.min(v1[j] + 1, math.min(v0[j + 1] + 1, v0[j] + cost));
      }

      for (int j = 0; j <= s2.length; j++) {
        v0[j] = v1[j];
      }
    }

    return v1[s2.length];
  }

  /// Calculates speech match accuracy between 0% and 100%
  static int calculateSimilarity(String spoken, String target) {
    final cleanedSpoken = cleanString(spoken);
    final cleanedTarget = cleanString(target);

    if (cleanedSpoken.isEmpty || cleanedTarget.isEmpty) return 0;
    if (cleanedSpoken == cleanedTarget) return 100;

    final maxLen = math.max(cleanedSpoken.length, cleanedTarget.length);
    final distance = levenshteinDistance(cleanedSpoken, cleanedTarget);
    final charRatio = (1.0 - (distance / maxLen)).clamp(0.0, 1.0);

    // Fuzzy Word token overlap check
    final spokenWords = cleanedSpoken.split(' ').where((w) => w.isNotEmpty).toList();
    final targetWords = cleanedTarget.split(' ').where((w) => w.isNotEmpty).toList();

    int matchedWords = 0;
    for (final tw in targetWords) {
      final hasMatch = spokenWords.any((sw) {
        if (sw == tw) return true;
        final d = levenshteinDistance(sw, tw);
        return d <= 1 && (sw.length >= 3 || tw.length >= 3);
      });
      if (hasMatch) matchedWords++;
    }

    final wordRatio = targetWords.isNotEmpty ? (matchedWords / targetWords.length) : 0.0;

    // Weighted average: 50% character Levenshtein + 50% fuzzy word overlap
    final combined = (charRatio * 0.5) + (wordRatio * 0.5);
    return (combined * 100).round().clamp(0, 100);
  }
}
