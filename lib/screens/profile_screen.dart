import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../providers/auth_provider.dart';
import '../providers/mistake_provider.dart';
import '../providers/settings_provider.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile & Settings', style: TextStyle(fontWeight: FontWeight.bold)),
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

                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: theme.colorScheme.primaryContainer,
                          backgroundImage: profile?.avatarUrl != null
                              ? NetworkImage(profile!.avatarUrl!)
                              : null,
                          child: profile?.avatarUrl == null
                              ? Text(
                                  username.isNotEmpty ? username[0].toUpperCase() : 'U',
                                  style: TextStyle(
                                    fontSize: 32,
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
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.local_fire_department,
                                        color: Colors.orange, size: 24),
                                    const SizedBox(width: 4),
                                    Text(
                                      '$streak',
                                      style: theme.textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Day Streak',
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                            Container(height: 30, width: 1, color: theme.colorScheme.outlineVariant),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.bolt, color: Colors.amber, size: 24),
                                    const SizedBox(width: 4),
                                    Text(
                                      '$xp',
                                      style: theme.textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.amber.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Total XP',
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

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
              'Settings',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
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
}
