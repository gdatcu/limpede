// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: json['id'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      xp: (json['xp'] as num?)?.toInt() ?? 0,
      streak: (json['streak'] as num?)?.toInt() ?? 0,
      gems: (json['gems'] as num?)?.toInt() ?? 50,
      streakFreezes: (json['streakFreezes'] as num?)?.toInt() ?? 0,
      weeklyXp: (json['weeklyXp'] as num?)?.toInt() ?? 0,
      leagueTier: json['leagueTier'] as String? ?? 'bronze',
      lastActiveAt: json['lastActiveAt'] == null
          ? null
          : DateTime.parse(json['lastActiveAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'avatarUrl': instance.avatarUrl,
      'xp': instance.xp,
      'streak': instance.streak,
      'gems': instance.gems,
      'streakFreezes': instance.streakFreezes,
      'weeklyXp': instance.weeklyXp,
      'leagueTier': instance.leagueTier,
      'lastActiveAt': instance.lastActiveAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };
