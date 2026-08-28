// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'srs_lesson_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$syncEngineServiceHash() => r'60fb00b74a4c585fdac74997af3b54e6297fd217';

/// See also [syncEngineService].
@ProviderFor(syncEngineService)
final syncEngineServiceProvider =
    AutoDisposeProvider<SyncEngineService>.internal(
  syncEngineService,
  name: r'syncEngineServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$syncEngineServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SyncEngineServiceRef = AutoDisposeProviderRef<SyncEngineService>;
String _$dueSrsCountHash() => r'f1ad56c28910fb4e9fe2f09fa7e60e6844b0734b';

/// See also [dueSrsCount].
@ProviderFor(dueSrsCount)
final dueSrsCountProvider = AutoDisposeFutureProvider<int>.internal(
  dueSrsCount,
  name: r'dueSrsCountProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dueSrsCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DueSrsCountRef = AutoDisposeFutureProviderRef<int>;
String _$srsLessonControllerHash() =>
    r'78384bd31e0540a42b407235d4d93664297aedb7';

/// See also [SrsLessonController].
@ProviderFor(SrsLessonController)
final srsLessonControllerProvider = AutoDisposeNotifierProvider<
    SrsLessonController, AsyncValue<SrsLessonDeck>>.internal(
  SrsLessonController.new,
  name: r'srsLessonControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$srsLessonControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SrsLessonController = AutoDisposeNotifier<AsyncValue<SrsLessonDeck>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
