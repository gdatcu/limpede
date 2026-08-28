import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/mistake_provider.dart';

class MistakesInboxCard extends ConsumerWidget {
  const MistakesInboxCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final mistakesAsync = ref.watch(mistakeNotifierProvider);
    final mistakes = mistakesAsync.value ?? [];
    final hasMistakes = mistakes.isNotEmpty;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: hasMistakes
              ? [
                  Colors.red.shade900.withValues(alpha: 0.25),
                  theme.colorScheme.surface,
                ]
              : [
                  Colors.green.shade900.withValues(alpha: 0.15),
                  theme.colorScheme.surface,
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: hasMistakes
              ? Colors.redAccent.withValues(alpha: 0.4)
              : Colors.green.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: hasMistakes
                ? Colors.red.withValues(alpha: 0.1)
                : Colors.green.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Heart / Healing Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: hasMistakes
                  ? Colors.redAccent.withValues(alpha: 0.2)
                  : Colors.green.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              hasMistakes ? Icons.healing_rounded : Icons.check_circle_outline_rounded,
              color: hasMistakes ? Colors.redAccent : Colors.greenAccent,
              size: 26,
            ),
          ),
          const SizedBox(width: 14),

          // Text Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Mistakes Inbox',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (hasMistakes) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${mistakes.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  hasMistakes
                      ? '${mistakes.length} ${mistakes.length == 1 ? 'phrase' : 'phrases'} need a quick review'
                      : 'Zero mistakes! Clean streak ✨',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),

          // Action Button
          if (hasMistakes)
            FilledButton.icon(
              onPressed: () {
                context.push('/lesson/mistakes_workout?isMistakesWorkout=true');
              },
              style: FilledButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              icon: const Icon(Icons.play_arrow_rounded, size: 18),
              label: const Text(
                'Fix',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '100%',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
