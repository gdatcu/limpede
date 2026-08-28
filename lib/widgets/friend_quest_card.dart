import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/feedback_provider.dart';
import '../providers/friend_quest_provider.dart';

class FriendQuestCard extends ConsumerWidget {
  const FriendQuestCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final questAsync = ref.watch(friendQuestNotifierProvider);
    final quest = questAsync.value;
    final feedback = ref.read(feedbackServiceProvider);

    if (quest == null) {
      return const SizedBox.shrink();
    }

    final isCompleted = quest.isCompleted;
    final isClaimed = quest.isClaimed;
    final userFraction = quest.targetGoal > 0 ? quest.userContribution / quest.targetGoal : 0.0;
    final partnerFraction = quest.targetGoal > 0 ? quest.partnerContribution / quest.targetGoal : 0.0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isCompleted
              ? Colors.amber.withValues(alpha: 0.6)
              : theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
          width: isCompleted ? 1.8 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: isCompleted
                ? Colors.amber.withValues(alpha: 0.15)
                : Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text('👥', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  Text(
                    'Friend Quest',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${quest.daysRemaining}d left ⏳',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Quest Title & Goal
          Text(
            quest.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 2),
          Text(
            quest.description,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
            ),
          ),

          const SizedBox(height: 14),

          // Partner & Duo Streak Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Partner Info
                Row(
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.teal.withValues(alpha: 0.2),
                      child: Text(quest.partnerEmoji, style: const TextStyle(fontSize: 14)),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Partner: ${quest.partnerName}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ],
                ),
                // Shared Streak
                Row(
                  children: [
                    const Icon(Icons.local_fire_department, color: Colors.orange, size: 16),
                    const SizedBox(width: 3),
                    Text(
                      '${quest.sharedStreakDays}d Duo Streak',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // Dual Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 10,
              child: Stack(
                children: [
                  Container(
                    color: theme.colorScheme.surfaceContainerHighest,
                  ),
                  // User Contribution (Indigo)
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: (userFraction + partnerFraction).clamp(0.0, 1.0),
                    child: Container(color: Colors.teal),
                  ),
                  // Partner Contribution (Teal)
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: userFraction.clamp(0.0, 1.0),
                    child: Container(color: theme.colorScheme.primary),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),

          // Progress Count Breakdown
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(width: 8, height: 8, decoration: BoxDecoration(color: theme.colorScheme.primary, shape: BoxShape.circle)),
                  const SizedBox(width: 4),
                  Text('You: ${quest.userContribution}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                  const SizedBox(width: 10),
                  Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.teal, shape: BoxShape.circle)),
                  const SizedBox(width: 4),
                  Text('${quest.partnerName.split(" ").first}: ${quest.partnerContribution}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                ],
              ),
              Text(
                '${quest.totalProgress}/${quest.targetGoal}',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Action State
          if (isClaimed)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_rounded, color: Colors.green, size: 18),
                  SizedBox(width: 6),
                  Text(
                    'Mission Accomplished! 💧',
                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ],
              ),
            )
          else if (isCompleted)
            SizedBox(
              width: double.infinity,
              height: 42,
              child: FilledButton.icon(
                onPressed: () {
                  feedback.playLevelUpFeedback();
                  ref.read(friendQuestNotifierProvider.notifier).claimReward();
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.amberAccent,
                  foregroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: const Icon(Icons.emoji_events_rounded, size: 18),
                label: Text(
                  'Claim +${quest.rewardDroplets} Droplets 💧',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            )
          else
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      feedback.playCorrectFeedback();
                      ref.read(friendQuestNotifierProvider.notifier).sendHighFive();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('High five sent to ${quest.partnerName}! ✋🔥'),
                          duration: const Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    icon: const Text('✋', style: TextStyle(fontSize: 16)),
                    label: const Text(
                      'High Five',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.cyan.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '+${quest.rewardDroplets} 💧',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.cyan,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
