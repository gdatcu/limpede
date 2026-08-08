// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ttsServiceHash() => r'975f196526e3bd3e8359dd94f6213c75f83eeb41';

/// See also [ttsService].
@ProviderFor(ttsService)
final ttsServiceProvider = Provider<TtsService>.internal(
  ttsService,
  name: r'ttsServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$ttsServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TtsServiceRef = ProviderRef<TtsService>;
String _$lessonCacheServiceHash() =>
    r'b618a8a1136afe917ead9b1cd47e5013ce83c914';

/// See also [lessonCacheService].
@ProviderFor(lessonCacheService)
final lessonCacheServiceProvider = Provider<LessonCacheService>.internal(
  lessonCacheService,
  name: r'lessonCacheServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$lessonCacheServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LessonCacheServiceRef = ProviderRef<LessonCacheService>;
String _$geminiServiceHash() => r'd30ece1b9081923399ad70fe596fb5f153a7e956';

/// See also [geminiService].
@ProviderFor(geminiService)
final geminiServiceProvider = Provider<GeminiService>.internal(
  geminiService,
  name: r'geminiServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$geminiServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GeminiServiceRef = ProviderRef<GeminiService>;
String _$lessonControllerHash() => r'd2f41a45d66630deeedf2211e69eb70bcbe2b5ef';

/// See also [LessonController].
@ProviderFor(LessonController)
final lessonControllerProvider =
    NotifierProvider<LessonController, AsyncValue<List<LessonBlock>>>.internal(
  LessonController.new,
  name: r'lessonControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$lessonControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LessonController = Notifier<AsyncValue<List<LessonBlock>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
