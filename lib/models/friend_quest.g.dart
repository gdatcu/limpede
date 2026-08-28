// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_quest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FriendQuestImpl _$$FriendQuestImplFromJson(Map<String, dynamic> json) =>
    _$FriendQuestImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      partnerName: json['partnerName'] as String,
      partnerEmoji: json['partnerEmoji'] as String? ?? '👩‍🎨',
      partnerAvatarUrl: json['partnerAvatarUrl'] as String?,
      userContribution: (json['userContribution'] as num?)?.toInt() ?? 0,
      partnerContribution: (json['partnerContribution'] as num?)?.toInt() ?? 0,
      targetGoal: (json['targetGoal'] as num?)?.toInt() ?? 25,
      sharedStreakDays: (json['sharedStreakDays'] as num?)?.toInt() ?? 4,
      daysRemaining: (json['daysRemaining'] as num?)?.toInt() ?? 3,
      rewardDroplets: (json['rewardDroplets'] as num?)?.toInt() ?? 25,
      isClaimed: json['isClaimed'] as bool? ?? false,
      lastNudgeSentAt: json['lastNudgeSentAt'] == null
          ? null
          : DateTime.parse(json['lastNudgeSentAt'] as String),
    );

Map<String, dynamic> _$$FriendQuestImplToJson(_$FriendQuestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'partnerName': instance.partnerName,
      'partnerEmoji': instance.partnerEmoji,
      'partnerAvatarUrl': instance.partnerAvatarUrl,
      'userContribution': instance.userContribution,
      'partnerContribution': instance.partnerContribution,
      'targetGoal': instance.targetGoal,
      'sharedStreakDays': instance.sharedStreakDays,
      'daysRemaining': instance.daysRemaining,
      'rewardDroplets': instance.rewardDroplets,
      'isClaimed': instance.isClaimed,
      'lastNudgeSentAt': instance.lastNudgeSentAt?.toIso8601String(),
    };
