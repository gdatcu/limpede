import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/lesson_catalog.dart';
import '../models/srs_models.dart';
import '../models/user_profile.dart';

class SupabaseService {
  final SupabaseClient _client;

  SupabaseService([SupabaseClient? client])
      : _client = client ?? Supabase.instance.client;

  SupabaseClient get client => _client;

  User? get currentUser => _client.auth.currentUser;

  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  bool _isValidUuid(String? id) {
    if (id == null) return false;
    final RegExp uuidRegExp = RegExp(
      r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
    );
    return uuidRegExp.hasMatch(id);
  }

  Future<Set<String>> fetchCompletedTopics(String userId) async {
    final Set<String> completed = {};
    try {
      final prefs = await SharedPreferences.getInstance();
      final local = prefs.getStringList('completed_topics_$userId');
      if (local != null) {
        completed.addAll(local);
      }

      if (_isValidUuid(userId)) {
        final response = await _client
            .from('completed_lessons')
            .select('topic')
            .eq('user_id', userId);
        final List<dynamic> data = response as List<dynamic>;
        for (var row in data) {
          if (row['topic'] != null) {
            completed.add(row['topic'] as String);
          }
        }
      }
    } catch (e) {
      debugPrint('Notice fetching completed topics: $e');
    }
    return completed;
  }

  Future<void> markTopicCompleted({required String userId, required String topic}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = 'completed_topics_$userId';
      final current = prefs.getStringList(key) ?? [];
      if (!current.contains(topic)) {
        current.add(topic);
        await prefs.setStringList(key, current);
      }
    } catch (e) {
      debugPrint('Notice marking topic completed: $e');
    }
  }


  Future<void> upsertSentencePair(SentencePair pair) async {
    try {
      await _client.from('sentence_pairs').upsert(pair.toJson());
    } catch (e) {
      debugPrint('Notice upserting sentence pair: $e');
    }
  }

  Future<List<SentencePair>> fetchSentencePairs({
    required String topicCategory,
    String? languageCode,
  }) async {
    try {
      final code = LessonCatalog.normalizeLanguageCode(languageCode ?? 'es');
      var query = _client.from('sentence_pairs').select().eq('language_code', code);
      if (topicCategory.isNotEmpty &&
          topicCategory != 'All Topics' &&
          topicCategory != 'General Vocabulary' &&
          topicCategory != 'Advanced Fluency') {
        query = query.eq('topic_category', topicCategory);
      }
      final response = await query.limit(50);
      List<dynamic> data = response as List<dynamic>;

      if (data.isEmpty) {
        // Query sentence pairs for this language from the 1.9M dataset
        final fallbackResponse = await _client
            .from('sentence_pairs')
            .select()
            .eq('language_code', code)
            .limit(50);
        data = fallbackResponse as List<dynamic>;
      }

      if (data.isNotEmpty) {
        return data.map((j) => SentencePair.fromJson(j as Map<String, dynamic>)).toList();
      }
    } catch (e) {
      debugPrint('Notice fetching sentence pairs from Supabase: $e');
    }

    final catalogPairs = LessonCatalog.getSentencePairs(
      topic: topicCategory,
      targetLanguage: languageCode ?? 'Spanish',
    );

    // Auto-seed catalog sentence pairs to Supabase in background
    for (final pair in catalogPairs) {
      upsertSentencePair(pair);
    }

    return catalogPairs;
  }

  Future<List<SrsReviewItem>> fetchDueSrsItems({required String userId}) async {
    if (!_isValidUuid(userId)) {
      debugPrint('Notice: Guest or unauthenticated user ID "$userId" is not a valid UUID. Skipping Supabase due SRS fetch.');
      return [];
    }
    try {
      final nowIso = DateTime.now().toIso8601String();
      final response = await _client
          .from('srs_review_items')
          .select()
          .eq('user_id', userId)
          .lte('next_review_date', nowIso);

      final List<dynamic> data = response as List<dynamic>;
      if (data.isNotEmpty) {
        return data.map((j) => SrsReviewItem.fromJson(j as Map<String, dynamic>)).toList();
      }
    } catch (e) {
      debugPrint('Notice fetching due SRS items: $e');
    }
    return [];
  }

  Future<void> upsertSrsReviewItem(SrsReviewItem item, {SentencePair? sentencePair}) async {
    if (!_isValidUuid(item.userId)) {
      debugPrint('Notice: Guest user ID "${item.userId}" is not a valid UUID. Skipping Supabase SRS upsert.');
      return;
    }
    try {
      if (sentencePair != null) {
        await upsertSentencePair(sentencePair);
      }
      final payload = item.toJson();
      if (item.id == null || item.id!.isEmpty) {
        payload.remove('id');
      }
      await _client.from('srs_review_items').upsert(
            payload,
            onConflict: 'user_id, sentence_id',
          );
    } catch (e) {
      debugPrint('Notice upserting SRS review item: $e');
    }
  }

  Future<SentencePair?> fetchSentencePairById(String sentenceId) async {
    try {
      final response = await _client
          .from('sentence_pairs')
          .select()
          .eq('id', sentenceId)
          .maybeSingle();
      if (response != null) {
        return SentencePair.fromJson(response);
      }
    } catch (e) {
      debugPrint('Notice fetching sentence pair by id: $e');
    }
    return null;
  }



  Future<bool> signInWithGoogle() async {
    try {
      const String redirectTo = kIsWeb
          ? 'http://localhost:5000/'
          : 'io.supabase.limpede://login-callback/';

      return await _client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: redirectTo,
      );
    } catch (e) {
      debugPrint('Error signing in with Google: $e');
      rethrow;
    }
  }

  Future<bool> signInWithDiscord() async {
    try {
      const String redirectTo = kIsWeb
          ? 'http://localhost:5000/'
          : 'io.supabase.limpede://login-callback/';

      return await _client.auth.signInWithOAuth(
        OAuthProvider.discord,
        redirectTo: redirectTo,
      );
    } catch (e) {
      debugPrint('Error signing in with Discord: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  Future<UserProfile?> fetchUserProfile(String userId) async {
    try {
      final response = await _client
          .from('user_profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (response == null) {
        final user = currentUser;
        if (user != null && user.id == userId) {
          final fallbackProfile = UserProfile(
            id: userId,
            username: user.userMetadata?['full_name'] as String? ??
                user.userMetadata?['name'] as String? ??
                user.email?.split('@').first ??
                'Learner',
            avatarUrl: user.userMetadata?['avatar_url'] as String?,
            xp: 0,
            streak: 1,
            lastActiveAt: DateTime.now(),
            createdAt: DateTime.now(),
          );

          try {
            await upsertUserProfile(fallbackProfile);
          } catch (e) {
            debugPrint('Auto-create profile insert notice: $e');
          }
          return fallbackProfile;
        }
        return null;
      }

      return UserProfile.fromJson(response);
    } catch (e) {
      debugPrint('Error fetching user profile: $e');
      final user = currentUser;
      if (user != null) {
        return UserProfile(
          id: userId,
          username: user.email?.split('@').first ?? 'Learner',
          avatarUrl: user.userMetadata?['avatar_url'] as String?,
          xp: 0,
          streak: 1,
        );
      }
      return null;
    }
  }

  Future<List<UserProfile>> fetchLeaderboard() async {
    try {
      final response = await _client
          .from('user_profiles')
          .select()
          .order('xp', ascending: false)
          .limit(50);

      final List<dynamic> data = response as List<dynamic>;
      final list = data.map((json) => UserProfile.fromJson(json as Map<String, dynamic>)).toList();
      if (list.isNotEmpty) return list;
    } catch (e) {
      debugPrint('Leaderboard fetch notice: $e');
    }

    final user = currentUser;
    return [
      const UserProfile(
        id: 'friend_1',
        username: 'Alex (Friend)',
        xp: 210,
        streak: 4,
      ),
      const UserProfile(
        id: 'friend_2',
        username: 'Elena (Friend)',
        xp: 180,
        streak: 3,
      ),
      UserProfile(
        id: user?.id ?? 'you',
        username: user?.email?.split('@').first ?? 'You',
        avatarUrl: user?.userMetadata?['avatar_url'] as String?,
        xp: 125,
        streak: 1,
      ),
      const UserProfile(
        id: 'friend_3',
        username: 'Marc (Friend)',
        xp: 95,
        streak: 2,
      ),
    ];
  }

  Future<void> upsertUserProfile(UserProfile profile) async {
    await _client.from('user_profiles').upsert({
      'id': profile.id,
      'username': profile.username,
      'avatar_url': profile.avatarUrl,
      'xp': profile.xp,
      'streak': profile.streak,
      'last_active_at': (profile.lastActiveAt ?? DateTime.now()).toIso8601String(),
    });
  }

  Future<void> completeLessonAndAwardXp({
    required String userId,
    required String topic,
    int xpEarned = 25,
  }) async {
    final profile = await fetchUserProfile(userId);
    final currentXp = profile?.xp ?? 0;
    final currentStreak = profile?.streak ?? 0;
    final lastActive = profile?.lastActiveAt;

    final now = DateTime.now();
    int newStreak = currentStreak;

    if (lastActive == null) {
      newStreak = 1;
    } else {
      final differenceInDays = now.difference(lastActive).inDays;
      if (differenceInDays == 1) {
        newStreak += 1;
      } else if (differenceInDays > 1) {
        newStreak = 1;
      } else if (currentStreak == 0) {
        newStreak = 1;
      }
    }

    final newXp = currentXp + xpEarned;

    await markTopicCompleted(userId: userId, topic: topic);

    if (!_isValidUuid(userId)) {
      debugPrint('Notice: Guest user ID "$userId" is not a valid UUID. Skipping Supabase XP write.');
      return;
    }

    try {
      await _client.from('user_profiles').upsert({
        'id': userId,
        'username': profile?.username ?? 'Learner',
        'avatar_url': profile?.avatarUrl,
        'xp': newXp,
        'streak': newStreak,
        'last_active_at': now.toIso8601String(),
      });

      await _client.from('completed_lessons').insert({
        'user_id': userId,
        'topic': topic,
        'xp_earned': xpEarned,
        'completed_at': now.toIso8601String(),
      });
    } catch (e) {
      debugPrint('Notice completing lesson: $e');
    }
  }
}

