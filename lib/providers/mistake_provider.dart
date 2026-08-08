import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/lesson_block.dart';

part 'mistake_provider.g.dart';

@riverpod
class MistakeNotifier extends _$MistakeNotifier {
  static const _key = 'user_mistakes_list';

  @override
  Future<List<LessonBlock>> build() async {
    return _loadMistakes();
  }

  Future<List<LessonBlock>> _loadMistakes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final rawJson = prefs.getString(_key);
      if (rawJson != null && rawJson.isNotEmpty) {
        final decoded = jsonDecode(rawJson) as List<dynamic>;
        return decoded
            .map((json) => LessonBlock.fromJson(json as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      debugPrint('Error loading mistakes: $e');
    }
    return [];
  }

  Future<void> addMistake(LessonBlock block) async {
    final currentList = state.value ?? [];
    // Avoid duplicate block entries
    if (currentList.any((b) => b.id == block.id)) return;

    final updated = [...currentList, block];
    state = AsyncValue.data(updated);

    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = updated.map((b) => b.toJson()).toList();
      await prefs.setString(_key, jsonEncode(jsonList));
    } catch (e) {
      debugPrint('Error saving mistake: $e');
    }
  }

  Future<void> clearMistakes() async {
    state = const AsyncValue.data([]);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_key);
    } catch (e) {
      debugPrint('Error clearing mistakes: $e');
    }
  }
}
