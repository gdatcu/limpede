import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
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
