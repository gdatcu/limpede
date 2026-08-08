import '../models/srs_models.dart';

class SrsEngine {
  /// Calculates updated SRS metrics for an item using the SuperMemo-2 (SM-2) algorithm.
  /// 
  /// Grade scale:
  /// - 0..2: Fail / Wrong response (resets consecutive correct count and interval)
  /// - 3: Hard (Correct response with difficulty)
  /// - 4: Good (Correct response with minor hesitation)
  /// - 5: Perfect (Instant correct response)
  static SrsReviewItem calculateNextReview({
    required SrsReviewItem item,
    required int grade,
  }) {
    // Clamp grade between 0 and 5
    final clampedGrade = grade.clamp(0, 5);

    final double currentEase = item.easeFactor;
    final int currentConsecutive = item.consecutiveCorrect;
    final int currentInterval = item.intervalDays;

    // Calculate new Ease Factor (EF)
    // Formula: EF' = EF + (0.1 - (5 - q) * (0.08 + (5 - q) * 0.02))
    double newEase = currentEase +
        (0.1 - (5 - clampedGrade) * (0.08 + (5 - clampedGrade) * 0.02));
    if (newEase < 1.3) {
      newEase = 1.3;
    }

    int newConsecutive;
    int newInterval;

    if (clampedGrade >= 3) {
      newConsecutive = currentConsecutive + 1;
      if (newConsecutive == 1) {
        newInterval = 1;
      } else if (newConsecutive == 2) {
        newInterval = 6;
      } else {
        newInterval = (currentInterval * newEase).round();
      }
    } else {
      newConsecutive = 0;
      newInterval = 1;
    }

    final nextReviewDate = DateTime.now().add(Duration(days: newInterval));

    return item.copyWith(
      easeFactor: double.parse(newEase.toStringAsFixed(2)),
      consecutiveCorrect: newConsecutive,
      intervalDays: newInterval,
      nextReviewDate: nextReviewDate,
    );
  }

  /// Creates a brand new SrsReviewItem for a sentence pair user attempt.
  static SrsReviewItem createInitialReview({
    required String sentenceId,
    required String userId,
    required int grade,
  }) {
    final initialItem = SrsReviewItem(
      sentenceId: sentenceId,
      userId: userId,
      nextReviewDate: DateTime.now(),
      intervalDays: 0,
      easeFactor: 2.5,
      consecutiveCorrect: 0,
    );
    return calculateNextReview(item: initialItem, grade: grade);
  }

  /// Determines if an SrsReviewItem is due for review today.
  static bool isDue(SrsReviewItem item) {
    return item.nextReviewDate.isBefore(DateTime.now());
  }
}
