import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../providers/course_provider.dart';
import '../providers/feedback_provider.dart';
import '../providers/match_madness_provider.dart';
import '../providers/srs_lesson_provider.dart';
import '../utils/language_utils.dart';

class MatchMadnessScreen extends ConsumerStatefulWidget {
  const MatchMadnessScreen({super.key});

  @override
  ConsumerState<MatchMadnessScreen> createState() => _MatchMadnessScreenState();
}

class _MatchMadnessScreenState extends ConsumerState<MatchMadnessScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final courseState = ref.read(courseStateNotifierProvider);
      final syncEngine = ref.read(syncEngineServiceProvider);
      final supabaseService = ref.read(supabaseServiceProvider);

      // Load pairs from SQLite or Supabase
      var pairs = await syncEngine.getSentencePairsForTopic(
        topicCategory: 'Basics: Saying hello and goodbye',
        languageCode: courseState.queryLanguageCode,
      );

      if (pairs.length < 10) {
        final remotePairs = await supabaseService.fetchSentencePairs(
          topicCategory: 'Basics: Saying hello and goodbye',
          languageCode: courseState.queryLanguageCode,
          limit: 25,
        );
        if (remotePairs.isNotEmpty) {
          pairs = remotePairs;
        }
      }

      if (pairs.isEmpty) {
        pairs = LanguageUtils.getFallbackSentencePairs(
          topicCategory: 'Basics: Saying hello and goodbye',
          targetLanguage: courseState.targetLanguage,
          limit: 25,
        );
      }

      ref.read(matchMadnessControllerProvider.notifier).startBlitz(pairs);
    });
  }

  Color _getTimerColor(int seconds) {
    if (seconds > 20) return Colors.greenAccent;
    if (seconds > 10) return Colors.orangeAccent;
    return Colors.redAccent;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(matchMadnessControllerProvider);
    final feedback = ref.read(feedbackServiceProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.pop(),
        ),
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.bolt_rounded, color: Colors.amberAccent, size: 24),
            SizedBox(width: 6),
            Text(
              'Match Madness',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          // Multiplier Badge
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: state.multiplier >= 2.0
                    ? [Colors.deepOrange, Colors.amber]
                    : [Colors.purple, Colors.deepPurpleAccent],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.amber.withValues(alpha: 0.3),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Text(
              '${state.multiplier}x 🔥',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
      body: state.isGameOver
          ? _buildGameOverView(context, state)
          : SafeArea(
              child: Column(
                children: [
                  // Timer Bar & Score
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Timer Indicator
                        Row(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 44,
                                  height: 44,
                                  child: CircularProgressIndicator(
                                    value: state.timeRemainingSeconds / 60.0,
                                    strokeWidth: 4,
                                    backgroundColor: Colors.white12,
                                    color: _getTimerColor(state.timeRemainingSeconds),
                                  ),
                                ),
                                Text(
                                  '${state.timeRemainingSeconds}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: _getTimerColor(state.timeRemainingSeconds),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'TIME LEFT',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  '${state.totalMatches} Matches',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Points
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'SCORE',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              '${state.score} pts',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const Divider(height: 20),

                  // Match Grid (2 Columns)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          // Left Column (Source language tiles)
                          Expanded(
                            child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.sourceTiles.length,
                              separatorBuilder: (_, __) => const SizedBox(height: 10),
                              itemBuilder: (context, index) {
                                final tile = state.sourceTiles[index];
                                final isSelected = state.selectedSourceId == tile.id;
                                return _buildTileCard(
                                  context: context,
                                  tile: tile,
                                  isSelected: isSelected,
                                  onTap: () {
                                    feedback.playSelectionFeedback();
                                    ref
                                        .read(matchMadnessControllerProvider.notifier)
                                        .selectTile(tile);
                                  },
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 14),

                          // Right Column (Target translation tiles)
                          Expanded(
                            child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.targetTiles.length,
                              separatorBuilder: (_, __) => const SizedBox(height: 10),
                              itemBuilder: (context, index) {
                                final tile = state.targetTiles[index];
                                final isSelected = state.selectedTargetId == tile.id;
                                return _buildTileCard(
                                  context: context,
                                  tile: tile,
                                  isSelected: isSelected,
                                  onTap: () {
                                    feedback.playSelectionFeedback();
                                    ref
                                        .read(matchMadnessControllerProvider.notifier)
                                        .selectTile(tile);
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildTileCard({
    required BuildContext context,
    required MatchTile tile,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primaryContainer
              : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
            width: isSelected ? 2.5 : 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? theme.colorScheme.primary.withValues(alpha: 0.25)
                  : Colors.black.withValues(alpha: 0.04),
              blurRadius: isSelected ? 10 : 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            tile.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
              color: isSelected
                  ? theme.colorScheme.onPrimaryContainer
                  : theme.colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGameOverView(BuildContext context, MatchMadnessState state) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Victory Icon
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.emoji_events_rounded,
                color: Colors.amber,
                size: 64,
              ),
            ),
            const SizedBox(height: 20),

            Text(
              'Time\'s Up! ⚡',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'High-Speed Vocabulary Workout Complete',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 28),

            // Summary Stats Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatPill('Matches', '${state.totalMatches}', Icons.check_circle_outline),
                  _buildStatPill('Max Combo', '${state.maxComboStreak}x', Icons.local_fire_department),
                  _buildStatPill('XP Earned', '+${state.xpEarned}', Icons.bolt),
                  _buildStatPill('Droplets', '+${state.dropletsEarned} 💧', Icons.water_drop),
                ],
              ),
            ),
            const SizedBox(height: 36),

            // Done Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton(
                onPressed: () => context.pop(),
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatPill(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 22, color: Colors.amber),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
      ],
    );
  }
}
