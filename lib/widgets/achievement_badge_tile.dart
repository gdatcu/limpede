import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/achievement.dart';
import '../providers/achievement_provider.dart';
import '../providers/feedback_provider.dart';

class AchievementBadgeTile extends ConsumerWidget {
  final Achievement achievement;

  const AchievementBadgeTile({
    super.key,
    required this.achievement,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final feedback = ref.read(feedbackServiceProvider);
    final isUnlocked = achievement.isUnlocked;
    final isClaimed = achievement.isClaimed;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isUnlocked
            ? theme.colorScheme.surface
            : theme.colorScheme.surface.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isClaimed
              ? Colors.green.withValues(alpha: 0.4)
              : isUnlocked
                  ? Colors.amber.withValues(alpha: 0.6)
                  : theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
          width: isUnlocked ? 1.8 : 1.0,
        ),
        boxShadow: isUnlocked
            ? [
                BoxShadow(
                  color: isClaimed
                      ? Colors.green.withValues(alpha: 0.08)
                      : Colors.amber.withValues(alpha: 0.12),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ]
            : [],
      ),
      child: Row(
        children: [
          // Emoji Trophy Badge
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isUnlocked
                    ? [Colors.amber.shade300, Colors.orange.shade400]
                    : [Colors.grey.shade700, Colors.grey.shade800],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: isUnlocked
                  ? [
                      BoxShadow(
                        color: Colors.amber.withValues(alpha: 0.3),
                        blurRadius: 8,
                      ),
                    ]
                  : [],
            ),
            child: Center(
              child: Text(
                achievement.iconEmoji,
                style: TextStyle(
                  fontSize: 26,
                  color: isUnlocked ? null : Colors.white54,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Details & Progress Bar
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      achievement.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    // Star rating for tier
                    Row(
                      children: List.generate(
                        achievement.maxTier,
                        (index) => Icon(
                          index < achievement.tier
                              ? Icons.star_rounded
                              : Icons.star_outline_rounded,
                          size: 16,
                          color: index < achievement.tier
                              ? Colors.amber
                              : Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  achievement.description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),

                // Linear Progress
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: achievement.progressRatio,
                          minHeight: 6,
                          backgroundColor: theme.colorScheme.surfaceContainerHighest,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isClaimed
                                ? Colors.greenAccent
                                : isUnlocked
                                    ? Colors.amberAccent
                                    : theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${achievement.currentValue}/${achievement.targetValue}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isUnlocked ? Colors.amber : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),

          // Action State (Claim / Claimed / Locked)
          if (isClaimed)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle_rounded, color: Colors.greenAccent, size: 16),
                  SizedBox(width: 4),
                  Text(
                    'Done',
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          else if (isUnlocked)
            FilledButton(
              onPressed: () {
                feedback.playLevelUpFeedback();
                ref
                    .read(achievementNotifierProvider.notifier)
                    .claimAchievement(achievement.id);
              },
              style: FilledButton.styleFrom(
                backgroundColor: Colors.amberAccent,
                foregroundColor: Colors.black87,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '+${achievement.dropletReward}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(width: 2),
                  const Text('💧', style: TextStyle(fontSize: 12)),
                ],
              ),
            )
          else
            Icon(
              Icons.lock_outline_rounded,
              color: Colors.grey.shade600,
              size: 20,
            ),
        ],
      ),
    );
  }
}
