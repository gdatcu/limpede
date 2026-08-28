import 'package:freezed_annotation/freezed_annotation.dart';

part 'memory_analytics.freezed.dart';
part 'memory_analytics.g.dart';

@freezed
class MemoryAnalytics with _$MemoryAnalytics {
  const factory MemoryAnalytics({
    @Default(90) int retentionRatePercent,
    @Default(0) int totalWordsLearned,
    @Default(0) int masteredCount,
    @Default(0) int learningCount,
    @Default(0) int dueCount,
    @Default(0) int a1Count,
    @Default(0) int a2Count,
    @Default(0) int b1Count,
    @Default(0) int b2Count,
    @Default([15, 25, 40, 30, 50, 20, 35]) List<int> weeklyXpList,
  }) = _MemoryAnalytics;

  factory MemoryAnalytics.fromJson(Map<String, dynamic> json) =>
      _$MemoryAnalyticsFromJson(json);
}
