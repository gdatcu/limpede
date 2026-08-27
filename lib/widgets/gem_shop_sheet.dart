import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../providers/feedback_provider.dart';

class GemShopSheet extends ConsumerStatefulWidget {
  const GemShopSheet({super.key});

  @override
  ConsumerState<GemShopSheet> createState() => _GemShopSheetState();
}

class _GemShopSheetState extends ConsumerState<GemShopSheet> {
  bool _isProcessing = false;

  Future<void> _handleBuyStreakFreeze(int currentGems, int currentFreezes) async {
    if (currentGems < 100 || currentFreezes >= 2 || _isProcessing) return;

    setState(() => _isProcessing = true);
    final user = ref.read(authNotifierProvider).value;
    final userId = user?.id ?? 'guest_local';
    final supabase = ref.read(supabaseServiceProvider);

    final success = await supabase.purchaseStreakFreeze(userId);
    if (mounted) {
      setState(() => _isProcessing = false);
      if (success) {
        ref.read(feedbackServiceProvider).playLevelUpFeedback();
        ref.invalidate(currentUserProfileProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.ac_unit, color: Colors.cyanAccent),
                SizedBox(width: 8),
                Text('Streak Freeze equipped! 🧊 (Max 2)'),
              ],
            ),
            backgroundColor: Colors.blueGrey,
          ),
        );
      }
    }
  }

  Future<void> _handleBuyHeartRefill(int currentGems) async {
    if (currentGems < 50 || _isProcessing) return;

    setState(() => _isProcessing = true);
    final user = ref.read(authNotifierProvider).value;
    final userId = user?.id ?? 'guest_local';
    final supabase = ref.read(supabaseServiceProvider);

    final success = await supabase.purchaseHeartRefill(userId);
    if (mounted) {
      setState(() => _isProcessing = false);
      if (success) {
        ref.read(feedbackServiceProvider).playLevelUpFeedback();
        ref.invalidate(currentUserProfileProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.favorite, color: Colors.redAccent),
                SizedBox(width: 8),
                Text('Hearts fully refilled! ❤️'),
              ],
            ),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userProfileAsync = ref.watch(currentUserProfileProvider);
    final profile = userProfileAsync.asData?.value;
    final gems = profile?.gems ?? 50;
    final streakFreezes = profile?.streakFreezes ?? 0;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Header with Gems Balance
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.cyan.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.water_drop, color: Colors.cyan, size: 28),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Droplet Shop',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.cyan.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.cyan.withValues(alpha: 0.4)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.water_drop, color: Colors.cyan, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      '$gems 💧',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.cyan.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Streak Freeze Item Card
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: BorderSide(color: Colors.cyan.withValues(alpha: 0.3)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.cyan.shade300, Colors.blue.shade600],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(Icons.ac_unit, color: Colors.white, size: 32),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Streak Freeze',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: streakFreezes > 0 ? Colors.cyan.shade100 : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '$streakFreezes/2 🧊',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: streakFreezes > 0 ? Colors.cyan.shade900 : Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Saves your streak if you miss a day of practice.',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: (gems >= 100 && streakFreezes < 2 && !_isProcessing)
                        ? () => _handleBuyStreakFreeze(gems, streakFreezes)
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('100 💧', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        Text('Equip', style: TextStyle(fontSize: 11)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Heart Refill Card
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: BorderSide(color: Colors.redAccent.withValues(alpha: 0.3)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.pink.shade300, Colors.redAccent.shade400],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(Icons.favorite, color: Colors.white, size: 32),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Full Heart Refill',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Instantly recovers all 5 hearts for mistakes.',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: (gems >= 50 && !_isProcessing)
                        ? () => _handleBuyHeartRefill(gems)
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('50 💧', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        Text('Refill', style: TextStyle(fontSize: 11)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
