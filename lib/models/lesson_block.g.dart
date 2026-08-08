// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LessonBlockImpl _$$LessonBlockImplFromJson(Map<String, dynamic> json) =>
    _$LessonBlockImpl(
      id: json['id'] as String,
      lessonId: json['lessonId'] as String,
      orderIndex: (json['orderIndex'] as num).toInt(),
      type: json['type'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      options:
          (json['options'] as List<dynamic>?)?.map((e) => e as String).toList(),
      correctAnswer: json['correctAnswer'] as String?,
      explanation: json['explanation'] as String?,
      wordBank: (json['wordBank'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      matchingPairs: (json['matchingPairs'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$$LessonBlockImplToJson(_$LessonBlockImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lessonId': instance.lessonId,
      'orderIndex': instance.orderIndex,
      'type': instance.type,
      'title': instance.title,
      'content': instance.content,
      'options': instance.options,
      'correctAnswer': instance.correctAnswer,
      'explanation': instance.explanation,
      'wordBank': instance.wordBank,
      'matchingPairs': instance.matchingPairs,
    };
