import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/feedback_service.dart';
import 'settings_provider.dart';

part 'feedback_provider.g.dart';

@Riverpod(keepAlive: true)
FeedbackService feedbackService(Ref ref) {
  final soundAsync = ref.watch(soundSettingsNotifierProvider);
  final hapticAsync = ref.watch(hapticSettingsNotifierProvider);

  final soundEnabled = soundAsync.value ?? true;
  final hapticEnabled = hapticAsync.value ?? true;

  final service = FeedbackService(
    soundEnabled: soundEnabled,
    hapticEnabled: hapticEnabled,
  );

  ref.onDispose(() => service.dispose());
  return service;
}
