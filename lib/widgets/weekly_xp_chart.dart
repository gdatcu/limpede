import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/memory_analytics_provider.dart';

class WeeklyXpChart extends ConsumerWidget {
  const WeeklyXpChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final analyticsAsync = ref.watch(memoryAnalyticsNotifierProvider);
    final analytics = analyticsAsync.value;

    if (analytics == null) {
      return const SizedBox.shrink();
    }

    final dayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    final xpList = analytics.weeklyXpList;
    final maxXp = xpList.fold<int>(1, (prev, elem) => elem > prev ? elem : prev);
    final totalWeekly = xpList.fold<int>(0, (prev, elem) => prev + elem);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Weekly Study Activity',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.bolt, color: Colors.amber, size: 18),
                  Text(
                    '$totalWeekly XP',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 7 Bars
          SizedBox(
            height: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(7, (index) {
                final dayXp = index < xpList.length ? xpList[index] : 0;
                final ratio = (dayXp / maxXp).clamp(0.1, 1.0);
                final isToday = index == DateTime.now().weekday - 1;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Bar
                    Container(
                      width: 22,
                      height: 60 * ratio,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isToday
                              ? [Colors.amberAccent, Colors.orangeAccent]
                              : [
                                  theme.colorScheme.primary.withValues(alpha: 0.8),
                                  theme.colorScheme.primary.withValues(alpha: 0.4),
                                ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Day label
                    Text(
                      dayLabels[index],
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                        color: isToday ? theme.colorScheme.primary : Colors.grey,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
