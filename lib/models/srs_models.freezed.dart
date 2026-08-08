// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'srs_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SentencePair _$SentencePairFromJson(Map<String, dynamic> json) {
  return _SentencePair.fromJson(json);
}

/// @nodoc
mixin _$SentencePair {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'source_text')
  String get sourceText => throw _privateConstructorUsedError;
  @JsonKey(name: 'target_text')
  String get targetText => throw _privateConstructorUsedError;
  @JsonKey(name: 'language_code')
  String get languageCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'difficulty_level')
  String get difficultyLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'topic_category')
  String get topicCategory => throw _privateConstructorUsedError;
  @JsonKey(name: 'grammar_notes')
  String? get grammarNotes => throw _privateConstructorUsedError;

  /// Serializes this SentencePair to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SentencePair
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SentencePairCopyWith<SentencePair> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SentencePairCopyWith<$Res> {
  factory $SentencePairCopyWith(
          SentencePair value, $Res Function(SentencePair) then) =
      _$SentencePairCopyWithImpl<$Res, SentencePair>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'source_text') String sourceText,
      @JsonKey(name: 'target_text') String targetText,
      @JsonKey(name: 'language_code') String languageCode,
      @JsonKey(name: 'difficulty_level') String difficultyLevel,
      @JsonKey(name: 'topic_category') String topicCategory,
      @JsonKey(name: 'grammar_notes') String? grammarNotes});
}

/// @nodoc
class _$SentencePairCopyWithImpl<$Res, $Val extends SentencePair>
    implements $SentencePairCopyWith<$Res> {
  _$SentencePairCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SentencePair
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sourceText = null,
    Object? targetText = null,
    Object? languageCode = null,
    Object? difficultyLevel = null,
    Object? topicCategory = null,
    Object? grammarNotes = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sourceText: null == sourceText
          ? _value.sourceText
          : sourceText // ignore: cast_nullable_to_non_nullable
              as String,
      targetText: null == targetText
          ? _value.targetText
          : targetText // ignore: cast_nullable_to_non_nullable
              as String,
      languageCode: null == languageCode
          ? _value.languageCode
          : languageCode // ignore: cast_nullable_to_non_nullable
              as String,
      difficultyLevel: null == difficultyLevel
          ? _value.difficultyLevel
          : difficultyLevel // ignore: cast_nullable_to_non_nullable
              as String,
      topicCategory: null == topicCategory
          ? _value.topicCategory
          : topicCategory // ignore: cast_nullable_to_non_nullable
              as String,
      grammarNotes: freezed == grammarNotes
          ? _value.grammarNotes
          : grammarNotes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SentencePairImplCopyWith<$Res>
    implements $SentencePairCopyWith<$Res> {
  factory _$$SentencePairImplCopyWith(
          _$SentencePairImpl value, $Res Function(_$SentencePairImpl) then) =
      __$$SentencePairImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'source_text') String sourceText,
      @JsonKey(name: 'target_text') String targetText,
      @JsonKey(name: 'language_code') String languageCode,
      @JsonKey(name: 'difficulty_level') String difficultyLevel,
      @JsonKey(name: 'topic_category') String topicCategory,
      @JsonKey(name: 'grammar_notes') String? grammarNotes});
}

/// @nodoc
class __$$SentencePairImplCopyWithImpl<$Res>
    extends _$SentencePairCopyWithImpl<$Res, _$SentencePairImpl>
    implements _$$SentencePairImplCopyWith<$Res> {
  __$$SentencePairImplCopyWithImpl(
      _$SentencePairImpl _value, $Res Function(_$SentencePairImpl) _then)
      : super(_value, _then);

  /// Create a copy of SentencePair
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sourceText = null,
    Object? targetText = null,
    Object? languageCode = null,
    Object? difficultyLevel = null,
    Object? topicCategory = null,
    Object? grammarNotes = freezed,
  }) {
    return _then(_$SentencePairImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sourceText: null == sourceText
          ? _value.sourceText
          : sourceText // ignore: cast_nullable_to_non_nullable
              as String,
      targetText: null == targetText
          ? _value.targetText
          : targetText // ignore: cast_nullable_to_non_nullable
              as String,
      languageCode: null == languageCode
          ? _value.languageCode
          : languageCode // ignore: cast_nullable_to_non_nullable
              as String,
      difficultyLevel: null == difficultyLevel
          ? _value.difficultyLevel
          : difficultyLevel // ignore: cast_nullable_to_non_nullable
              as String,
      topicCategory: null == topicCategory
          ? _value.topicCategory
          : topicCategory // ignore: cast_nullable_to_non_nullable
              as String,
      grammarNotes: freezed == grammarNotes
          ? _value.grammarNotes
          : grammarNotes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SentencePairImpl implements _SentencePair {
  const _$SentencePairImpl(
      {required this.id,
      @JsonKey(name: 'source_text') required this.sourceText,
      @JsonKey(name: 'target_text') required this.targetText,
      @JsonKey(name: 'language_code') required this.languageCode,
      @JsonKey(name: 'difficulty_level') required this.difficultyLevel,
      @JsonKey(name: 'topic_category') required this.topicCategory,
      @JsonKey(name: 'grammar_notes') this.grammarNotes});

  factory _$SentencePairImpl.fromJson(Map<String, dynamic> json) =>
      _$$SentencePairImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'source_text')
  final String sourceText;
  @override
  @JsonKey(name: 'target_text')
  final String targetText;
  @override
  @JsonKey(name: 'language_code')
  final String languageCode;
  @override
  @JsonKey(name: 'difficulty_level')
  final String difficultyLevel;
  @override
  @JsonKey(name: 'topic_category')
  final String topicCategory;
  @override
  @JsonKey(name: 'grammar_notes')
  final String? grammarNotes;

  @override
  String toString() {
    return 'SentencePair(id: $id, sourceText: $sourceText, targetText: $targetText, languageCode: $languageCode, difficultyLevel: $difficultyLevel, topicCategory: $topicCategory, grammarNotes: $grammarNotes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SentencePairImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sourceText, sourceText) ||
                other.sourceText == sourceText) &&
            (identical(other.targetText, targetText) ||
                other.targetText == targetText) &&
            (identical(other.languageCode, languageCode) ||
                other.languageCode == languageCode) &&
            (identical(other.difficultyLevel, difficultyLevel) ||
                other.difficultyLevel == difficultyLevel) &&
            (identical(other.topicCategory, topicCategory) ||
                other.topicCategory == topicCategory) &&
            (identical(other.grammarNotes, grammarNotes) ||
                other.grammarNotes == grammarNotes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, sourceText, targetText,
      languageCode, difficultyLevel, topicCategory, grammarNotes);

  /// Create a copy of SentencePair
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SentencePairImplCopyWith<_$SentencePairImpl> get copyWith =>
      __$$SentencePairImplCopyWithImpl<_$SentencePairImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SentencePairImplToJson(
      this,
    );
  }
}

abstract class _SentencePair implements SentencePair {
  const factory _SentencePair(
      {required final String id,
      @JsonKey(name: 'source_text') required final String sourceText,
      @JsonKey(name: 'target_text') required final String targetText,
      @JsonKey(name: 'language_code') required final String languageCode,
      @JsonKey(name: 'difficulty_level') required final String difficultyLevel,
      @JsonKey(name: 'topic_category') required final String topicCategory,
      @JsonKey(name: 'grammar_notes')
      final String? grammarNotes}) = _$SentencePairImpl;

  factory _SentencePair.fromJson(Map<String, dynamic> json) =
      _$SentencePairImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'source_text')
  String get sourceText;
  @override
  @JsonKey(name: 'target_text')
  String get targetText;
  @override
  @JsonKey(name: 'language_code')
  String get languageCode;
  @override
  @JsonKey(name: 'difficulty_level')
  String get difficultyLevel;
  @override
  @JsonKey(name: 'topic_category')
  String get topicCategory;
  @override
  @JsonKey(name: 'grammar_notes')
  String? get grammarNotes;

  /// Create a copy of SentencePair
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SentencePairImplCopyWith<_$SentencePairImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SrsReviewItem _$SrsReviewItemFromJson(Map<String, dynamic> json) {
  return _SrsReviewItem.fromJson(json);
}

/// @nodoc
mixin _$SrsReviewItem {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'sentence_id')
  String get sentenceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_review_date')
  DateTime get nextReviewDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'interval_days')
  int get intervalDays => throw _privateConstructorUsedError;
  @JsonKey(name: 'ease_factor')
  double get easeFactor => throw _privateConstructorUsedError;
  @JsonKey(name: 'consecutive_correct')
  int get consecutiveCorrect => throw _privateConstructorUsedError;

  /// Serializes this SrsReviewItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SrsReviewItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SrsReviewItemCopyWith<SrsReviewItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SrsReviewItemCopyWith<$Res> {
  factory $SrsReviewItemCopyWith(
          SrsReviewItem value, $Res Function(SrsReviewItem) then) =
      _$SrsReviewItemCopyWithImpl<$Res, SrsReviewItem>;
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: 'sentence_id') String sentenceId,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'next_review_date') DateTime nextReviewDate,
      @JsonKey(name: 'interval_days') int intervalDays,
      @JsonKey(name: 'ease_factor') double easeFactor,
      @JsonKey(name: 'consecutive_correct') int consecutiveCorrect});
}

/// @nodoc
class _$SrsReviewItemCopyWithImpl<$Res, $Val extends SrsReviewItem>
    implements $SrsReviewItemCopyWith<$Res> {
  _$SrsReviewItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SrsReviewItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? sentenceId = null,
    Object? userId = null,
    Object? nextReviewDate = null,
    Object? intervalDays = null,
    Object? easeFactor = null,
    Object? consecutiveCorrect = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      sentenceId: null == sentenceId
          ? _value.sentenceId
          : sentenceId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      nextReviewDate: null == nextReviewDate
          ? _value.nextReviewDate
          : nextReviewDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      intervalDays: null == intervalDays
          ? _value.intervalDays
          : intervalDays // ignore: cast_nullable_to_non_nullable
              as int,
      easeFactor: null == easeFactor
          ? _value.easeFactor
          : easeFactor // ignore: cast_nullable_to_non_nullable
              as double,
      consecutiveCorrect: null == consecutiveCorrect
          ? _value.consecutiveCorrect
          : consecutiveCorrect // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SrsReviewItemImplCopyWith<$Res>
    implements $SrsReviewItemCopyWith<$Res> {
  factory _$$SrsReviewItemImplCopyWith(
          _$SrsReviewItemImpl value, $Res Function(_$SrsReviewItemImpl) then) =
      __$$SrsReviewItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: 'sentence_id') String sentenceId,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'next_review_date') DateTime nextReviewDate,
      @JsonKey(name: 'interval_days') int intervalDays,
      @JsonKey(name: 'ease_factor') double easeFactor,
      @JsonKey(name: 'consecutive_correct') int consecutiveCorrect});
}

/// @nodoc
class __$$SrsReviewItemImplCopyWithImpl<$Res>
    extends _$SrsReviewItemCopyWithImpl<$Res, _$SrsReviewItemImpl>
    implements _$$SrsReviewItemImplCopyWith<$Res> {
  __$$SrsReviewItemImplCopyWithImpl(
      _$SrsReviewItemImpl _value, $Res Function(_$SrsReviewItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of SrsReviewItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? sentenceId = null,
    Object? userId = null,
    Object? nextReviewDate = null,
    Object? intervalDays = null,
    Object? easeFactor = null,
    Object? consecutiveCorrect = null,
  }) {
    return _then(_$SrsReviewItemImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      sentenceId: null == sentenceId
          ? _value.sentenceId
          : sentenceId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      nextReviewDate: null == nextReviewDate
          ? _value.nextReviewDate
          : nextReviewDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      intervalDays: null == intervalDays
          ? _value.intervalDays
          : intervalDays // ignore: cast_nullable_to_non_nullable
              as int,
      easeFactor: null == easeFactor
          ? _value.easeFactor
          : easeFactor // ignore: cast_nullable_to_non_nullable
              as double,
      consecutiveCorrect: null == consecutiveCorrect
          ? _value.consecutiveCorrect
          : consecutiveCorrect // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SrsReviewItemImpl implements _SrsReviewItem {
  const _$SrsReviewItemImpl(
      {this.id,
      @JsonKey(name: 'sentence_id') required this.sentenceId,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'next_review_date') required this.nextReviewDate,
      @JsonKey(name: 'interval_days') this.intervalDays = 0,
      @JsonKey(name: 'ease_factor') this.easeFactor = 2.5,
      @JsonKey(name: 'consecutive_correct') this.consecutiveCorrect = 0});

  factory _$SrsReviewItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$SrsReviewItemImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'sentence_id')
  final String sentenceId;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'next_review_date')
  final DateTime nextReviewDate;
  @override
  @JsonKey(name: 'interval_days')
  final int intervalDays;
  @override
  @JsonKey(name: 'ease_factor')
  final double easeFactor;
  @override
  @JsonKey(name: 'consecutive_correct')
  final int consecutiveCorrect;

  @override
  String toString() {
    return 'SrsReviewItem(id: $id, sentenceId: $sentenceId, userId: $userId, nextReviewDate: $nextReviewDate, intervalDays: $intervalDays, easeFactor: $easeFactor, consecutiveCorrect: $consecutiveCorrect)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SrsReviewItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sentenceId, sentenceId) ||
                other.sentenceId == sentenceId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.nextReviewDate, nextReviewDate) ||
                other.nextReviewDate == nextReviewDate) &&
            (identical(other.intervalDays, intervalDays) ||
                other.intervalDays == intervalDays) &&
            (identical(other.easeFactor, easeFactor) ||
                other.easeFactor == easeFactor) &&
            (identical(other.consecutiveCorrect, consecutiveCorrect) ||
                other.consecutiveCorrect == consecutiveCorrect));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, sentenceId, userId,
      nextReviewDate, intervalDays, easeFactor, consecutiveCorrect);

  /// Create a copy of SrsReviewItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SrsReviewItemImplCopyWith<_$SrsReviewItemImpl> get copyWith =>
      __$$SrsReviewItemImplCopyWithImpl<_$SrsReviewItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SrsReviewItemImplToJson(
      this,
    );
  }
}

abstract class _SrsReviewItem implements SrsReviewItem {
  const factory _SrsReviewItem(
      {final String? id,
      @JsonKey(name: 'sentence_id') required final String sentenceId,
      @JsonKey(name: 'user_id') required final String userId,
      @JsonKey(name: 'next_review_date') required final DateTime nextReviewDate,
      @JsonKey(name: 'interval_days') final int intervalDays,
      @JsonKey(name: 'ease_factor') final double easeFactor,
      @JsonKey(name: 'consecutive_correct')
      final int consecutiveCorrect}) = _$SrsReviewItemImpl;

  factory _SrsReviewItem.fromJson(Map<String, dynamic> json) =
      _$SrsReviewItemImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'sentence_id')
  String get sentenceId;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'next_review_date')
  DateTime get nextReviewDate;
  @override
  @JsonKey(name: 'interval_days')
  int get intervalDays;
  @override
  @JsonKey(name: 'ease_factor')
  double get easeFactor;
  @override
  @JsonKey(name: 'consecutive_correct')
  int get consecutiveCorrect;

  /// Create a copy of SrsReviewItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SrsReviewItemImplCopyWith<_$SrsReviewItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
