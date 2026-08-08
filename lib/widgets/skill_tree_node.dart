import 'package:flutter/material.dart';
import '../models/course.dart';

class SkillTreeNodeWidget extends StatelessWidget {
  final LessonNode node;
  final double xOffset;
  final VoidCallback onTap;

  const SkillTreeNodeWidget({
    super.key,
    required this.node,
    required this.xOffset,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLocked = node.status == LessonNodeStatus.locked;
    final isCompleted = node.status == LessonNodeStatus.completed;

    final nodeColor = isCompleted
        ? Colors.amber.shade600
        : isLocked
            ? theme.colorScheme.outlineVariant
            : theme.colorScheme.primary;

    return Transform.translate(
      offset: Offset(xOffset, 0),
      child: Column(
        children: [
          GestureDetector(
            onTap: isLocked ? null : onTap,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.9, end: node.status == LessonNodeStatus.active ? 1.05 : 1.0),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              builder: (context, scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: child,
                );
              },
              child: Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: nodeColor,
                  boxShadow: [
                    BoxShadow(
                      color: nodeColor.withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Center(
                  child: isCompleted
                      ? const Icon(Icons.star, color: Colors.white, size: 40)
                      : isLocked
                          ? const Icon(Icons.lock, color: Colors.white70, size: 32)
                          : const Icon(Icons.play_arrow, color: Colors.white, size: 44),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              node.title,
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
