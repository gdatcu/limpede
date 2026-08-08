import 'package:flutter_test/flutter_test.dart';
import 'package:limpede/models/srs_models.dart';

void main() {
  test('SentencePair and SrsReviewItem Model Deserialization Test', () {
    final pairJson = {
      'id': 'sp_1',
      'source_text': 'Hello',
      'target_text': 'Hola',
      'language_code': 'es',
      'difficulty_level': 'A1',
      'topic_category': 'Greetings',
      'grammar_notes': 'Basic greeting'
    };

    final pair = SentencePair.fromJson(pairJson);
    expect(pair.id, equals('sp_1'));
    expect(pair.sourceText, equals('Hello'));
    expect(pair.targetText, equals('Hola'));
    expect(pair.languageCode, equals('es'));

    final srsJson = {
      'sentence_id': 'sp_1',
      'user_id': 'user_abc',
      'next_review_date': '2026-08-08T12:00:00.000Z',
      'interval_days': 3,
      'ease_factor': 2.5,
      'consecutive_correct': 2
    };

    final srsItem = SrsReviewItem.fromJson(srsJson);
    expect(srsItem.sentenceId, equals('sp_1'));
    expect(srsItem.userId, equals('user_abc'));
    expect(srsItem.intervalDays, equals(3));
  });
}
