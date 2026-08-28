import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:limpede/database/app_database.dart';
import 'package:limpede/models/memory_analytics.dart';
import 'package:limpede/models/user_profile.dart';
import 'package:limpede/providers/auth_provider.dart';
import 'package:limpede/providers/memory_analytics_provider.dart';
import 'package:limpede/providers/srs_lesson_provider.dart';
import 'package:limpede/services/sync_engine_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Memory Retention Analytics & Heatmap Tests', () {
    test('MemoryAnalytics model defaults and assignments', () {
      const analytics = MemoryAnalytics(
        retentionRatePercent: 94,
        totalWordsLearned: 55,
        masteredCount: 20,
        learningCount: 30,
        dueCount: 5,
        a1Count: 35,
        a2Count: 20,
      );

      expect(analytics.retentionRatePercent, 94);
      expect(analytics.totalWordsLearned, 55);
      expect(analytics.masteredCount, 20);
      expect(analytics.weeklyXpList.length, 7);
    });

    test('Computes memory analytics from user profile', () async {
      final db = AppDatabase(NativeDatabase.memory());
      final syncEngine = SyncEngineService(db: db);
      addTearDown(db.close);

      const user = UserProfile(
        id: 'test_user',
        username: 'Alex',
        xp: 150,
        weeklyXp: 70,
      );

      final container = ProviderContainer(
        overrides: [
          currentUserProfileProvider.overrideWith((ref) => user),
          syncEngineServiceProvider.overrideWithValue(syncEngine),
        ],
      );
      addTearDown(container.dispose);

      final sub = container.listen(memoryAnalyticsNotifierProvider, (_, __) {});
      addTearDown(sub.close);

      final analytics = await container.read(memoryAnalyticsNotifierProvider.future);
      expect(analytics, isNotNull);
      expect(analytics.retentionRatePercent, greaterThanOrEqualTo(60));
      expect(analytics.weeklyXpList.length, 7);
    });
  });
}

