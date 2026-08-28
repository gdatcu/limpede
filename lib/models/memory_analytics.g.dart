// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memory_analytics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MemoryAnalyticsImpl _$$MemoryAnalyticsImplFromJson(
        Map<String, dynamic> json) =>
    _$MemoryAnalyticsImpl(
      retentionRatePercent:
          (json['retentionRatePercent'] as num?)?.toInt() ?? 90,
      totalWordsLearned: (json['totalWordsLearned'] as num?)?.toInt() ?? 0,
      masteredCount: (json['masteredCount'] as num?)?.toInt() ?? 0,
      learningCount: (json['learningCount'] as num?)?.toInt() ?? 0,
      dueCount: (json['dueCount'] as num?)?.toInt() ?? 0,
      a1Count: (json['a1Count'] as num?)?.toInt() ?? 0,
      a2Count: (json['a2Count'] as num?)?.toInt() ?? 0,
      b1Count: (json['b1Count'] as num?)?.toInt() ?? 0,
      b2Count: (json['b2Count'] as num?)?.toInt() ?? 0,
      weeklyXpList: (json['weeklyXpList'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [15, 25, 40, 30, 50, 20, 35],
    );

Map<String, dynamic> _$$MemoryAnalyticsImplToJson(
        _$MemoryAnalyticsImpl instance) =>
    <String, dynamic>{
      'retentionRatePercent': instance.retentionRatePercent,
      'totalWordsLearned': instance.totalWordsLearned,
      'masteredCount': instance.masteredCount,
      'learningCount': instance.learningCount,
      'dueCount': instance.dueCount,
      'a1Count': instance.a1Count,
      'a2Count': instance.a2Count,
      'b1Count': instance.b1Count,
      'b2Count': instance.b2Count,
      'weeklyXpList': instance.weeklyXpList,
    };
