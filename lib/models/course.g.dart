// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LessonNodeImpl _$$LessonNodeImplFromJson(Map<String, dynamic> json) =>
    _$LessonNodeImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      level: json['level'] as String,
      status: $enumDecode(_$LessonNodeStatusEnumMap, json['status']),
      xpReward: (json['xpReward'] as num).toInt(),
      topic: json['topic'] as String,
      targetLanguage: json['targetLanguage'] as String,
      stars: (json['stars'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$LessonNodeImplToJson(_$LessonNodeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'level': instance.level,
      'status': _$LessonNodeStatusEnumMap[instance.status]!,
      'xpReward': instance.xpReward,
      'topic': instance.topic,
      'targetLanguage': instance.targetLanguage,
      'stars': instance.stars,
    };

const _$LessonNodeStatusEnumMap = {
  LessonNodeStatus.locked: 'locked',
  LessonNodeStatus.active: 'active',
  LessonNodeStatus.completed: 'completed',
};

_$CourseUnitImpl _$$CourseUnitImplFromJson(Map<String, dynamic> json) =>
    _$CourseUnitImpl(
      id: json['id'] as String,
      unitNumber: (json['unitNumber'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      levelBadge: json['levelBadge'] as String,
      lessons: (json['lessons'] as List<dynamic>)
          .map((e) => LessonNode.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CourseUnitImplToJson(_$CourseUnitImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'unitNumber': instance.unitNumber,
      'title': instance.title,
      'description': instance.description,
      'levelBadge': instance.levelBadge,
      'lessons': instance.lessons,
    };
