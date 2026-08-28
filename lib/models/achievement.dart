import 'package:freezed_annotation/freezed_annotation.dart';

part 'achievement.freezed.dart';
part 'achievement.g.dart';

@freezed
class Achievement with _$Achievement {
  const Achievement._();

  const factory Achievement({
    required String id,
    required String title,
    required String description,
    required String iconEmoji,
    required int currentValue,
    required int targetValue,
    @Default(1) int tier,
    @Default(3) int maxTier,
    @Default(15) int dropletReward,
    @Default(false) bool isClaimed,
  }) = _Achievement;

  bool get isUnlocked => currentValue >= targetValue;
  double get progressRatio => (currentValue / targetValue).clamp(0.0, 1.0);

  factory Achievement.fromJson(Map<String, dynamic> json) =>
      _$AchievementFromJson(json);
}
