// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'srs_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SentencePairImpl _$$SentencePairImplFromJson(Map<String, dynamic> json) =>
    _$SentencePairImpl(
      id: json['id'] as String,
      sourceText: json['source_text'] as String,
      targetText: json['target_text'] as String,
      languageCode: json['language_code'] as String,
      difficultyLevel: json['difficulty_level'] as String,
      topicCategory: json['topic_category'] as String,
      grammarNotes: json['grammar_notes'] as String?,
    );

Map<String, dynamic> _$$SentencePairImplToJson(_$SentencePairImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'source_text': instance.sourceText,
      'target_text': instance.targetText,
      'language_code': instance.languageCode,
      'difficulty_level': instance.difficultyLevel,
      'topic_category': instance.topicCategory,
      'grammar_notes': instance.grammarNotes,
    };

_$SrsReviewItemImpl _$$SrsReviewItemImplFromJson(Map<String, dynamic> json) =>
    _$SrsReviewItemImpl(
      id: json['id'] as String?,
      sentenceId: json['sentence_id'] as String,
      userId: json['user_id'] as String,
      nextReviewDate: DateTime.parse(json['next_review_date'] as String),
      intervalDays: (json['interval_days'] as num?)?.toInt() ?? 0,
      easeFactor: (json['ease_factor'] as num?)?.toDouble() ?? 2.5,
      consecutiveCorrect: (json['consecutive_correct'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$SrsReviewItemImplToJson(_$SrsReviewItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sentence_id': instance.sentenceId,
      'user_id': instance.userId,
      'next_review_date': instance.nextReviewDate.toIso8601String(),
      'interval_days': instance.intervalDays,
      'ease_factor': instance.easeFactor,
      'consecutive_correct': instance.consecutiveCorrect,
    };
