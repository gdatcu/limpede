import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/lesson_block.dart';
import '../services/gemini_service.dart';
import '../services/lesson_cache_service.dart';
import '../services/tts_service.dart';

part 'lesson_provider.g.dart';

@Riverpod(keepAlive: true)
TtsService ttsService(Ref ref) {
  return TtsService();
}

@Riverpod(keepAlive: true)
LessonCacheService lessonCacheService(Ref ref) {
  return LessonCacheService();
}

@Riverpod(keepAlive: true)
GeminiService geminiService(Ref ref) {
  final cacheService = ref.watch(lessonCacheServiceProvider);
  return GeminiService(cacheService: cacheService);
}

@Riverpod(keepAlive: true)
class LessonController extends _$LessonController {
  @override
  AsyncValue<List<LessonBlock>> build() {
    return const AsyncValue.loading();
  }

  Future<void> generateLesson({
    required String topic,
    required String targetLanguage,
    bool isCustomAiTopic = false,
  }) async {
    state = const AsyncValue.loading();
    final result = await AsyncValue.guard(() async {
      final geminiService = ref.read(geminiServiceProvider);
      return geminiService.generateLessonBlocks(
        topic: topic,
        targetLanguage: targetLanguage,
        isCustomAiTopic: isCustomAiTopic,
      );
    });
    state = result;
  }
}
