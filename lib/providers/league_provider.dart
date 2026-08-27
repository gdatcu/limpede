import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/league.dart';
import 'auth_provider.dart';

part 'league_provider.g.dart';

@riverpod
class LeagueController extends _$LeagueController {
  @override
  Future<LeagueState> build() async {
    return _fetchLeagueState();
  }

  DateTime _getNextSundayMidnightUtc() {
    final now = DateTime.now().toUtc();
    // In Dart, weekday: 1 = Mon, ..., 7 = Sun
    final daysUntilSunday = (7 - now.weekday) % 7;
    final nextSunday = now.add(Duration(days: daysUntilSunday));
    return DateTime.utc(
      nextSunday.year,
      nextSunday.month,
      nextSunday.day,
      23,
      59,
      59,
    );
  }

  Future<LeagueState> _fetchLeagueState() async {
    final user = ref.watch(authNotifierProvider).value;
    final userProfile = await ref.watch(currentUserProfileProvider.future);
    final userId = user?.id ?? userProfile?.id ?? 'guest_local';
    final tier = LeagueTier.fromString(userProfile?.leagueTier);

    final supabase = ref.read(supabaseServiceProvider);
    final members = await supabase.fetchWeeklyLeagueCohort(
      userId: userId,
      tier: tier,
    );

    final userIndex = members.indexWhere((m) => m.isCurrentUser || m.userId == userId);
    final userRank = userIndex >= 0 ? userIndex + 1 : 1;

    return LeagueState(
      currentTier: tier,
      members: members,
      weekEndsAt: _getNextSundayMidnightUtc(),
      currentUserRank: userRank,
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchLeagueState());
  }
}
