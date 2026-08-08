import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/user_profile.dart';
import 'auth_provider.dart';

part 'user_provider.g.dart';

@riverpod
Future<List<UserProfile>> leaderboard(Ref ref) async {
  final supabase = ref.watch(supabaseServiceProvider);
  return supabase.fetchLeaderboard();
}

@riverpod
Future<Set<String>> completedTopics(Ref ref) async {
  final userProfile = ref.watch(currentUserProfileProvider).asData?.value;
  final userId = userProfile?.id ?? 'guest_local';
  final supabase = ref.watch(supabaseServiceProvider);
  return supabase.fetchCompletedTopics(userId);
}

@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  void build() {}

  Future<void> awardXp({
    required String topic,
    int xpEarned = 25,
  }) async {
    final user = ref.read(authNotifierProvider).value;
    final userId = user?.id ?? 'guest_local';

    final supabase = ref.read(supabaseServiceProvider);
    await supabase.completeLessonAndAwardXp(
      userId: userId,
      topic: topic,
      xpEarned: xpEarned,
    );

    ref.invalidate(currentUserProfileProvider);
    ref.invalidate(leaderboardProvider);
    ref.invalidate(completedTopicsProvider);
  }
}

