import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../providers/course_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/srs_lesson_provider.dart';
import '../providers/topic_provider.dart';
import '../utils/language_utils.dart';
import '../utils/localized_strings.dart';
import '../utils/topic_translator.dart';
import '../widgets/widgets.dart';
import 'leaderboard_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentTab = 0;

  void _openCustomLessonModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => const GenerateLessonSheet(),
    );
  }

  double _getSerpentineOffset(int index) {
    const sequence = [0.0, -45.0, -25.0, 25.0, 45.0, 20.0, -35.0];
    return sequence[index % sequence.length];
  }

  List<DropdownMenuItem<String>> _buildNativeLanguageItems() {
    return const [
      DropdownMenuItem(value: 'English', child: Text('🇬🇧 English')),
      DropdownMenuItem(value: 'Romanian', child: Text('🇷🇴 Română')),
      DropdownMenuItem(value: 'French', child: Text('🇫🇷 Français')),
      DropdownMenuItem(value: 'German', child: Text('🇩🇪 Deutsch')),
      DropdownMenuItem(value: 'Spanish', child: Text('🇪🇸 Español')),
    ];
  }

  List<DropdownMenuItem<String>> _buildTargetLanguageItems() {
    return const [
      DropdownMenuItem(value: 'German', child: Text('🇩🇪 German')),
      DropdownMenuItem(value: 'English', child: Text('🇬🇧 English')),
      DropdownMenuItem(value: 'French', child: Text('🇫🇷 French')),
      DropdownMenuItem(value: 'Spanish', child: Text('🇪🇸 Spanish')),
      DropdownMenuItem(value: 'Italian', child: Text('🇮🇹 Italian')),
      DropdownMenuItem(value: 'Romanian', child: Text('🇷🇴 Romanian')),
      DropdownMenuItem(value: 'Portuguese', child: Text('🇵🇹 Portuguese')),
      DropdownMenuItem(value: 'Russian', child: Text('🇷🇺 Russian')),
      DropdownMenuItem(value: 'Japanese', child: Text('🇯🇵 Japanese')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final courseState = ref.watch(courseStateNotifierProvider);
    final nativeLang = courseState.nativeLanguage;

    return Scaffold(
      body: IndexedStack(
        index: _currentTab,
        children: [
          _buildSkillTreeTab(context),
          const LeaderboardScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentTab,
        onDestinationSelected: (idx) {
          setState(() => _currentTab = idx);
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.school_outlined),
            selectedIcon: const Icon(Icons.school),
            label: LocalizedStrings.getNavLearn(nativeLang),
          ),
          NavigationDestination(
            icon: const Icon(Icons.leaderboard_outlined),
            selectedIcon: const Icon(Icons.leaderboard),
            label: LocalizedStrings.getNavLeaderboard(nativeLang),
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: LocalizedStrings.getNavProfile(nativeLang),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillTreeTab(BuildContext context) {
    final theme = Theme.of(context);
    final userProfileAsync = ref.watch(currentUserProfileProvider);
    final dueCountAsync = ref.watch(dueSrsCountProvider);
    final courseState = ref.watch(courseStateNotifierProvider);
    final topicUnitsAsync = ref.watch(topicUnitsProvider(targetLanguage: courseState.targetLanguage));
    final updateInfoAsync = ref.watch(appUpdateInfoProvider);

    final dueCount = dueCountAsync.maybeWhen(
      data: (count) => count,
      orElse: () => 0,
    );

    final userXp = userProfileAsync.maybeWhen(
      data: (profile) => profile?.xp ?? 0,
      orElse: () => 0,
    );

    final userStreak = userProfileAsync.maybeWhen(
      data: (profile) => profile?.streak ?? 1,
      orElse: () => 1,
    );

    final nativeLang = courseState.nativeLanguage;
    final targetLang = courseState.targetLanguage;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // Course Selector Pill: Native -> Target Language
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Native Language Selector
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: nativeLang,
                        isDense: true,
                        icon: const SizedBox.shrink(),
                        items: _buildNativeLanguageItems(),
                        onChanged: (val) {
                          if (val != null) {
                            ref.read(courseStateNotifierProvider.notifier).setNativeLanguage(val);
                          }
                        },
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.0),
                      child: Icon(Icons.arrow_forward_rounded, size: 18),
                    ),

                    // Target Language Selector
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: targetLang,
                        isDense: true,
                        icon: const Icon(Icons.arrow_drop_down),
                        items: _buildTargetLanguageItems(),
                        onChanged: (val) {
                          if (val != null) {
                            ref.read(courseStateNotifierProvider.notifier).setTargetLanguage(val);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Streak Counter 🔥
              Row(
                children: [
                  const Icon(Icons.local_fire_department, color: Colors.orange, size: 22),
                  const SizedBox(width: 4),
                  Text(
                    '$userStreak',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),

              // Hearts Counter ❤️
              Row(
                children: [
                  const Icon(Icons.favorite, color: Colors.redAccent, size: 22),
                  const SizedBox(width: 4),
                  Text(
                    '5',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),

              // XP Counter ⚡
              Row(
                children: [
                  const Icon(Icons.bolt, color: Colors.amber, size: 22),
                  const SizedBox(width: 2),
                  Text(
                    '$userXp',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.amber.shade700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          // Update Available Banner (GitHub Release Auto-Update)
          if (updateInfoAsync.asData?.value != null &&
              updateInfoAsync.asData!.value.hasUpdate) ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple.shade700, Colors.deepPurple.shade900],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.system_update_rounded, color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Update Available! (v${updateInfoAsync.asData!.value.latestVersion})',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Tap to download the latest APK directly from GitHub.',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          final url = updateInfoAsync.asData!.value.downloadUrl;
                          if (url != null) {
                            ref.read(updateServiceProvider).launchUpdateUrl(url);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text('Update APK', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],

          // Daily Review Card (No SRS Jargon)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                color: theme.colorScheme.tertiaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.tertiary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.repeat, color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocalizedStrings.getDailyReviewTitle(nativeLang),
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onTertiaryContainer,
                              ),
                            ),
                            Text(
                              LocalizedStrings.getDueItemsSubtext(nativeLang, dueCount),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onTertiaryContainer.withValues(alpha: 0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          final reviewTitle = LocalizedStrings.getDailyReviewTitle(nativeLang);
                          context.push(
                            '/lesson/${Uri.encodeComponent(reviewTitle)}?language=$targetLang&isSrsReview=true',
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.tertiary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(LocalizedStrings.getBtnReview(nativeLang, dueCount)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Custom Topic Assistant Card
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                color: theme.colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.auto_awesome, color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocalizedStrings.getCustomTopicTitle(nativeLang),
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                            ),
                            Text(
                              LocalizedStrings.getCustomTopicSubtext(nativeLang),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => _openCustomLessonModal(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(LocalizedStrings.getBtnCreate(nativeLang)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Dynamic Duolingo Skill Tree Units
          topicUnitsAsync.when(
            loading: () => const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(40.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            error: (err, stack) => SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Center(
                  child: Text(
                    'Unable to load curriculum topics. Tap to retry.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ),
              ),
            ),
            data: (units) {
              if (units.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Center(child: Text('No topics available.')),
                  ),
                );
              }

              final nativeLangCode = LanguageUtils.normalizeLanguageCode(nativeLang);

              return SliverMainAxisGroup(
                slivers: [
                  for (final unit in units) ...[
                    // Section Unit Header Card
                    SliverToBoxAdapter(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              theme.colorScheme.primary,
                              theme.colorScheme.tertiary,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.primary.withValues(alpha: 0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'UNIT ${unit.unitNumber}',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      letterSpacing: 1.1,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    TopicTranslator.translateUnit(unit.unitName.trim(), nativeLangCode),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    unit.description,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Text(
                                unit.levelBadge,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Serpentine Path Nodes for Unit Lessons
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final topicNode = unit.nodes[index];
                          final xOffset = _getSerpentineOffset(index);

                          final String rawNodeName;
                          if (topicNode.fullCategory.contains(':')) {
                            final parts = topicNode.fullCategory.split(':');
                            rawNodeName = parts.sublist(1).join(':').trim();
                          } else {
                            rawNodeName = topicNode.nodeName.trim();
                          }

                          final translatedNodeName = TopicTranslator.translateNode(rawNodeName, nativeLangCode);

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: SkillTreeNodeWidget(
                              node: topicNode,
                              displayName: translatedNodeName,
                              xOffset: xOffset,
                              onTap: () {
                                context.push(
                                  '/lesson/${Uri.encodeComponent(topicNode.fullCategory)}?language=$targetLang',
                                );
                              },
                            ),
                          );
                        },
                        childCount: unit.nodes.length,
                      ),
                    ),
                  ],
                ],
              );
            },
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 60)),
        ],
      ),
    );
  }
}
