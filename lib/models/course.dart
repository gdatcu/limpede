import 'package:freezed_annotation/freezed_annotation.dart';

part 'course.freezed.dart';
part 'course.g.dart';

enum LessonNodeStatus { locked, active, completed }

@freezed
class LessonNode with _$LessonNode {
  const factory LessonNode({
    required String id,
    required String title,
    required String description,
    required String level, // A1, A2, B1, B2, C1
    required LessonNodeStatus status,
    required int xpReward,
    required String topic,
    required String targetLanguage,
    @Default(0) int stars,
  }) = _LessonNode;

  factory LessonNode.fromJson(Map<String, dynamic> json) =>
      _$LessonNodeFromJson(json);
}

@freezed
class CourseUnit with _$CourseUnit {
  const factory CourseUnit({
    required String id,
    required int unitNumber,
    required String title,
    required String description,
    required String levelBadge, // e.g. "A1 Beginner"
    required List<LessonNode> lessons,
  }) = _CourseUnit;

  factory CourseUnit.fromJson(Map<String, dynamic> json) =>
      _$CourseUnitFromJson(json);
}
