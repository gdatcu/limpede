import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/lesson_block.dart';
import 'env_service.dart';
import 'lesson_cache_service.dart';

class GeminiService {
  final String _apiKey;
  final LessonCacheService _cacheService;

  GeminiService({String? apiKey, LessonCacheService? cacheService})
      : _apiKey = apiKey ?? Env.geminiApiKey,
        _cacheService = cacheService ?? LessonCacheService();

  Future<List<LessonBlock>> generateLessonBlocks({
    required String topic,
    required String targetLanguage,
    bool isCustomAiTopic = false,
  }) async {
    if (!isCustomAiTopic) {
      debugPrint('Curriculum Level: Serving generated challenge blocks for "$topic" ($targetLanguage).');
      return _buildFallbackBlocks(topic: topic, targetLanguage: targetLanguage);
    }

    // 2. Custom AI Topic: Check Local Cache First!
    final cached = await _cacheService.getCachedLesson(
      topic: topic,
      targetLanguage: targetLanguage,
    );
    if (cached != null && cached.isNotEmpty) {
      debugPrint('Local Cache Hit: Loaded AI lesson for "$topic" ($targetLanguage) instantly from storage!');
      return cached;
    }

    // 3. AI Fetch from Gemini if not in cache
    final prompt = '''
You are an expert language tutor. Create an interactive language learning lesson for topic "$topic".
Target Language: $targetLanguage.

Output ONLY a valid JSON array of 4 to 6 objects with NO markdown code block formatting.
IMPORTANT JSON RULES:
- Use standard double quotes for JSON keys and values.
- Do NOT use unescaped double quotes inside string values.
- Do NOT include trailing commas after the last item.

Each object MUST have:
- "id": unique string ID
- "lessonId": "$topic"
- "orderIndex": integer starting at 1
- "type": "explanation" for block 1, "multiple_choice" for blocks 2 to 4, "sentence_builder" for block 5
- "title": Short title in $targetLanguage
- "content": Main text or question prompt in $targetLanguage
- "options": Array of 3 or 4 answer choices in $targetLanguage (for multiple_choice)
- "correctAnswer": Exact correct answer string from "options"
- "explanation": Short English hint/translation explaining why it is correct.
- "wordBank": Array of 5 to 7 words in $targetLanguage (for sentence_builder)
''';

    final candidateEndpoints = [
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$_apiKey',
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$_apiKey',
    ];

    for (final endpointUrl in candidateEndpoints) {
      try {
        final url = Uri.parse(endpointUrl);
        final modelName = url.pathSegments.isNotEmpty && url.pathSegments.length >= 3
            ? url.pathSegments[2].split(':').first
            : 'model';

        debugPrint('Custom AI Topic: Calling Gemini AI ($modelName) for "$topic"...');

        final res = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'contents': [
              {
                'parts': [
                  {'text': prompt}
                ]
              }
            ]
          }),
        ).timeout(const Duration(seconds: 5));

        if (res.statusCode == 200) {
          final resData = jsonDecode(res.body) as Map<String, dynamic>;
          final candidates = resData['candidates'] as List<dynamic>?;
          if (candidates != null && candidates.isNotEmpty) {
            final content = candidates[0]['content'] as Map<String, dynamic>?;
            final parts = content?['parts'] as List<dynamic>?;
            if (parts != null && parts.isNotEmpty) {
              final rawText = parts[0]['text'] as String?;
              if (rawText != null && rawText.trim().isNotEmpty) {
                final cleanedJson = _cleanJsonString(rawText);
                dynamic decoded;
                try {
                  decoded = jsonDecode(cleanedJson);
                } catch (_) {
                  final repairedJson = _repairJsonString(cleanedJson);
                  decoded = jsonDecode(repairedJson);
                }

                List<dynamic> jsonList = [];
                if (decoded is List) {
                  jsonList = decoded;
                } else if (decoded is Map<String, dynamic>) {
                  if (decoded.containsKey('blocks') && decoded['blocks'] is List) {
                    jsonList = decoded['blocks'] as List<dynamic>;
                  } else {
                    final firstList = decoded.values.firstWhere(
                      (v) => v is List,
                      orElse: () => [],
                    );
                    jsonList = firstList as List<dynamic>;
                  }
                }

                final blocks = jsonList
                    .map((json) => LessonBlock.fromJson(json as Map<String, dynamic>))
                    .toList();

                if (blocks.isNotEmpty) {
                  debugPrint('SUCCESS! Live Gemini AI generated ${blocks.length} custom blocks.');
                  // Save to Local Cache
                  await _cacheService.saveLessonToCache(
                    topic: topic,
                    targetLanguage: targetLanguage,
                    blocks: blocks,
                  );
                  return blocks;
                }
              }
            }
          }
        }
      } catch (e) {
        debugPrint('Gemini AI notice: $e');
      }
    }

    debugPrint('Fallback: Serving generated blocks for "$topic".');
    return _buildFallbackBlocks(topic: topic, targetLanguage: targetLanguage);
  }

  List<LessonBlock> _buildFallbackBlocks({
    required String topic,
    required String targetLanguage,
  }) {
    return [
      LessonBlock(
        id: 'block_fb_1',
        lessonId: topic,
        orderIndex: 1,
        type: 'explanation',
        title: 'Topic Overview',
        content: 'Welcome to "$topic" in $targetLanguage. Practice key phrases and master vocabulary.',
        explanation: 'Review the upcoming sentences carefully.',
      ),
      LessonBlock(
        id: 'block_fb_2',
        lessonId: topic,
        orderIndex: 2,
        type: 'multiple_choice',
        title: 'Vocabulary Check',
        content: 'Select the correct translation for "$topic"',
        options: ['Practicar', 'Aprender', 'Hablar', 'Escuchar'],
        correctAnswer: 'Practicar',
        explanation: 'Practice makes perfect!',
      ),
    ];
  }

  String _cleanJsonString(String text) {
    var cleaned = text.trim();
    if (cleaned.startsWith('```json')) {
      cleaned = cleaned.substring(7);
    } else if (cleaned.startsWith('```')) {
      cleaned = cleaned.substring(3);
    }
    if (cleaned.endsWith('```')) {
      cleaned = cleaned.substring(0, cleaned.length - 3);
    }
    cleaned = cleaned.trim();
    cleaned = cleaned.replaceAll(RegExp(r',\s*\]'), ']');
    cleaned = cleaned.replaceAll(RegExp(r',\s*\}'), '}');
    return cleaned;
  }

  String _repairJsonString(String jsonStr) {
    var repaired = jsonStr.replaceAll(RegExp(r'[\r\n]+'), ' ');
    repaired = repaired.replaceAll(RegExp(r',\s*\]'), ']');
    repaired = repaired.replaceAll(RegExp(r',\s*\}'), '}');
    return repaired;
  }

  Future<String> explainMistake({
    required String sourceText,
    required String userAnswer,
    required String targetLanguage,
  }) async {
    final prompt =
        "Explain in 2 simple bullet points why '$userAnswer' is an incorrect translation for '$sourceText' in $targetLanguage.";

    final candidateEndpoints = [
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$_apiKey',
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$_apiKey',
    ];

    for (final endpointUrl in candidateEndpoints) {
      try {
        final url = Uri.parse(endpointUrl);
        debugPrint('Gemini AI On-Demand: Explaining mistake via ${url.pathSegments.isNotEmpty ? url.pathSegments[2] : "model"}...');

        final res = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'contents': [
              {
                'parts': [
                  {'text': prompt}
                ]
              }
            ]
          }),
        ).timeout(const Duration(seconds: 6));

        if (res.statusCode == 200) {
          final resData = jsonDecode(res.body) as Map<String, dynamic>;
          final candidates = resData['candidates'] as List<dynamic>?;
          if (candidates != null && candidates.isNotEmpty) {
            final content = candidates[0]['content'] as Map<String, dynamic>?;
            final parts = content?['parts'] as List<dynamic>?;
            if (parts != null && parts.isNotEmpty) {
              final rawText = parts[0]['text'] as String?;
              if (rawText != null && rawText.trim().isNotEmpty) {
                return rawText.trim();
              }
            }
          }
        }
      } catch (e) {
        debugPrint('Gemini explain notice: $e');
      }
    }

    return "• '$userAnswer' does not match the expected vocabulary or grammar for '$sourceText'.\n• Check word ordering and form in $targetLanguage.";
  }
}

