import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/srs_models.dart';

part 'mistake_provider.g.dart';

@riverpod
class MistakeNotifier extends _$MistakeNotifier {
  static const _key = 'user_sentence_mistakes_v2';

  @override
  Future<List<SentencePair>> build() async {
    return _loadMistakes();
  }

  Future<List<SentencePair>> _loadMistakes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final rawJson = prefs.getString(_key);
      if (rawJson != null && rawJson.isNotEmpty) {
        final decoded = jsonDecode(rawJson) as List<dynamic>;
        return decoded
            .map((json) => SentencePair.fromJson(json as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      debugPrint('Error loading sentence mistakes: $e');
    }
    return [];
  }

  Future<void> recordMistake(SentencePair pair) async {
    final currentList = state.value ?? [];
    if (currentList.any((p) => p.id == pair.id)) return;

    final updated = [...currentList, pair];
    state = AsyncValue.data(updated);

    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = updated.map((p) => p.toJson()).toList();
      await prefs.setString(_key, jsonEncode(jsonList));
    } catch (e) {
      debugPrint('Error recording sentence mistake: $e');
    }
  }

  Future<void> resolveMistake(String pairId) async {
    final currentList = state.value ?? [];
    if (!currentList.any((p) => p.id == pairId)) return;

    final updated = currentList.where((p) => p.id != pairId).toList();
    state = AsyncValue.data(updated);

    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = updated.map((p) => p.toJson()).toList();
      await prefs.setString(_key, jsonEncode(jsonList));
    } catch (e) {
      debugPrint('Error resolving sentence mistake: $e');
    }
  }

  Future<void> clearAllMistakes() async {
    state = const AsyncValue.data([]);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_key);
    } catch (e) {
      debugPrint('Error clearing sentence mistakes: $e');
    }
  }

  Future<void> clearMistakes() => clearAllMistakes();
}
