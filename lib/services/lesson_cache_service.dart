import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/lesson_block.dart';

class LessonCacheService {
  String _getCacheKey(String topic, String targetLanguage) {
    final cleanTopic = topic.trim().toLowerCase().replaceAll(RegExp(r'\s+'), '_');
    final cleanLang = targetLanguage.trim().toLowerCase();
    return 'custom_lesson_${cleanTopic}_$cleanLang';
  }

  Future<List<LessonBlock>?> getCachedLesson({
    required String topic,
    required String targetLanguage,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = _getCacheKey(topic, targetLanguage);
      final rawJson = prefs.getString(key);

      if (rawJson != null && rawJson.isNotEmpty) {
        final decoded = jsonDecode(rawJson) as List<dynamic>;
        final blocks = decoded
            .map((json) => LessonBlock.fromJson(json as Map<String, dynamic>))
            .toList();

        if (blocks.isNotEmpty) {
          debugPrint('Cache Hit! Loaded ${blocks.length} blocks for "$topic" ($targetLanguage).');
          return blocks;
        }
      }
    } catch (e) {
      debugPrint('Lesson Cache Retrieval Error: $e');
    }
    return null;
  }

  Future<void> saveLessonToCache({
    required String topic,
    required String targetLanguage,
    required List<LessonBlock> blocks,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = _getCacheKey(topic, targetLanguage);
      final jsonList = blocks.map((b) => b.toJson()).toList();
      final jsonStr = jsonEncode(jsonList);

      await prefs.setString(key, jsonStr);
      debugPrint('Cache Saved! Stored ${blocks.length} blocks under "$key".');
    } catch (e) {
      debugPrint('Lesson Cache Save Error: $e');
    }
  }
}
