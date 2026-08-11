import 'package:flutter/material.dart';
import '../providers/topic_provider.dart';

class SkillTreeNodeWidget extends StatelessWidget {
  final TopicNode node;
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
    final isCompleted = node.isCompleted;
    final isLocked = node.isLocked;

    final nodeColor = isCompleted
        ? Colors.amber.shade600
        : isLocked
            ? theme.colorScheme.outlineVariant
            : theme.colorScheme.primary;

    return Transform.translate(
      offset: Offset(xOffset, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              if (isLocked) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Complete the previous lesson to unlock "${node.nodeName}"!'),
                    duration: const Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              } else {
                onTap();
              }
            },
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.95, end: isLocked ? 0.95 : 1.0),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutBack,
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
                  gradient: isLocked
                      ? null
                      : LinearGradient(
                          colors: isCompleted
                              ? [Colors.amber.shade400, Colors.orange.shade700]
                              : [theme.colorScheme.primary, theme.colorScheme.tertiary],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                  color: isLocked ? theme.colorScheme.surfaceContainerHighest : null,
                  border: isLocked
                      ? Border.all(color: theme.colorScheme.outlineVariant, width: 2)
                      : null,
                  boxShadow: isLocked
                      ? null
                      : [
                          BoxShadow(
                            color: nodeColor.withValues(alpha: 0.35),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                ),
                child: Center(
                  child: Icon(
                    isCompleted
                        ? Icons.check_circle_rounded
                        : isLocked
                            ? Icons.lock_rounded
                            : node.icon,
                    color: isLocked ? theme.colorScheme.outline : Colors.white,
                    size: 38,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            constraints: const BoxConstraints(maxWidth: 160),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isLocked
                  ? theme.colorScheme.surfaceContainer
                  : theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isCompleted
                    ? Colors.amber.withValues(alpha: 0.5)
                    : theme.colorScheme.outlineVariant,
              ),
            ),
            child: Text(
              node.nodeName,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isCompleted
                    ? Colors.amber.shade900
                    : isLocked
                        ? theme.colorScheme.outline
                        : theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
