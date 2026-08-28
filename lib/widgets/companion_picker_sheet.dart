import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/mascot_character.dart';
import '../providers/course_provider.dart';
import '../providers/mascot_state_controller.dart';
import 'mascot_view_widget.dart';

class CompanionPickerSheet extends ConsumerWidget {
  const CompanionPickerSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CompanionPickerSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final mascotState = ref.watch(mascotStateNotifierProvider);
    final activeId = mascotState.character.id;
    final courseState = ref.watch(courseStateNotifierProvider);
    final isRomanian = courseState.nativeLanguage.trim().toLowerCase().startsWith('ro');

    return Container(
      height: MediaQuery.of(context).size.height * 0.78,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Drag handle
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 44,
            height: 5,
            decoration: BoxDecoration(
              color: theme.colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                Icon(Icons.pets, color: theme.colorScheme.primary, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isRomanian ? 'Alege Companionul de Studiu' : 'Choose Your Study Companion',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        isRomanian
                            ? 'Fiecare companion are propria personalitate și stil'
                            : 'Each companion has a distinct personality and feedback style',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Companion Cards List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: MascotCharacter.allMascots.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final mascot = MascotCharacter.allMascots[index];
                final isSelected = mascot.id == activeId;

                return _buildCompanionCard(
                  context: context,
                  ref: ref,
                  mascot: mascot,
                  isSelected: isSelected,
                  isRomanian: isRomanian,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanionCard({
    required BuildContext context,
    required WidgetRef ref,
    required MascotCharacter mascot,
    required bool isSelected,
    required bool isRomanian,
  }) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        ref.read(mascotStateNotifierProvider.notifier).selectMascot(mascot.id);
        Navigator.of(context).pop();
      },
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? mascot.primaryColor.withValues(alpha: 0.12)
              : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? mascot.primaryColor
                : theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
            width: isSelected ? 2.5 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: mascot.glowColor.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            // Mascot Animated Avatar
            SizedBox(
              width: 72,
              height: 72,
              child: CustomPaint(
                painter: MascotPainter(
                  character: mascot,
                  mood: isSelected ? MascotMood.celebrating : MascotMood.idle,
                  gazeTarget: Offset.zero,
                  isBlinking: false,
                  animationProgress: 0.5,
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Bio & Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${mascot.name} ${mascot.emoji}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (isSelected)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: mascot.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            isRomanian ? 'ACTIV' : 'ACTIVE',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    mascot.title,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: mascot.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    mascot.description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.25,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Select indicator icon
            Icon(
              isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isSelected ? mascot.primaryColor : theme.colorScheme.outlineVariant,
              size: 26,
            ),
          ],
        ),
      ),
    );
  }
}
