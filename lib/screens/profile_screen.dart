import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/league.dart';
import '../providers/auth_provider.dart';
import '../providers/mistake_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/reminder_provider.dart';
import '../widgets/gem_shop_sheet.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final userProfileAsync = ref.watch(currentUserProfileProvider);
    final soundAsync = ref.watch(soundSettingsNotifierProvider);
    final hapticAsync = ref.watch(hapticSettingsNotifierProvider);
    final mistakesAsync = ref.watch(mistakeNotifierProvider);

    final soundEnabled = soundAsync.value ?? true;
    final hapticEnabled = hapticAsync.value ?? true;
    final mistakes = mistakesAsync.value ?? [];
    final reminderSettingsAsync = ref.watch(reminderSettingsNotifierProvider);
    final reminderSettings = reminderSettingsAsync.maybeWhen(
      data: (s) => s,
      orElse: () => const ReminderSettingsState(isEnabled: true, hour: 19, minute: 30),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile & Rewards', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // User Header Card
            userProfileAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => const SizedBox.shrink(),
              data: (profile) {
                final username = profile?.username ?? 'Learner';
                final xp = profile?.xp ?? 0;
                final streak = profile?.streak ?? 1;
                final gems = profile?.gems ?? 50;
                final streakFreezes = profile?.streakFreezes ?? 0;
                final tier = LeagueTier.fromString(profile?.leagueTier);

                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 44,
                          backgroundColor: theme.colorScheme.primaryContainer,
                          backgroundImage: profile?.avatarUrl != null
                              ? NetworkImage(profile!.avatarUrl!)
                              : null,
                          child: profile?.avatarUrl == null
                              ? Text(
                                  username.isNotEmpty ? username[0].toUpperCase() : 'U',
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.onPrimaryContainer,
                                  ),
                                )
                              : null,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          username,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: tier.primaryColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: tier.primaryColor.withValues(alpha: 0.5)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(tier.emblemEmoji, style: const TextStyle(fontSize: 16)),
                              const SizedBox(width: 6),
                              Text(
                                tier.displayName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: tier.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Stats Grid
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatTile(
                                icon: Icons.local_fire_department,
                                iconColor: Colors.orange,
                                value: '$streak',
                                label: 'Day Streak',
                                theme: theme,
                              ),
                            ),
                            Container(height: 40, width: 1, color: theme.colorScheme.outlineVariant),
                            Expanded(
                              child: _buildStatTile(
                                icon: Icons.bolt,
                                iconColor: Colors.amber.shade700,
                                value: '$xp',
                                label: 'Total XP',
                                theme: theme,
                              ),
                            ),
                            Container(height: 40, width: 1, color: theme.colorScheme.outlineVariant),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) => const GemShopSheet(),
                                  );
                                },
                                borderRadius: BorderRadius.circular(16),
                                child: _buildStatTile(
                                  icon: Icons.water_drop,
                                  iconColor: Colors.cyan,
                                  value: '$gems',
                                  label: 'Droplets 💧',
                                  theme: theme,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),
                        const Divider(),
                        const SizedBox(height: 8),

                        // Streak Freeze Status
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.cyan.withValues(alpha: 0.15),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.ac_unit, color: Colors.cyan, size: 20),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Streak Freezes',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                    ),
                                    Text(
                                      '$streakFreezes/2 Equipped 🧊',
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: theme.colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            OutlinedButton.icon(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => const GemShopSheet(),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              icon: const Icon(Icons.shopping_bag_outlined, size: 16),
                              label: const Text('Shop', style: TextStyle(fontSize: 12)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // Mistake Review Card
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.errorContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.edit_note, color: theme.colorScheme.error),
                ),
                title: const Text('Mistakes Bank', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${mistakes.length} questions to review'),
                trailing: mistakes.isNotEmpty
                    ? TextButton(
                        onPressed: () {
                          ref.read(mistakeNotifierProvider.notifier).clearMistakes();
                        },
                        child: const Text('Clear'),
                      )
                    : null,
              ),
            ),

            const SizedBox(height: 24),
            Text(
              'Settings & Reminders',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // Daily Study Reminder Switch
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    secondary: const Icon(Icons.alarm_on_rounded, color: Colors.orange),
                    title: const Text('Daily Study Reminder', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('Get notified daily to practice and keep your streak alive'),
                    value: reminderSettings.isEnabled,
                    onChanged: (val) {
                      ref.read(reminderSettingsNotifierProvider.notifier).toggle(val);
                    },
                  ),
                  if (reminderSettings.isEnabled) ...[
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.access_time_rounded),
                      title: const Text('Reminder Time'),
                      trailing: Text(
                        TimeOfDay(hour: reminderSettings.hour, minute: reminderSettings.minute).format(context),
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () async {
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(
                            hour: reminderSettings.hour,
                            minute: reminderSettings.minute,
                          ),
                        );
                        if (picked != null) {
                          ref
                              .read(reminderSettingsNotifierProvider.notifier)
                              .setTime(picked.hour, picked.minute);
                        }
                      },
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Sound Effects Switch
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SwitchListTile(
                secondary: const Icon(Icons.volume_up_outlined),
                title: const Text('Enable Sound Effects'),
                value: soundEnabled,
                onChanged: (val) {
                  ref.read(soundSettingsNotifierProvider.notifier).toggle(val);
                },
              ),
            ),

            const SizedBox(height: 12),

            // Haptic Feedback Switch
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SwitchListTile(
                secondary: const Icon(Icons.vibration_outlined),
                title: const Text('Enable Haptic Feedback'),
                value: hapticEnabled,
                onChanged: (val) {
                  ref.read(hapticSettingsNotifierProvider.notifier).toggle(val);
                },
              ),
            ),

            const SizedBox(height: 32),

            // Log Out Button
            FilledButton.icon(
              onPressed: () async {
                await Supabase.instance.client.auth.signOut();
                if (context.mounted) {
                  context.go('/login');
                }
              },
              icon: const Icon(Icons.logout),
              label: const Text(
                'Log Out',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: theme.colorScheme.error,
                foregroundColor: theme.colorScheme.onError,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatTile({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
    required ThemeData theme,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 20),
            const SizedBox(width: 4),
            Text(
              value,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: iconColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
