// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LessonNode _$LessonNodeFromJson(Map<String, dynamic> json) {
  return _LessonNode.fromJson(json);
}

/// @nodoc
mixin _$LessonNode {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get level => throw _privateConstructorUsedError; // A1, A2, B1, B2, C1
  LessonNodeStatus get status => throw _privateConstructorUsedError;
  int get xpReward => throw _privateConstructorUsedError;
  String get topic => throw _privateConstructorUsedError;
  String get targetLanguage => throw _privateConstructorUsedError;
  int get stars => throw _privateConstructorUsedError;

  /// Serializes this LessonNode to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LessonNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LessonNodeCopyWith<LessonNode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LessonNodeCopyWith<$Res> {
  factory $LessonNodeCopyWith(
          LessonNode value, $Res Function(LessonNode) then) =
      _$LessonNodeCopyWithImpl<$Res, LessonNode>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String level,
      LessonNodeStatus status,
      int xpReward,
      String topic,
      String targetLanguage,
      int stars});
}

/// @nodoc
class _$LessonNodeCopyWithImpl<$Res, $Val extends LessonNode>
    implements $LessonNodeCopyWith<$Res> {
  _$LessonNodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LessonNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? level = null,
    Object? status = null,
    Object? xpReward = null,
    Object? topic = null,
    Object? targetLanguage = null,
    Object? stars = null,
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
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LessonNodeStatus,
      xpReward: null == xpReward
          ? _value.xpReward
          : xpReward // ignore: cast_nullable_to_non_nullable
              as int,
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      targetLanguage: null == targetLanguage
          ? _value.targetLanguage
          : targetLanguage // ignore: cast_nullable_to_non_nullable
              as String,
      stars: null == stars
          ? _value.stars
          : stars // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LessonNodeImplCopyWith<$Res>
    implements $LessonNodeCopyWith<$Res> {
  factory _$$LessonNodeImplCopyWith(
          _$LessonNodeImpl value, $Res Function(_$LessonNodeImpl) then) =
      __$$LessonNodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String level,
      LessonNodeStatus status,
      int xpReward,
      String topic,
      String targetLanguage,
      int stars});
}

/// @nodoc
class __$$LessonNodeImplCopyWithImpl<$Res>
    extends _$LessonNodeCopyWithImpl<$Res, _$LessonNodeImpl>
    implements _$$LessonNodeImplCopyWith<$Res> {
  __$$LessonNodeImplCopyWithImpl(
      _$LessonNodeImpl _value, $Res Function(_$LessonNodeImpl) _then)
      : super(_value, _then);

  /// Create a copy of LessonNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? level = null,
    Object? status = null,
    Object? xpReward = null,
    Object? topic = null,
    Object? targetLanguage = null,
    Object? stars = null,
  }) {
    return _then(_$LessonNodeImpl(
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
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LessonNodeStatus,
      xpReward: null == xpReward
          ? _value.xpReward
          : xpReward // ignore: cast_nullable_to_non_nullable
              as int,
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      targetLanguage: null == targetLanguage
          ? _value.targetLanguage
          : targetLanguage // ignore: cast_nullable_to_non_nullable
              as String,
      stars: null == stars
          ? _value.stars
          : stars // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LessonNodeImpl implements _LessonNode {
  const _$LessonNodeImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.level,
      required this.status,
      required this.xpReward,
      required this.topic,
      required this.targetLanguage,
      this.stars = 0});

  factory _$LessonNodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$LessonNodeImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String level;
// A1, A2, B1, B2, C1
  @override
  final LessonNodeStatus status;
  @override
  final int xpReward;
  @override
  final String topic;
  @override
  final String targetLanguage;
  @override
  @JsonKey()
  final int stars;

  @override
  String toString() {
    return 'LessonNode(id: $id, title: $title, description: $description, level: $level, status: $status, xpReward: $xpReward, topic: $topic, targetLanguage: $targetLanguage, stars: $stars)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LessonNodeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.xpReward, xpReward) ||
                other.xpReward == xpReward) &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.targetLanguage, targetLanguage) ||
                other.targetLanguage == targetLanguage) &&
            (identical(other.stars, stars) || other.stars == stars));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, level,
      status, xpReward, topic, targetLanguage, stars);

  /// Create a copy of LessonNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LessonNodeImplCopyWith<_$LessonNodeImpl> get copyWith =>
      __$$LessonNodeImplCopyWithImpl<_$LessonNodeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LessonNodeImplToJson(
      this,
    );
  }
}

abstract class _LessonNode implements LessonNode {
  const factory _LessonNode(
      {required final String id,
      required final String title,
      required final String description,
      required final String level,
      required final LessonNodeStatus status,
      required final int xpReward,
      required final String topic,
      required final String targetLanguage,
      final int stars}) = _$LessonNodeImpl;

  factory _LessonNode.fromJson(Map<String, dynamic> json) =
      _$LessonNodeImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get level; // A1, A2, B1, B2, C1
  @override
  LessonNodeStatus get status;
  @override
  int get xpReward;
  @override
  String get topic;
  @override
  String get targetLanguage;
  @override
  int get stars;

  /// Create a copy of LessonNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LessonNodeImplCopyWith<_$LessonNodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CourseUnit _$CourseUnitFromJson(Map<String, dynamic> json) {
  return _CourseUnit.fromJson(json);
}

/// @nodoc
mixin _$CourseUnit {
  String get id => throw _privateConstructorUsedError;
  int get unitNumber => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get levelBadge =>
      throw _privateConstructorUsedError; // e.g. "A1 Beginner"
  List<LessonNode> get lessons => throw _privateConstructorUsedError;

  /// Serializes this CourseUnit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CourseUnit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CourseUnitCopyWith<CourseUnit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseUnitCopyWith<$Res> {
  factory $CourseUnitCopyWith(
          CourseUnit value, $Res Function(CourseUnit) then) =
      _$CourseUnitCopyWithImpl<$Res, CourseUnit>;
  @useResult
  $Res call(
      {String id,
      int unitNumber,
      String title,
      String description,
      String levelBadge,
      List<LessonNode> lessons});
}

/// @nodoc
class _$CourseUnitCopyWithImpl<$Res, $Val extends CourseUnit>
    implements $CourseUnitCopyWith<$Res> {
  _$CourseUnitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CourseUnit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? unitNumber = null,
    Object? title = null,
    Object? description = null,
    Object? levelBadge = null,
    Object? lessons = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      unitNumber: null == unitNumber
          ? _value.unitNumber
          : unitNumber // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      levelBadge: null == levelBadge
          ? _value.levelBadge
          : levelBadge // ignore: cast_nullable_to_non_nullable
              as String,
      lessons: null == lessons
          ? _value.lessons
          : lessons // ignore: cast_nullable_to_non_nullable
              as List<LessonNode>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CourseUnitImplCopyWith<$Res>
    implements $CourseUnitCopyWith<$Res> {
  factory _$$CourseUnitImplCopyWith(
          _$CourseUnitImpl value, $Res Function(_$CourseUnitImpl) then) =
      __$$CourseUnitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      int unitNumber,
      String title,
      String description,
      String levelBadge,
      List<LessonNode> lessons});
}

/// @nodoc
class __$$CourseUnitImplCopyWithImpl<$Res>
    extends _$CourseUnitCopyWithImpl<$Res, _$CourseUnitImpl>
    implements _$$CourseUnitImplCopyWith<$Res> {
  __$$CourseUnitImplCopyWithImpl(
      _$CourseUnitImpl _value, $Res Function(_$CourseUnitImpl) _then)
      : super(_value, _then);

  /// Create a copy of CourseUnit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? unitNumber = null,
    Object? title = null,
    Object? description = null,
    Object? levelBadge = null,
    Object? lessons = null,
  }) {
    return _then(_$CourseUnitImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      unitNumber: null == unitNumber
          ? _value.unitNumber
          : unitNumber // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      levelBadge: null == levelBadge
          ? _value.levelBadge
          : levelBadge // ignore: cast_nullable_to_non_nullable
              as String,
      lessons: null == lessons
          ? _value._lessons
          : lessons // ignore: cast_nullable_to_non_nullable
              as List<LessonNode>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CourseUnitImpl implements _CourseUnit {
  const _$CourseUnitImpl(
      {required this.id,
      required this.unitNumber,
      required this.title,
      required this.description,
      required this.levelBadge,
      required final List<LessonNode> lessons})
      : _lessons = lessons;

  factory _$CourseUnitImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseUnitImplFromJson(json);

  @override
  final String id;
  @override
  final int unitNumber;
  @override
  final String title;
  @override
  final String description;
  @override
  final String levelBadge;
// e.g. "A1 Beginner"
  final List<LessonNode> _lessons;
// e.g. "A1 Beginner"
  @override
  List<LessonNode> get lessons {
    if (_lessons is EqualUnmodifiableListView) return _lessons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lessons);
  }

  @override
  String toString() {
    return 'CourseUnit(id: $id, unitNumber: $unitNumber, title: $title, description: $description, levelBadge: $levelBadge, lessons: $lessons)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseUnitImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.unitNumber, unitNumber) ||
                other.unitNumber == unitNumber) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.levelBadge, levelBadge) ||
                other.levelBadge == levelBadge) &&
            const DeepCollectionEquality().equals(other._lessons, _lessons));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, unitNumber, title,
      description, levelBadge, const DeepCollectionEquality().hash(_lessons));

  /// Create a copy of CourseUnit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseUnitImplCopyWith<_$CourseUnitImpl> get copyWith =>
      __$$CourseUnitImplCopyWithImpl<_$CourseUnitImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseUnitImplToJson(
      this,
    );
  }
}

abstract class _CourseUnit implements CourseUnit {
  const factory _CourseUnit(
      {required final String id,
      required final int unitNumber,
      required final String title,
      required final String description,
      required final String levelBadge,
      required final List<LessonNode> lessons}) = _$CourseUnitImpl;

  factory _CourseUnit.fromJson(Map<String, dynamic> json) =
      _$CourseUnitImpl.fromJson;

  @override
  String get id;
  @override
  int get unitNumber;
  @override
  String get title;
  @override
  String get description;
  @override
  String get levelBadge; // e.g. "A1 Beginner"
  @override
  List<LessonNode> get lessons;

  /// Create a copy of CourseUnit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseUnitImplCopyWith<_$CourseUnitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
