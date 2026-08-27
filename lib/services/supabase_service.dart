import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/league.dart';
import '../models/srs_models.dart';
import '../models/user_profile.dart';
import '../utils/language_utils.dart';

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

  Future<List<String>> fetchTopicCategories({required String targetLanguage}) async {
    final langCode = LanguageUtils.normalizeLanguageCode(targetLanguage);
    try {
      final response = await _client
          .from('sentence_pairs')
          .select('topic_category')
          .eq('language_code', langCode);

      final List<dynamic> data = response as List<dynamic>;
      final Set<String> categories = {};
      for (final row in data) {
        final cat = row['topic_category'] as String?;
        if (cat != null && cat.trim().isNotEmpty) {
          categories.add(cat.trim());
        }
      }
      if (categories.isNotEmpty) {
        return categories.toList();
      }
    } catch (e) {
      debugPrint('Notice fetching topic categories from Supabase: $e');
    }
    return [];
  }

  Future<List<SentencePair>> fetchSentencePairs({
    required String topicCategory,
    String? languageCode,
    int limit = 10,
  }) async {
    final code = LanguageUtils.normalizeLanguageCode(languageCode ?? 'es');
    try {
      var query = _client.from('sentence_pairs').select().eq('language_code', code);
      if (topicCategory.isNotEmpty &&
          topicCategory != 'All Topics' &&
          topicCategory != 'General Vocabulary' &&
          topicCategory != 'Advanced Fluency') {
        query = query.eq('topic_category', topicCategory);
      }
      final response = await query.limit(limit);
      List<dynamic> data = response as List<dynamic>;

      if (data.isNotEmpty) {
        return data.map((j) => SentencePair.fromJson(j as Map<String, dynamic>)).toList();
      }
    } catch (e) {
      debugPrint('Notice fetching sentence pairs from Supabase: $e');
    }

    return _generateFallbackSentencePairs(topicCategory: topicCategory, languageCode: code, limit: limit);
  }

  List<SentencePair> _generateFallbackSentencePairs({
    required String topicCategory,
    required String languageCode,
    int limit = 10,
  }) {
    return LanguageUtils.getFallbackSentencePairs(
      topicCategory: topicCategory,
      targetLanguage: languageCode,
      limit: limit,
    );
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
      if (!kIsWeb) {
        try {
          final GoogleSignIn googleSignIn = GoogleSignIn(
            scopes: ['email', 'profile'],
          );
          final googleUser = await googleSignIn.signIn();
          if (googleUser != null) {
            final googleAuth = await googleUser.authentication;
            final idToken = googleAuth.idToken;
            final accessToken = googleAuth.accessToken;

            if (idToken != null) {
              final res = await _client.auth.signInWithIdToken(
                provider: OAuthProvider.google,
                idToken: idToken,
                accessToken: accessToken,
              );
              if (res.session != null) {
                return true;
              }
            }
          } else {
            // User cancelled Google sign in dialog
            return false;
          }
        } catch (e) {
          debugPrint('Native Google sign-in notice: $e. Falling back to OAuth browser redirect.');
        }
      }

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
            gems: 50,
            streakFreezes: 0,
            weeklyXp: 0,
            leagueTier: 'bronze',
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
          gems: 50,
          streakFreezes: 0,
          weeklyXp: 0,
          leagueTier: 'bronze',
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
        gems: 120,
        streakFreezes: 1,
        weeklyXp: 95,
        leagueTier: 'bronze',
      ),
      const UserProfile(
        id: 'friend_2',
        username: 'Elena (Friend)',
        xp: 180,
        streak: 3,
        gems: 90,
        streakFreezes: 0,
        weeklyXp: 80,
        leagueTier: 'bronze',
      ),
      UserProfile(
        id: user?.id ?? 'you',
        username: user?.email?.split('@').first ?? 'You',
        avatarUrl: user?.userMetadata?['avatar_url'] as String?,
        xp: 125,
        streak: 1,
        gems: 50,
        streakFreezes: 0,
        weeklyXp: 45,
        leagueTier: 'bronze',
      ),
      const UserProfile(
        id: 'friend_3',
        username: 'Marc (Friend)',
        xp: 95,
        streak: 2,
        gems: 40,
        streakFreezes: 0,
        weeklyXp: 30,
        leagueTier: 'bronze',
      ),
    ];
  }

  Future<void> upsertUserProfile(UserProfile profile) async {
    final payload = {
      'id': profile.id,
      'username': profile.username,
      'avatar_url': profile.avatarUrl,
      'xp': profile.xp,
      'streak': profile.streak,
      'gems': profile.gems,
      'streak_freezes': profile.streakFreezes,
      'weekly_xp': profile.weeklyXp,
      'league_tier': profile.leagueTier,
      'last_active_at': (profile.lastActiveAt ?? DateTime.now()).toIso8601String(),
    };

    if (!_isValidUuid(profile.id)) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('guest_profile', profile.toJson().toString());
      return;
    }

    try {
      await _client.from('user_profiles').upsert(payload);
    } catch (e) {
      debugPrint('Notice upserting user profile: $e');
    }
  }

  Future<void> completeLessonAndAwardXp({
    required String userId,
    required String topic,
    int xpEarned = 25,
    bool isReview = false,
  }) async {
    final profile = await fetchUserProfile(userId);
    final currentXp = profile?.xp ?? 0;
    final currentStreak = profile?.streak ?? 0;
    final currentGems = profile?.gems ?? 50;
    final currentStreakFreezes = profile?.streakFreezes ?? 0;
    final currentWeeklyXp = profile?.weeklyXp ?? 0;
    final lastActive = profile?.lastActiveAt;

    final now = DateTime.now();
    int newStreak = currentStreak;
    int newStreakFreezes = currentStreakFreezes;

    if (lastActive == null) {
      newStreak = 1;
    } else {
      final differenceInDays = now.difference(lastActive).inDays;
      if (differenceInDays == 1) {
        newStreak += 1;
      } else if (differenceInDays == 2 && currentStreakFreezes > 0) {
        // Protected by Streak Freeze! 🧊
        newStreakFreezes = (currentStreakFreezes - 1).clamp(0, 2);
        newStreak += 1;
        debugPrint('🧊 Streak freeze consumed! Streak preserved at $newStreak.');
      } else if (differenceInDays > 1) {
        newStreak = 1;
      } else if (currentStreak == 0) {
        newStreak = 1;
      }
    }

    final gemsEarned = isReview ? 10 : 5;
    final newGems = currentGems + gemsEarned;
    final newXp = currentXp + xpEarned;
    final newWeeklyXp = currentWeeklyXp + xpEarned;

    await markTopicCompleted(userId: userId, topic: topic);

    final updatedProfile = (profile ?? UserProfile(id: userId, username: 'Learner')).copyWith(
      xp: newXp,
      streak: newStreak,
      gems: newGems,
      streakFreezes: newStreakFreezes,
      weeklyXp: newWeeklyXp,
      lastActiveAt: now,
    );

    await upsertUserProfile(updatedProfile);

    if (_isValidUuid(userId)) {
      try {
        await _client.from('completed_lessons').insert({
          'user_id': userId,
          'topic': topic,
          'xp_earned': xpEarned,
          'completed_at': now.toIso8601String(),
        });
      } catch (e) {
        debugPrint('Notice logging completed lesson: $e');
      }
    }
  }

  Future<bool> purchaseStreakFreeze(String userId) async {
    final profile = await fetchUserProfile(userId);
    if (profile == null) return false;

    if (profile.gems < 100 || profile.streakFreezes >= 2) {
      return false; // Not enough gems or already max capacity
    }

    final updated = profile.copyWith(
      gems: profile.gems - 100,
      streakFreezes: profile.streakFreezes + 1,
    );
    await upsertUserProfile(updated);
    return true;
  }

  Future<bool> purchaseHeartRefill(String userId) async {
    final profile = await fetchUserProfile(userId);
    if (profile == null) return false;

    if (profile.gems < 50) {
      return false; // Not enough gems
    }

    final updated = profile.copyWith(
      gems: profile.gems - 50,
    );
    await upsertUserProfile(updated);
    return true;
  }

  Future<void> claimQuestReward({
    required String userId,
    required int gemReward,
    required int xpReward,
  }) async {
    final profile = await fetchUserProfile(userId);
    if (profile == null) return;

    final updated = profile.copyWith(
      gems: profile.gems + gemReward,
      xp: profile.xp + xpReward,
      weeklyXp: profile.weeklyXp + xpReward,
    );
    await upsertUserProfile(updated);
  }

  Future<List<LeagueMember>> fetchWeeklyLeagueCohort({
    required String userId,
    required LeagueTier tier,
  }) async {
    final List<LeagueMember> cohort = [];
    final profile = await fetchUserProfile(userId);
    final userWeeklyXp = profile?.weeklyXp ?? 45;
    final username = profile?.username ?? 'You';

    try {
      if (_isValidUuid(userId)) {
        final response = await _client
            .from('user_profiles')
            .select()
            .eq('league_tier', tier.name)
            .order('weekly_xp', ascending: false)
            .limit(30);

        final List<dynamic> data = response as List<dynamic>;
        for (int i = 0; i < data.length; i++) {
          final p = UserProfile.fromJson(data[i] as Map<String, dynamic>);
          cohort.add(LeagueMember(
            userId: p.id,
            username: p.username,
            avatarUrl: p.avatarUrl,
            weeklyXp: p.weeklyXp,
            rank: i + 1,
            tier: tier,
            isCurrentUser: p.id == userId,
          ));
        }
      }
    } catch (e) {
      debugPrint('Notice querying Supabase league cohort: $e');
    }

    // If cohort is less than 30, deterministically generate competitive cohort peers
    if (cohort.length < 30) {
      final names = [
        'Matei', 'Sophie', 'Lucas', 'Lina', 'David', 'Emma', 'Leo', 'Mia',
        'Noah', 'Olivia', 'Arthur', 'Chloe', 'Gabriel', 'Zoe', 'Julian', 'Elena',
        'Daniel', 'Sara', 'Thomas', 'Laura', 'Felix', 'Amelia', 'Liam', 'Nora',
        'Victor', 'Eva', 'Hugo', 'Clara', 'Oscar', 'Maya'
      ];

      final currentInCohort = cohort.any((m) => m.userId == userId);

      final List<Map<String, dynamic>> rawMembers = [];

      for (int i = 0; i < 29; i++) {
        final name = names[i % names.length];
        // Generate believable distribution of scores around the user's score
        final score = ((30 - i) * 12 + (i.hashCode % 15)).clamp(5, 500);
        rawMembers.add({
          'id': 'cohort_peer_$i',
          'name': name,
          'score': score,
          'isUser': false,
        });
      }

      if (!currentInCohort) {
        rawMembers.add({
          'id': userId,
          'name': username,
          'score': userWeeklyXp,
          'isUser': true,
        });
      }

      // Sort descending by score
      rawMembers.sort((a, b) => (b['score'] as int).compareTo(a['score'] as int));

      cohort.clear();
      for (int r = 0; r < rawMembers.length && r < 30; r++) {
        final item = rawMembers[r];
        cohort.add(LeagueMember(
          userId: item['id'] as String,
          username: item['name'] as String,
          weeklyXp: item['score'] as int,
          rank: r + 1,
          tier: tier,
          isCurrentUser: item['isUser'] as bool,
        ));
      }
    }

    return cohort;
  }
}


