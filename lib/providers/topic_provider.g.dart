// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$topicUnitsHash() => r'0fc06004cf913b8dbe94ea924455e385806dd1d9';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [topicUnits].
@ProviderFor(topicUnits)
const topicUnitsProvider = TopicUnitsFamily();

/// See also [topicUnits].
class TopicUnitsFamily extends Family<AsyncValue<List<TopicUnit>>> {
  /// See also [topicUnits].
  const TopicUnitsFamily();

  /// See also [topicUnits].
  TopicUnitsProvider call({
    required String targetLanguage,
  }) {
    return TopicUnitsProvider(
      targetLanguage: targetLanguage,
    );
  }

  @override
  TopicUnitsProvider getProviderOverride(
    covariant TopicUnitsProvider provider,
  ) {
    return call(
      targetLanguage: provider.targetLanguage,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'topicUnitsProvider';
}

/// See also [topicUnits].
class TopicUnitsProvider extends AutoDisposeFutureProvider<List<TopicUnit>> {
  /// See also [topicUnits].
  TopicUnitsProvider({
    required String targetLanguage,
  }) : this._internal(
          (ref) => topicUnits(
            ref as TopicUnitsRef,
            targetLanguage: targetLanguage,
          ),
          from: topicUnitsProvider,
          name: r'topicUnitsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$topicUnitsHash,
          dependencies: TopicUnitsFamily._dependencies,
          allTransitiveDependencies:
              TopicUnitsFamily._allTransitiveDependencies,
          targetLanguage: targetLanguage,
        );

  TopicUnitsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.targetLanguage,
  }) : super.internal();

  final String targetLanguage;

  @override
  Override overrideWith(
    FutureOr<List<TopicUnit>> Function(TopicUnitsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TopicUnitsProvider._internal(
        (ref) => create(ref as TopicUnitsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        targetLanguage: targetLanguage,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<TopicUnit>> createElement() {
    return _TopicUnitsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TopicUnitsProvider &&
        other.targetLanguage == targetLanguage;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, targetLanguage.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TopicUnitsRef on AutoDisposeFutureProviderRef<List<TopicUnit>> {
  /// The parameter `targetLanguage` of this provider.
  String get targetLanguage;
}

class _TopicUnitsProviderElement
    extends AutoDisposeFutureProviderElement<List<TopicUnit>>
    with TopicUnitsRef {
  _TopicUnitsProviderElement(super.provider);

  @override
  String get targetLanguage => (origin as TopicUnitsProvider).targetLanguage;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
