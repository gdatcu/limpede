import 'package:freezed_annotation/freezed_annotation.dart';

part 'srs_models.freezed.dart';
part 'srs_models.g.dart';

@freezed
class SentencePair with _$SentencePair {
  const factory SentencePair({
    required String id,
    @JsonKey(name: 'source_text') required String sourceText,
    @JsonKey(name: 'target_text') required String targetText,
    @JsonKey(name: 'language_code') required String languageCode,
    @JsonKey(name: 'difficulty_level') required String difficultyLevel,
    @JsonKey(name: 'topic_category') required String topicCategory,
    @JsonKey(name: 'grammar_notes') String? grammarNotes,
  }) = _SentencePair;

  factory SentencePair.fromJson(Map<String, dynamic> json) =>
      _$SentencePairFromJson(json);
}

@freezed
class SrsReviewItem with _$SrsReviewItem {
  const factory SrsReviewItem({
    String? id,
    @JsonKey(name: 'sentence_id') required String sentenceId,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'next_review_date') required DateTime nextReviewDate,
    @JsonKey(name: 'interval_days') @Default(0) int intervalDays,
    @JsonKey(name: 'ease_factor') @Default(2.5) double easeFactor,
    @JsonKey(name: 'consecutive_correct') @Default(0) int consecutiveCorrect,
  }) = _SrsReviewItem;

  factory SrsReviewItem.fromJson(Map<String, dynamic> json) =>
      _$SrsReviewItemFromJson(json);
}
