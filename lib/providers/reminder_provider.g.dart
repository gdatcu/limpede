// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notificationServiceHash() =>
    r'58da87941dbfa08925105dcc4d74091ee38c8593';

/// See also [notificationService].
@ProviderFor(notificationService)
final notificationServiceProvider = Provider<NotificationService>.internal(
  notificationService,
  name: r'notificationServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notificationServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NotificationServiceRef = ProviderRef<NotificationService>;
String _$reminderSettingsNotifierHash() =>
    r'd012aa8a3299a3429b430fe52dfc00443b93985d';

/// See also [ReminderSettingsNotifier].
@ProviderFor(ReminderSettingsNotifier)
final reminderSettingsNotifierProvider = AsyncNotifierProvider<
    ReminderSettingsNotifier, ReminderSettingsState>.internal(
  ReminderSettingsNotifier.new,
  name: r'reminderSettingsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reminderSettingsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ReminderSettingsNotifier = AsyncNotifier<ReminderSettingsState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
