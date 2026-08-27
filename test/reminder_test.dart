import 'package:flutter_test/flutter_test.dart';
import 'package:limpede/providers/reminder_provider.dart';

void main() {
  group('Local Study Reminders & Settings Tests', () {
    test('ReminderSettingsState default values and copyWith', () {
      const state = ReminderSettingsState(
        isEnabled: true,
        hour: 19,
        minute: 30,
      );

      expect(state.isEnabled, true);
      expect(state.hour, 19);
      expect(state.minute, 30);

      final updated = state.copyWith(hour: 20, minute: 0);
      expect(updated.hour, 20);
      expect(updated.minute, 0);
      expect(updated.isEnabled, true);

      final disabled = updated.copyWith(isEnabled: false);
      expect(disabled.isEnabled, false);
      expect(disabled.hour, 20);
    });
  });
}
