// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_block.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LessonBlock _$LessonBlockFromJson(Map<String, dynamic> json) {
  return _LessonBlock.fromJson(json);
}

/// @nodoc
mixin _$LessonBlock {
  String get id => throw _privateConstructorUsedError;
  String get lessonId => throw _privateConstructorUsedError;
  int get orderIndex => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // 'explanation', 'multiple_choice', 'sentence_builder', 'matching'
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  List<String>? get options => throw _privateConstructorUsedError;
  String? get correctAnswer => throw _privateConstructorUsedError;
  String? get explanation => throw _privateConstructorUsedError;
  List<String>? get wordBank => throw _privateConstructorUsedError;
  Map<String, String>? get matchingPairs => throw _privateConstructorUsedError;

  /// Serializes this LessonBlock to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LessonBlock
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LessonBlockCopyWith<LessonBlock> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LessonBlockCopyWith<$Res> {
  factory $LessonBlockCopyWith(
          LessonBlock value, $Res Function(LessonBlock) then) =
      _$LessonBlockCopyWithImpl<$Res, LessonBlock>;
  @useResult
  $Res call(
      {String id,
      String lessonId,
      int orderIndex,
      String type,
      String title,
      String content,
      List<String>? options,
      String? correctAnswer,
      String? explanation,
      List<String>? wordBank,
      Map<String, String>? matchingPairs});
}

/// @nodoc
class _$LessonBlockCopyWithImpl<$Res, $Val extends LessonBlock>
    implements $LessonBlockCopyWith<$Res> {
  _$LessonBlockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LessonBlock
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? lessonId = null,
    Object? orderIndex = null,
    Object? type = null,
    Object? title = null,
    Object? content = null,
    Object? options = freezed,
    Object? correctAnswer = freezed,
    Object? explanation = freezed,
    Object? wordBank = freezed,
    Object? matchingPairs = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      lessonId: null == lessonId
          ? _value.lessonId
          : lessonId // ignore: cast_nullable_to_non_nullable
              as String,
      orderIndex: null == orderIndex
          ? _value.orderIndex
          : orderIndex // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      options: freezed == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      correctAnswer: freezed == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as String?,
      explanation: freezed == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String?,
      wordBank: freezed == wordBank
          ? _value.wordBank
          : wordBank // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      matchingPairs: freezed == matchingPairs
          ? _value.matchingPairs
          : matchingPairs // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LessonBlockImplCopyWith<$Res>
    implements $LessonBlockCopyWith<$Res> {
  factory _$$LessonBlockImplCopyWith(
          _$LessonBlockImpl value, $Res Function(_$LessonBlockImpl) then) =
      __$$LessonBlockImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String lessonId,
      int orderIndex,
      String type,
      String title,
      String content,
      List<String>? options,
      String? correctAnswer,
      String? explanation,
      List<String>? wordBank,
      Map<String, String>? matchingPairs});
}

/// @nodoc
class __$$LessonBlockImplCopyWithImpl<$Res>
    extends _$LessonBlockCopyWithImpl<$Res, _$LessonBlockImpl>
    implements _$$LessonBlockImplCopyWith<$Res> {
  __$$LessonBlockImplCopyWithImpl(
      _$LessonBlockImpl _value, $Res Function(_$LessonBlockImpl) _then)
      : super(_value, _then);

  /// Create a copy of LessonBlock
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? lessonId = null,
    Object? orderIndex = null,
    Object? type = null,
    Object? title = null,
    Object? content = null,
    Object? options = freezed,
    Object? correctAnswer = freezed,
    Object? explanation = freezed,
    Object? wordBank = freezed,
    Object? matchingPairs = freezed,
  }) {
    return _then(_$LessonBlockImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      lessonId: null == lessonId
          ? _value.lessonId
          : lessonId // ignore: cast_nullable_to_non_nullable
              as String,
      orderIndex: null == orderIndex
          ? _value.orderIndex
          : orderIndex // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      options: freezed == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      correctAnswer: freezed == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as String?,
      explanation: freezed == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String?,
      wordBank: freezed == wordBank
          ? _value._wordBank
          : wordBank // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      matchingPairs: freezed == matchingPairs
          ? _value._matchingPairs
          : matchingPairs // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LessonBlockImpl implements _LessonBlock {
  const _$LessonBlockImpl(
      {required this.id,
      required this.lessonId,
      required this.orderIndex,
      required this.type,
      required this.title,
      required this.content,
      final List<String>? options,
      this.correctAnswer,
      this.explanation,
      final List<String>? wordBank,
      final Map<String, String>? matchingPairs})
      : _options = options,
        _wordBank = wordBank,
        _matchingPairs = matchingPairs;

  factory _$LessonBlockImpl.fromJson(Map<String, dynamic> json) =>
      _$$LessonBlockImplFromJson(json);

  @override
  final String id;
  @override
  final String lessonId;
  @override
  final int orderIndex;
  @override
  final String type;
// 'explanation', 'multiple_choice', 'sentence_builder', 'matching'
  @override
  final String title;
  @override
  final String content;
  final List<String>? _options;
  @override
  List<String>? get options {
    final value = _options;
    if (value == null) return null;
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? correctAnswer;
  @override
  final String? explanation;
  final List<String>? _wordBank;
  @override
  List<String>? get wordBank {
    final value = _wordBank;
    if (value == null) return null;
    if (_wordBank is EqualUnmodifiableListView) return _wordBank;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, String>? _matchingPairs;
  @override
  Map<String, String>? get matchingPairs {
    final value = _matchingPairs;
    if (value == null) return null;
    if (_matchingPairs is EqualUnmodifiableMapView) return _matchingPairs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'LessonBlock(id: $id, lessonId: $lessonId, orderIndex: $orderIndex, type: $type, title: $title, content: $content, options: $options, correctAnswer: $correctAnswer, explanation: $explanation, wordBank: $wordBank, matchingPairs: $matchingPairs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LessonBlockImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.lessonId, lessonId) ||
                other.lessonId == lessonId) &&
            (identical(other.orderIndex, orderIndex) ||
                other.orderIndex == orderIndex) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            const DeepCollectionEquality().equals(other._wordBank, _wordBank) &&
            const DeepCollectionEquality()
                .equals(other._matchingPairs, _matchingPairs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      lessonId,
      orderIndex,
      type,
      title,
      content,
      const DeepCollectionEquality().hash(_options),
      correctAnswer,
      explanation,
      const DeepCollectionEquality().hash(_wordBank),
      const DeepCollectionEquality().hash(_matchingPairs));

  /// Create a copy of LessonBlock
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LessonBlockImplCopyWith<_$LessonBlockImpl> get copyWith =>
      __$$LessonBlockImplCopyWithImpl<_$LessonBlockImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LessonBlockImplToJson(
      this,
    );
  }
}

abstract class _LessonBlock implements LessonBlock {
  const factory _LessonBlock(
      {required final String id,
      required final String lessonId,
      required final int orderIndex,
      required final String type,
      required final String title,
      required final String content,
      final List<String>? options,
      final String? correctAnswer,
      final String? explanation,
      final List<String>? wordBank,
      final Map<String, String>? matchingPairs}) = _$LessonBlockImpl;

  factory _LessonBlock.fromJson(Map<String, dynamic> json) =
      _$LessonBlockImpl.fromJson;

  @override
  String get id;
  @override
  String get lessonId;
  @override
  int get orderIndex;
  @override
  String
      get type; // 'explanation', 'multiple_choice', 'sentence_builder', 'matching'
  @override
  String get title;
  @override
  String get content;
  @override
  List<String>? get options;
  @override
  String? get correctAnswer;
  @override
  String? get explanation;
  @override
  List<String>? get wordBank;
  @override
  Map<String, String>? get matchingPairs;

  /// Create a copy of LessonBlock
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LessonBlockImplCopyWith<_$LessonBlockImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
