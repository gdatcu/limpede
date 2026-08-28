// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AchievementImpl _$$AchievementImplFromJson(Map<String, dynamic> json) =>
    _$AchievementImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      iconEmoji: json['iconEmoji'] as String,
      currentValue: (json['currentValue'] as num).toInt(),
      targetValue: (json['targetValue'] as num).toInt(),
      tier: (json['tier'] as num?)?.toInt() ?? 1,
      maxTier: (json['maxTier'] as num?)?.toInt() ?? 3,
      dropletReward: (json['dropletReward'] as num?)?.toInt() ?? 15,
      isClaimed: json['isClaimed'] as bool? ?? false,
    );

Map<String, dynamic> _$$AchievementImplToJson(_$AchievementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'iconEmoji': instance.iconEmoji,
      'currentValue': instance.currentValue,
      'targetValue': instance.targetValue,
      'tier': instance.tier,
      'maxTier': instance.maxTier,
      'dropletReward': instance.dropletReward,
      'isClaimed': instance.isClaimed,
    };
