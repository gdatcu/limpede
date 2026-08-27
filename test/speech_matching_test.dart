import 'package:flutter_test/flutter_test.dart';
import 'package:limpede/services/dictionary_service.dart';
import 'package:limpede/services/speech_service.dart';

void main() {
  group('Multi-Sensory: Speech Recognition Similarity Matching', () {
    test('Exact match yields 100% similarity', () {
      final score = SpeechRecognitionService.calculateSimilarity(
        'Hola, ¿cómo estás?',
        'Hola, ¿cómo estás?',
      );
      expect(score, 100);
    });

    test('Case and punctuation normalization', () {
      final score = SpeechRecognitionService.calculateSimilarity(
        'hola como estas',
        '¡Hola! ¿Cómo estás?',
      );
      expect(score, greaterThanOrEqualTo(90));
    });

    test('Minor misspelling / speech variance yields high passing score (>= 75%)', () {
      final score = SpeechRecognitionService.calculateSimilarity(
        'bonjour coment alez vous',
        'Bonjour, comment allez-vous ?',
      );
      expect(score, greaterThanOrEqualTo(75));
    });

    test('Completely different sentences yield low score (< 40%)', () {
      final score = SpeechRecognitionService.calculateSimilarity(
        'good night see you tomorrow',
        'Quisiera un café por favor',
      );
      expect(score, lessThan(40));
    });

    test('Empty input returns 0', () {
      expect(SpeechRecognitionService.calculateSimilarity('', 'test sentence'), 0);
    });
  });

  group('Multi-Sensory: Dictionary Service Word Hints Lookups', () {
    test('Spanish word hint lookups with lemma and part of speech', () {
      final hintHola = DictionaryService.lookup('hola', 'es');
      expect(hintHola, isNotNull);
      expect(hintHola!.translation, contains('hello'));
      expect(hintHola.partOfSpeech, 'interjection');

      final hintCafe = DictionaryService.lookup('café', 'es');
      expect(hintCafe, isNotNull);
      expect(hintCafe!.translation, 'coffee');
      expect(hintCafe.partOfSpeech, 'noun');
    });

    test('French and German word hint lookups', () {
      final hintFr = DictionaryService.lookup('bonjour', 'fr');
      expect(hintFr, isNotNull);
      expect(hintFr!.translation, contains('hello'));

      final hintDe = DictionaryService.lookup('kaffee', 'de');
      expect(hintDe, isNotNull);
      expect(hintDe!.translation, 'coffee');
    });

    test('Unknown word returns graceful fallback hint', () {
      final fallback = DictionaryService.lookup('unregisteredword123', 'es');
      expect(fallback, isNotNull);
      expect(fallback!.translation, contains('unregisteredword123'));
    });
  });
}
