import 'package:freezed_annotation/freezed_annotation.dart';

part 'friend_quest.freezed.dart';
part 'friend_quest.g.dart';

@freezed
class FriendQuest with _$FriendQuest {
  const FriendQuest._();

  const factory FriendQuest({
    required String id,
    required String title,
    required String description,
    required String partnerName,
    @Default('👩‍🎨') String partnerEmoji,
    String? partnerAvatarUrl,
    @Default(0) int userContribution,
    @Default(0) int partnerContribution,
    @Default(25) int targetGoal,
    @Default(4) int sharedStreakDays,
    @Default(3) int daysRemaining,
    @Default(25) int rewardDroplets,
    @Default(false) bool isClaimed,
    DateTime? lastNudgeSentAt,
  }) = _FriendQuest;

  int get totalProgress => (userContribution + partnerContribution).clamp(0, targetGoal);
  double get progressRatio => (totalProgress / targetGoal).clamp(0.0, 1.0);
  bool get isCompleted => (userContribution + partnerContribution) >= targetGoal;

  factory FriendQuest.fromJson(Map<String, dynamic> json) =>
      _$FriendQuestFromJson(json);
}
