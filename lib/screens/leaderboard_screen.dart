import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/league.dart';
import '../providers/league_provider.dart';

class LeaderboardScreen extends ConsumerWidget {
  const LeaderboardScreen({super.key});

  String _formatTimeRemaining(DateTime weekEndsAt) {
    final now = DateTime.now().toUtc();
    final diff = weekEndsAt.difference(now);
    if (diff.isNegative) return 'Resetting...';
    final days = diff.inDays;
    final hours = diff.inHours % 24;
    final minutes = diff.inMinutes % 60;

    if (days > 0) {
      return '${days}d ${hours}h left';
    }
    return '${hours}h ${minutes}m left';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final leagueAsync = ref.watch(leagueControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.emoji_events_rounded, color: Colors.amber),
            SizedBox(width: 8),
            Text(
              'Weekly League',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Refresh League',
            onPressed: () => ref.read(leagueControllerProvider.notifier).refresh(),
          ),
        ],
      ),
      body: leagueAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
              const SizedBox(height: 12),
              Text('Failed to load league cohort', style: theme.textTheme.titleMedium),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => ref.read(leagueControllerProvider.notifier).refresh(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (leagueState) {
          final tier = leagueState.currentTier;
          final members = leagueState.members;
          final timeRemaining = _formatTimeRemaining(leagueState.weekEndsAt);

          return RefreshIndicator(
            onRefresh: () async {
              await ref.read(leagueControllerProvider.notifier).refresh();
            },
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              itemCount: members.length + 1, // +1 for the League Header Card
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _buildLeagueHeader(theme, tier, timeRemaining, leagueState.currentUserRank);
                }

                final memberIndex = index - 1;
                final member = members[memberIndex];
                final rank = member.rank;

                return Column(
                  children: [
                    // Section Divider after Rank 7 (Promotion Threshold)
                    if (rank == 8)
                      _buildZoneDivider(
                        theme: theme,
                        label: 'PROMOTION ZONE (TOP 7 PROMOTE)',
                        color: Colors.green,
                        icon: Icons.keyboard_double_arrow_up_rounded,
                      ),

                    // Section Divider before Rank 26 (Demotion Threshold)
                    if (rank == 26 && tier != LeagueTier.bronze)
                      _buildZoneDivider(
                        theme: theme,
                        label: 'DEMOTION ZONE (BOTTOM 5 RELEGATE)',
                        color: Colors.redAccent,
                        icon: Icons.keyboard_double_arrow_down_rounded,
                      ),

                    _buildMemberCard(theme, member, rank),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildLeagueHeader(
    ThemeData theme,
    LeagueTier tier,
    String timeRemaining,
    int userRank,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            tier.primaryColor.withValues(alpha: 0.85),
            tier.primaryColor.withValues(alpha: 0.5),
            theme.colorScheme.surfaceContainerHighest,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: tier.primaryColor.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  tier.emblemEmoji,
                  style: const TextStyle(fontSize: 36),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tier.displayName.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Top 7 promote to ${tier.nextTier?.displayName ?? "Ultimate League"}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.95),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.timer_outlined, color: Colors.white, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      timeRemaining,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.person_pin_circle_rounded, color: Colors.white, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      'Your Rank: #$userRank',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildZoneDivider({
    required ThemeData theme,
    required String label,
    required Color color,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: color,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Divider(color: color.withValues(alpha: 0.4), thickness: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberCard(ThemeData theme, LeagueMember member, int rank) {
    final isUser = member.isCurrentUser;
    final isPromotion = rank <= 7;
    final isDemotion = member.zone == LeagueZone.demotion;

    Color rankColor;
    Widget rankWidget;

    if (rank == 1) {
      rankColor = Colors.amber.shade600;
      rankWidget = const Text('🥇', style: TextStyle(fontSize: 22));
    } else if (rank == 2) {
      rankColor = Colors.grey.shade400;
      rankWidget = const Text('🥈', style: TextStyle(fontSize: 22));
    } else if (rank == 3) {
      rankColor = Colors.brown.shade400;
      rankWidget = const Text('🥉', style: TextStyle(fontSize: 22));
    } else {
      rankColor = isPromotion
          ? Colors.green
          : isDemotion
              ? Colors.redAccent
              : theme.colorScheme.onSurfaceVariant;
      rankWidget = Text(
        '#$rank',
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 15,
          color: rankColor,
        ),
      );
    }

    return Card(
      elevation: isUser ? 4 : 1,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: isUser
            ? BorderSide(color: theme.colorScheme.primary, width: 2)
            : isPromotion && rank <= 3
                ? BorderSide(color: Colors.amber.withValues(alpha: 0.6), width: 1.5)
                : BorderSide.none,
      ),
      color: isUser
          ? theme.colorScheme.primaryContainer.withValues(alpha: 0.4)
          : theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            SizedBox(
              width: 34,
              child: Center(child: rankWidget),
            ),
            const SizedBox(width: 10),
            CircleAvatar(
              radius: 20,
              backgroundColor: isUser
                  ? theme.colorScheme.primary
                  : theme.colorScheme.surfaceContainerHighest,
              backgroundImage: member.avatarUrl != null ? NetworkImage(member.avatarUrl!) : null,
              child: member.avatarUrl == null
                  ? Text(
                      member.username.isNotEmpty ? member.username[0].toUpperCase() : 'U',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isUser ? Colors.white : theme.colorScheme.onSurfaceVariant,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          member.username,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: isUser ? FontWeight.w900 : FontWeight.bold,
                            fontSize: 15,
                            color: isUser ? theme.colorScheme.primary : theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      if (isUser) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'YOU',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.white),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        isPromotion
                            ? Icons.arrow_upward_rounded
                            : isDemotion
                                ? Icons.arrow_downward_rounded
                                : Icons.remove_rounded,
                        size: 14,
                        color: isPromotion
                            ? Colors.green
                            : isDemotion
                                ? Colors.redAccent
                                : Colors.grey,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        isPromotion
                            ? 'Promotion zone'
                            : isDemotion
                                ? 'Demotion zone'
                                : 'Safe zone',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: isPromotion
                              ? Colors.green
                              : isDemotion
                                  ? Colors.redAccent
                                  : theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: isUser
                    ? theme.colorScheme.primaryContainer
                    : theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Icon(Icons.bolt, color: Colors.amber.shade700, size: 18),
                  const SizedBox(width: 2),
                  Text(
                    '${member.weeklyXp} XP',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
