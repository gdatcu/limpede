import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/update_service.dart';

part 'settings_provider.g.dart';

@riverpod
UpdateService updateService(Ref ref) {
  return UpdateService();
}

@riverpod
Future<AppUpdateInfo> appUpdateInfo(Ref ref) async {
  final service = ref.watch(updateServiceProvider);
  return service.checkForUpdates();
}

@riverpod
class SoundSettingsNotifier extends _$SoundSettingsNotifier {
  static const _key = 'setting_sound_enabled';

  @override
  Future<bool> build() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? true;
  }

  Future<void> toggle(bool enabled) async {
    state = AsyncValue.data(enabled);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, enabled);
  }
}

@riverpod
class HapticSettingsNotifier extends _$HapticSettingsNotifier {
  static const _key = 'setting_haptic_enabled';

  @override
  Future<bool> build() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? true;
  }

  Future<void> toggle(bool enabled) async {
    state = AsyncValue.data(enabled);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, enabled);
  }
}
