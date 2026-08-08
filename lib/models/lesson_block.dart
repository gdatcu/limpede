import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson_block.freezed.dart';
part 'lesson_block.g.dart';

@freezed
class LessonBlock with _$LessonBlock {
  const factory LessonBlock({
    required String id,
    required String lessonId,
    required int orderIndex,
    required String type, // 'explanation', 'multiple_choice', 'sentence_builder', 'matching'
    required String title,
    required String content,
    List<String>? options,
    String? correctAnswer,
    String? explanation,
    List<String>? wordBank,
    Map<String, String>? matchingPairs,
  }) = _LessonBlock;

  factory LessonBlock.fromJson(Map<String, dynamic> json) =>
      _$LessonBlockFromJson(json);
}
