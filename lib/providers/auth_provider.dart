import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_profile.dart';
import '../services/supabase_service.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
SupabaseService supabaseService(Ref ref) {
  return SupabaseService();
}

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Stream<User?> build() {
    final supabase = ref.watch(supabaseServiceProvider);
    return supabase.authStateChanges.map((event) => event.session?.user);
  }

  Future<bool> signInWithGoogle() async {
    return ref.read(supabaseServiceProvider).signInWithGoogle();
  }

  Future<bool> signInWithDiscord() async {
    return ref.read(supabaseServiceProvider).signInWithDiscord();
  }

  Future<void> signOut() async {
    await ref.read(supabaseServiceProvider).signOut();
  }

  Future<void> completeLesson({
    required String topic,
    int xpEarned = 25,
  }) async {
    final user = state.value;
    if (user == null) return;

    final supabase = ref.read(supabaseServiceProvider);
    await supabase.completeLessonAndAwardXp(
      userId: user.id,
      topic: topic,
      xpEarned: xpEarned,
    );

    ref.invalidate(currentUserProfileProvider);
  }
}

@riverpod
Future<UserProfile?> currentUserProfile(Ref ref) async {
  final authState = ref.watch(authNotifierProvider);
  final user = authState.value;

  if (user == null) {
    return null;
  }

  return ref.watch(supabaseServiceProvider).fetchUserProfile(user.id);
}
