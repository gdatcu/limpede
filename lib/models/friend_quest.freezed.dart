// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend_quest.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FriendQuest _$FriendQuestFromJson(Map<String, dynamic> json) {
  return _FriendQuest.fromJson(json);
}

/// @nodoc
mixin _$FriendQuest {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get partnerName => throw _privateConstructorUsedError;
  String get partnerEmoji => throw _privateConstructorUsedError;
  String? get partnerAvatarUrl => throw _privateConstructorUsedError;
  int get userContribution => throw _privateConstructorUsedError;
  int get partnerContribution => throw _privateConstructorUsedError;
  int get targetGoal => throw _privateConstructorUsedError;
  int get sharedStreakDays => throw _privateConstructorUsedError;
  int get daysRemaining => throw _privateConstructorUsedError;
  int get rewardDroplets => throw _privateConstructorUsedError;
  bool get isClaimed => throw _privateConstructorUsedError;
  DateTime? get lastNudgeSentAt => throw _privateConstructorUsedError;

  /// Serializes this FriendQuest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FriendQuest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendQuestCopyWith<FriendQuest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendQuestCopyWith<$Res> {
  factory $FriendQuestCopyWith(
          FriendQuest value, $Res Function(FriendQuest) then) =
      _$FriendQuestCopyWithImpl<$Res, FriendQuest>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String partnerName,
      String partnerEmoji,
      String? partnerAvatarUrl,
      int userContribution,
      int partnerContribution,
      int targetGoal,
      int sharedStreakDays,
      int daysRemaining,
      int rewardDroplets,
      bool isClaimed,
      DateTime? lastNudgeSentAt});
}

/// @nodoc
class _$FriendQuestCopyWithImpl<$Res, $Val extends FriendQuest>
    implements $FriendQuestCopyWith<$Res> {
  _$FriendQuestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FriendQuest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? partnerName = null,
    Object? partnerEmoji = null,
    Object? partnerAvatarUrl = freezed,
    Object? userContribution = null,
    Object? partnerContribution = null,
    Object? targetGoal = null,
    Object? sharedStreakDays = null,
    Object? daysRemaining = null,
    Object? rewardDroplets = null,
    Object? isClaimed = null,
    Object? lastNudgeSentAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      partnerName: null == partnerName
          ? _value.partnerName
          : partnerName // ignore: cast_nullable_to_non_nullable
              as String,
      partnerEmoji: null == partnerEmoji
          ? _value.partnerEmoji
          : partnerEmoji // ignore: cast_nullable_to_non_nullable
              as String,
      partnerAvatarUrl: freezed == partnerAvatarUrl
          ? _value.partnerAvatarUrl
          : partnerAvatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      userContribution: null == userContribution
          ? _value.userContribution
          : userContribution // ignore: cast_nullable_to_non_nullable
              as int,
      partnerContribution: null == partnerContribution
          ? _value.partnerContribution
          : partnerContribution // ignore: cast_nullable_to_non_nullable
              as int,
      targetGoal: null == targetGoal
          ? _value.targetGoal
          : targetGoal // ignore: cast_nullable_to_non_nullable
              as int,
      sharedStreakDays: null == sharedStreakDays
          ? _value.sharedStreakDays
          : sharedStreakDays // ignore: cast_nullable_to_non_nullable
              as int,
      daysRemaining: null == daysRemaining
          ? _value.daysRemaining
          : daysRemaining // ignore: cast_nullable_to_non_nullable
              as int,
      rewardDroplets: null == rewardDroplets
          ? _value.rewardDroplets
          : rewardDroplets // ignore: cast_nullable_to_non_nullable
              as int,
      isClaimed: null == isClaimed
          ? _value.isClaimed
          : isClaimed // ignore: cast_nullable_to_non_nullable
              as bool,
      lastNudgeSentAt: freezed == lastNudgeSentAt
          ? _value.lastNudgeSentAt
          : lastNudgeSentAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FriendQuestImplCopyWith<$Res>
    implements $FriendQuestCopyWith<$Res> {
  factory _$$FriendQuestImplCopyWith(
          _$FriendQuestImpl value, $Res Function(_$FriendQuestImpl) then) =
      __$$FriendQuestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String partnerName,
      String partnerEmoji,
      String? partnerAvatarUrl,
      int userContribution,
      int partnerContribution,
      int targetGoal,
      int sharedStreakDays,
      int daysRemaining,
      int rewardDroplets,
      bool isClaimed,
      DateTime? lastNudgeSentAt});
}

/// @nodoc
class __$$FriendQuestImplCopyWithImpl<$Res>
    extends _$FriendQuestCopyWithImpl<$Res, _$FriendQuestImpl>
    implements _$$FriendQuestImplCopyWith<$Res> {
  __$$FriendQuestImplCopyWithImpl(
      _$FriendQuestImpl _value, $Res Function(_$FriendQuestImpl) _then)
      : super(_value, _then);

  /// Create a copy of FriendQuest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? partnerName = null,
    Object? partnerEmoji = null,
    Object? partnerAvatarUrl = freezed,
    Object? userContribution = null,
    Object? partnerContribution = null,
    Object? targetGoal = null,
    Object? sharedStreakDays = null,
    Object? daysRemaining = null,
    Object? rewardDroplets = null,
    Object? isClaimed = null,
    Object? lastNudgeSentAt = freezed,
  }) {
    return _then(_$FriendQuestImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      partnerName: null == partnerName
          ? _value.partnerName
          : partnerName // ignore: cast_nullable_to_non_nullable
              as String,
      partnerEmoji: null == partnerEmoji
          ? _value.partnerEmoji
          : partnerEmoji // ignore: cast_nullable_to_non_nullable
              as String,
      partnerAvatarUrl: freezed == partnerAvatarUrl
          ? _value.partnerAvatarUrl
          : partnerAvatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      userContribution: null == userContribution
          ? _value.userContribution
          : userContribution // ignore: cast_nullable_to_non_nullable
              as int,
      partnerContribution: null == partnerContribution
          ? _value.partnerContribution
          : partnerContribution // ignore: cast_nullable_to_non_nullable
              as int,
      targetGoal: null == targetGoal
          ? _value.targetGoal
          : targetGoal // ignore: cast_nullable_to_non_nullable
              as int,
      sharedStreakDays: null == sharedStreakDays
          ? _value.sharedStreakDays
          : sharedStreakDays // ignore: cast_nullable_to_non_nullable
              as int,
      daysRemaining: null == daysRemaining
          ? _value.daysRemaining
          : daysRemaining // ignore: cast_nullable_to_non_nullable
              as int,
      rewardDroplets: null == rewardDroplets
          ? _value.rewardDroplets
          : rewardDroplets // ignore: cast_nullable_to_non_nullable
              as int,
      isClaimed: null == isClaimed
          ? _value.isClaimed
          : isClaimed // ignore: cast_nullable_to_non_nullable
              as bool,
      lastNudgeSentAt: freezed == lastNudgeSentAt
          ? _value.lastNudgeSentAt
          : lastNudgeSentAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FriendQuestImpl extends _FriendQuest {
  const _$FriendQuestImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.partnerName,
      this.partnerEmoji = '👩‍🎨',
      this.partnerAvatarUrl,
      this.userContribution = 0,
      this.partnerContribution = 0,
      this.targetGoal = 25,
      this.sharedStreakDays = 4,
      this.daysRemaining = 3,
      this.rewardDroplets = 25,
      this.isClaimed = false,
      this.lastNudgeSentAt})
      : super._();

  factory _$FriendQuestImpl.fromJson(Map<String, dynamic> json) =>
      _$$FriendQuestImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String partnerName;
  @override
  @JsonKey()
  final String partnerEmoji;
  @override
  final String? partnerAvatarUrl;
  @override
  @JsonKey()
  final int userContribution;
  @override
  @JsonKey()
  final int partnerContribution;
  @override
  @JsonKey()
  final int targetGoal;
  @override
  @JsonKey()
  final int sharedStreakDays;
  @override
  @JsonKey()
  final int daysRemaining;
  @override
  @JsonKey()
  final int rewardDroplets;
  @override
  @JsonKey()
  final bool isClaimed;
  @override
  final DateTime? lastNudgeSentAt;

  @override
  String toString() {
    return 'FriendQuest(id: $id, title: $title, description: $description, partnerName: $partnerName, partnerEmoji: $partnerEmoji, partnerAvatarUrl: $partnerAvatarUrl, userContribution: $userContribution, partnerContribution: $partnerContribution, targetGoal: $targetGoal, sharedStreakDays: $sharedStreakDays, daysRemaining: $daysRemaining, rewardDroplets: $rewardDroplets, isClaimed: $isClaimed, lastNudgeSentAt: $lastNudgeSentAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendQuestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.partnerName, partnerName) ||
                other.partnerName == partnerName) &&
            (identical(other.partnerEmoji, partnerEmoji) ||
                other.partnerEmoji == partnerEmoji) &&
            (identical(other.partnerAvatarUrl, partnerAvatarUrl) ||
                other.partnerAvatarUrl == partnerAvatarUrl) &&
            (identical(other.userContribution, userContribution) ||
                other.userContribution == userContribution) &&
            (identical(other.partnerContribution, partnerContribution) ||
                other.partnerContribution == partnerContribution) &&
            (identical(other.targetGoal, targetGoal) ||
                other.targetGoal == targetGoal) &&
            (identical(other.sharedStreakDays, sharedStreakDays) ||
                other.sharedStreakDays == sharedStreakDays) &&
            (identical(other.daysRemaining, daysRemaining) ||
                other.daysRemaining == daysRemaining) &&
            (identical(other.rewardDroplets, rewardDroplets) ||
                other.rewardDroplets == rewardDroplets) &&
            (identical(other.isClaimed, isClaimed) ||
                other.isClaimed == isClaimed) &&
            (identical(other.lastNudgeSentAt, lastNudgeSentAt) ||
                other.lastNudgeSentAt == lastNudgeSentAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      partnerName,
      partnerEmoji,
      partnerAvatarUrl,
      userContribution,
      partnerContribution,
      targetGoal,
      sharedStreakDays,
      daysRemaining,
      rewardDroplets,
      isClaimed,
      lastNudgeSentAt);

  /// Create a copy of FriendQuest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendQuestImplCopyWith<_$FriendQuestImpl> get copyWith =>
      __$$FriendQuestImplCopyWithImpl<_$FriendQuestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FriendQuestImplToJson(
      this,
    );
  }
}

abstract class _FriendQuest extends FriendQuest {
  const factory _FriendQuest(
      {required final String id,
      required final String title,
      required final String description,
      required final String partnerName,
      final String partnerEmoji,
      final String? partnerAvatarUrl,
      final int userContribution,
      final int partnerContribution,
      final int targetGoal,
      final int sharedStreakDays,
      final int daysRemaining,
      final int rewardDroplets,
      final bool isClaimed,
      final DateTime? lastNudgeSentAt}) = _$FriendQuestImpl;
  const _FriendQuest._() : super._();

  factory _FriendQuest.fromJson(Map<String, dynamic> json) =
      _$FriendQuestImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get partnerName;
  @override
  String get partnerEmoji;
  @override
  String? get partnerAvatarUrl;
  @override
  int get userContribution;
  @override
  int get partnerContribution;
  @override
  int get targetGoal;
  @override
  int get sharedStreakDays;
  @override
  int get daysRemaining;
  @override
  int get rewardDroplets;
  @override
  bool get isClaimed;
  @override
  DateTime? get lastNudgeSentAt;

  /// Create a copy of FriendQuest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendQuestImplCopyWith<_$FriendQuestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
