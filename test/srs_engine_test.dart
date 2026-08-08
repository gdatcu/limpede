import 'package:flutter_test/flutter_test.dart';
import 'package:limpede/models/srs_models.dart';
import 'package:limpede/services/srs_engine.dart';

void main() {
  group('SrsEngine SM-2 Algorithm Tests', () {
    final initialItem = SrsReviewItem(
      sentenceId: 'test_sentence_1',
      userId: 'user_123',
      nextReviewDate: DateTime.now(),
      intervalDays: 0,
      easeFactor: 2.5,
      consecutiveCorrect: 0,
    );

    test('Grade 5 (Perfect) increases ease factor and sets initial 1-day interval', () {
      final updated = SrsEngine.calculateNextReview(item: initialItem, grade: 5);

      expect(updated.consecutiveCorrect, equals(1));
      expect(updated.intervalDays, equals(1));
      expect(updated.easeFactor, greaterThan(2.5));
      expect(updated.nextReviewDate.isAfter(DateTime.now()), isTrue);
    });

    test('Consecutive correct answers increase review interval to 6 then multiplied', () {
      final step1 = SrsEngine.calculateNextReview(item: initialItem, grade: 5);
      expect(step1.consecutiveCorrect, equals(1));
      expect(step1.intervalDays, equals(1));

      final step2 = SrsEngine.calculateNextReview(item: step1, grade: 5);
      expect(step2.consecutiveCorrect, equals(2));
      expect(step2.intervalDays, equals(6));

      final step3 = SrsEngine.calculateNextReview(item: step2, grade: 5);
      expect(step3.consecutiveCorrect, equals(3));
      expect(step3.intervalDays, equals((6 * step3.easeFactor).round()));
    });

    test('Grade 0 (Fail) resets consecutive correct count and interval to 1', () {
      final masterItem = SrsReviewItem(
        sentenceId: 'test_sentence_1',
        userId: 'user_123',
        nextReviewDate: DateTime.now(),
        intervalDays: 14,
        easeFactor: 2.6,
        consecutiveCorrect: 4,
      );

      final failed = SrsEngine.calculateNextReview(item: masterItem, grade: 0);

      expect(failed.consecutiveCorrect, equals(0));
      expect(failed.intervalDays, equals(1));
      expect(failed.easeFactor, lessThan(2.6));
      expect(failed.easeFactor, greaterThanOrEqualTo(1.3));
    });
  });
}
