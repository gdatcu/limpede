import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/notification_service.dart';
import 'auth_provider.dart';
import 'course_provider.dart';

part 'reminder_provider.g.dart';

class ReminderSettingsState {
  final bool isEnabled;
  final int hour;
  final int minute;

  const ReminderSettingsState({
    required this.isEnabled,
    required this.hour,
    required this.minute,
  });

  ReminderSettingsState copyWith({
    bool? isEnabled,
    int? hour,
    int? minute,
  }) {
    return ReminderSettingsState(
      isEnabled: isEnabled ?? this.isEnabled,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
    );
  }
}

@Riverpod(keepAlive: true)
NotificationService notificationService(Ref ref) {
  return NotificationService();
}

@Riverpod(keepAlive: true)
class ReminderSettingsNotifier extends _$ReminderSettingsNotifier {
  static const String _keyEnabled = 'reminder_enabled';
  static const String _keyHour = 'reminder_hour';
  static const String _keyMinute = 'reminder_minute';

  @override
  Future<ReminderSettingsState> build() async {
    final prefs = await SharedPreferences.getInstance();
    final isEnabled = prefs.getBool(_keyEnabled) ?? true;
    final hour = prefs.getInt(_keyHour) ?? 19;
    final minute = prefs.getInt(_keyMinute) ?? 30;

    final state = ReminderSettingsState(
      isEnabled: isEnabled,
      hour: hour,
      minute: minute,
    );

    if (isEnabled) {
      _reschedule(state);
    }

    return state;
  }

  Future<void> _reschedule(ReminderSettingsState s) async {
    final notification = ref.read(notificationServiceProvider);
    final userProfile = await ref.read(currentUserProfileProvider.future);
    final courseState = ref.read(courseStateNotifierProvider);

    if (s.isEnabled) {
      await notification.scheduleDailyReminder(
        hour: s.hour,
        minute: s.minute,
        currentStreak: userProfile?.streak ?? 1,
        targetLanguage: courseState.targetLanguage,
      );
    } else {
      await notification.cancelDailyReminder();
    }
  }

  Future<void> toggle(bool value) async {
    final current = state.value ??
        const ReminderSettingsState(isEnabled: true, hour: 19, minute: 30);
    final updated = current.copyWith(isEnabled: value);
    state = AsyncValue.data(updated);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyEnabled, value);

    await _reschedule(updated);
  }

  Future<void> setTime(int hour, int minute) async {
    final current = state.value ??
        const ReminderSettingsState(isEnabled: true, hour: 19, minute: 30);
    final updated = current.copyWith(hour: hour, minute: minute);
    state = AsyncValue.data(updated);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyHour, hour);
    await prefs.setInt(_keyMinute, minute);

    if (updated.isEnabled) {
      await _reschedule(updated);
    }
  }
}
