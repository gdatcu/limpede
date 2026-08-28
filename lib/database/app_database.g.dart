// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LocalSentencePairsTable extends LocalSentencePairs
    with TableInfo<$LocalSentencePairsTable, LocalSentencePair> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalSentencePairsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sourceTextMeta =
      const VerificationMeta('sourceText');
  @override
  late final GeneratedColumn<String> sourceText = GeneratedColumn<String>(
      'source_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _targetTextMeta =
      const VerificationMeta('targetText');
  @override
  late final GeneratedColumn<String> targetText = GeneratedColumn<String>(
      'target_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _languageCodeMeta =
      const VerificationMeta('languageCode');
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
      'language_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _difficultyLevelMeta =
      const VerificationMeta('difficultyLevel');
  @override
  late final GeneratedColumn<String> difficultyLevel = GeneratedColumn<String>(
      'difficulty_level', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('A1'));
  static const VerificationMeta _topicCategoryMeta =
      const VerificationMeta('topicCategory');
  @override
  late final GeneratedColumn<String> topicCategory = GeneratedColumn<String>(
      'topic_category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _grammarNotesMeta =
      const VerificationMeta('grammarNotes');
  @override
  late final GeneratedColumn<String> grammarNotes = GeneratedColumn<String>(
      'grammar_notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sourceText,
        targetText,
        languageCode,
        difficultyLevel,
        topicCategory,
        grammarNotes,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_sentence_pairs';
  @override
  VerificationContext validateIntegrity(Insertable<LocalSentencePair> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('source_text')) {
      context.handle(
          _sourceTextMeta,
          sourceText.isAcceptableOrUnknown(
              data['source_text']!, _sourceTextMeta));
    } else if (isInserting) {
      context.missing(_sourceTextMeta);
    }
    if (data.containsKey('target_text')) {
      context.handle(
          _targetTextMeta,
          targetText.isAcceptableOrUnknown(
              data['target_text']!, _targetTextMeta));
    } else if (isInserting) {
      context.missing(_targetTextMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
          _languageCodeMeta,
          languageCode.isAcceptableOrUnknown(
              data['language_code']!, _languageCodeMeta));
    } else if (isInserting) {
      context.missing(_languageCodeMeta);
    }
    if (data.containsKey('difficulty_level')) {
      context.handle(
          _difficultyLevelMeta,
          difficultyLevel.isAcceptableOrUnknown(
              data['difficulty_level']!, _difficultyLevelMeta));
    }
    if (data.containsKey('topic_category')) {
      context.handle(
          _topicCategoryMeta,
          topicCategory.isAcceptableOrUnknown(
              data['topic_category']!, _topicCategoryMeta));
    } else if (isInserting) {
      context.missing(_topicCategoryMeta);
    }
    if (data.containsKey('grammar_notes')) {
      context.handle(
          _grammarNotesMeta,
          grammarNotes.isAcceptableOrUnknown(
              data['grammar_notes']!, _grammarNotesMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalSentencePair map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalSentencePair(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      sourceText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_text'])!,
      targetText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}target_text'])!,
      languageCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language_code'])!,
      difficultyLevel: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}difficulty_level'])!,
      topicCategory: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}topic_category'])!,
      grammarNotes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}grammar_notes']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $LocalSentencePairsTable createAlias(String alias) {
    return $LocalSentencePairsTable(attachedDatabase, alias);
  }
}

class LocalSentencePair extends DataClass
    implements Insertable<LocalSentencePair> {
  final String id;
  final String sourceText;
  final String targetText;
  final String languageCode;
  final String difficultyLevel;
  final String topicCategory;
  final String? grammarNotes;
  final DateTime updatedAt;
  const LocalSentencePair(
      {required this.id,
      required this.sourceText,
      required this.targetText,
      required this.languageCode,
      required this.difficultyLevel,
      required this.topicCategory,
      this.grammarNotes,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['source_text'] = Variable<String>(sourceText);
    map['target_text'] = Variable<String>(targetText);
    map['language_code'] = Variable<String>(languageCode);
    map['difficulty_level'] = Variable<String>(difficultyLevel);
    map['topic_category'] = Variable<String>(topicCategory);
    if (!nullToAbsent || grammarNotes != null) {
      map['grammar_notes'] = Variable<String>(grammarNotes);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LocalSentencePairsCompanion toCompanion(bool nullToAbsent) {
    return LocalSentencePairsCompanion(
      id: Value(id),
      sourceText: Value(sourceText),
      targetText: Value(targetText),
      languageCode: Value(languageCode),
      difficultyLevel: Value(difficultyLevel),
      topicCategory: Value(topicCategory),
      grammarNotes: grammarNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(grammarNotes),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalSentencePair.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalSentencePair(
      id: serializer.fromJson<String>(json['id']),
      sourceText: serializer.fromJson<String>(json['sourceText']),
      targetText: serializer.fromJson<String>(json['targetText']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      difficultyLevel: serializer.fromJson<String>(json['difficultyLevel']),
      topicCategory: serializer.fromJson<String>(json['topicCategory']),
      grammarNotes: serializer.fromJson<String?>(json['grammarNotes']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sourceText': serializer.toJson<String>(sourceText),
      'targetText': serializer.toJson<String>(targetText),
      'languageCode': serializer.toJson<String>(languageCode),
      'difficultyLevel': serializer.toJson<String>(difficultyLevel),
      'topicCategory': serializer.toJson<String>(topicCategory),
      'grammarNotes': serializer.toJson<String?>(grammarNotes),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LocalSentencePair copyWith(
          {String? id,
          String? sourceText,
          String? targetText,
          String? languageCode,
          String? difficultyLevel,
          String? topicCategory,
          Value<String?> grammarNotes = const Value.absent(),
          DateTime? updatedAt}) =>
      LocalSentencePair(
        id: id ?? this.id,
        sourceText: sourceText ?? this.sourceText,
        targetText: targetText ?? this.targetText,
        languageCode: languageCode ?? this.languageCode,
        difficultyLevel: difficultyLevel ?? this.difficultyLevel,
        topicCategory: topicCategory ?? this.topicCategory,
        grammarNotes:
            grammarNotes.present ? grammarNotes.value : this.grammarNotes,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  LocalSentencePair copyWithCompanion(LocalSentencePairsCompanion data) {
    return LocalSentencePair(
      id: data.id.present ? data.id.value : this.id,
      sourceText:
          data.sourceText.present ? data.sourceText.value : this.sourceText,
      targetText:
          data.targetText.present ? data.targetText.value : this.targetText,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
      difficultyLevel: data.difficultyLevel.present
          ? data.difficultyLevel.value
          : this.difficultyLevel,
      topicCategory: data.topicCategory.present
          ? data.topicCategory.value
          : this.topicCategory,
      grammarNotes: data.grammarNotes.present
          ? data.grammarNotes.value
          : this.grammarNotes,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalSentencePair(')
          ..write('id: $id, ')
          ..write('sourceText: $sourceText, ')
          ..write('targetText: $targetText, ')
          ..write('languageCode: $languageCode, ')
          ..write('difficultyLevel: $difficultyLevel, ')
          ..write('topicCategory: $topicCategory, ')
          ..write('grammarNotes: $grammarNotes, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sourceText, targetText, languageCode,
      difficultyLevel, topicCategory, grammarNotes, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalSentencePair &&
          other.id == this.id &&
          other.sourceText == this.sourceText &&
          other.targetText == this.targetText &&
          other.languageCode == this.languageCode &&
          other.difficultyLevel == this.difficultyLevel &&
          other.topicCategory == this.topicCategory &&
          other.grammarNotes == this.grammarNotes &&
          other.updatedAt == this.updatedAt);
}

class LocalSentencePairsCompanion extends UpdateCompanion<LocalSentencePair> {
  final Value<String> id;
  final Value<String> sourceText;
  final Value<String> targetText;
  final Value<String> languageCode;
  final Value<String> difficultyLevel;
  final Value<String> topicCategory;
  final Value<String?> grammarNotes;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const LocalSentencePairsCompanion({
    this.id = const Value.absent(),
    this.sourceText = const Value.absent(),
    this.targetText = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.difficultyLevel = const Value.absent(),
    this.topicCategory = const Value.absent(),
    this.grammarNotes = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalSentencePairsCompanion.insert({
    required String id,
    required String sourceText,
    required String targetText,
    required String languageCode,
    this.difficultyLevel = const Value.absent(),
    required String topicCategory,
    this.grammarNotes = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        sourceText = Value(sourceText),
        targetText = Value(targetText),
        languageCode = Value(languageCode),
        topicCategory = Value(topicCategory);
  static Insertable<LocalSentencePair> custom({
    Expression<String>? id,
    Expression<String>? sourceText,
    Expression<String>? targetText,
    Expression<String>? languageCode,
    Expression<String>? difficultyLevel,
    Expression<String>? topicCategory,
    Expression<String>? grammarNotes,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceText != null) 'source_text': sourceText,
      if (targetText != null) 'target_text': targetText,
      if (languageCode != null) 'language_code': languageCode,
      if (difficultyLevel != null) 'difficulty_level': difficultyLevel,
      if (topicCategory != null) 'topic_category': topicCategory,
      if (grammarNotes != null) 'grammar_notes': grammarNotes,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalSentencePairsCompanion copyWith(
      {Value<String>? id,
      Value<String>? sourceText,
      Value<String>? targetText,
      Value<String>? languageCode,
      Value<String>? difficultyLevel,
      Value<String>? topicCategory,
      Value<String?>? grammarNotes,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return LocalSentencePairsCompanion(
      id: id ?? this.id,
      sourceText: sourceText ?? this.sourceText,
      targetText: targetText ?? this.targetText,
      languageCode: languageCode ?? this.languageCode,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      topicCategory: topicCategory ?? this.topicCategory,
      grammarNotes: grammarNotes ?? this.grammarNotes,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sourceText.present) {
      map['source_text'] = Variable<String>(sourceText.value);
    }
    if (targetText.present) {
      map['target_text'] = Variable<String>(targetText.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (difficultyLevel.present) {
      map['difficulty_level'] = Variable<String>(difficultyLevel.value);
    }
    if (topicCategory.present) {
      map['topic_category'] = Variable<String>(topicCategory.value);
    }
    if (grammarNotes.present) {
      map['grammar_notes'] = Variable<String>(grammarNotes.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalSentencePairsCompanion(')
          ..write('id: $id, ')
          ..write('sourceText: $sourceText, ')
          ..write('targetText: $targetText, ')
          ..write('languageCode: $languageCode, ')
          ..write('difficultyLevel: $difficultyLevel, ')
          ..write('topicCategory: $topicCategory, ')
          ..write('grammarNotes: $grammarNotes, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalSrsItemsTable extends LocalSrsItems
    with TableInfo<$LocalSrsItemsTable, LocalSrsItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalSrsItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sentenceIdMeta =
      const VerificationMeta('sentenceId');
  @override
  late final GeneratedColumn<String> sentenceId = GeneratedColumn<String>(
      'sentence_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nextReviewDateMeta =
      const VerificationMeta('nextReviewDate');
  @override
  late final GeneratedColumn<DateTime> nextReviewDate =
      GeneratedColumn<DateTime>('next_review_date', aliasedName, false,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          defaultValue: currentDateAndTime);
  static const VerificationMeta _intervalDaysMeta =
      const VerificationMeta('intervalDays');
  @override
  late final GeneratedColumn<int> intervalDays = GeneratedColumn<int>(
      'interval_days', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _easeFactorMeta =
      const VerificationMeta('easeFactor');
  @override
  late final GeneratedColumn<double> easeFactor = GeneratedColumn<double>(
      'ease_factor', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(2.5));
  static const VerificationMeta _consecutiveCorrectMeta =
      const VerificationMeta('consecutiveCorrect');
  @override
  late final GeneratedColumn<int> consecutiveCorrect = GeneratedColumn<int>(
      'consecutive_correct', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sentenceId,
        userId,
        nextReviewDate,
        intervalDays,
        easeFactor,
        consecutiveCorrect,
        isSynced
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_srs_items';
  @override
  VerificationContext validateIntegrity(Insertable<LocalSrsItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('sentence_id')) {
      context.handle(
          _sentenceIdMeta,
          sentenceId.isAcceptableOrUnknown(
              data['sentence_id']!, _sentenceIdMeta));
    } else if (isInserting) {
      context.missing(_sentenceIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('next_review_date')) {
      context.handle(
          _nextReviewDateMeta,
          nextReviewDate.isAcceptableOrUnknown(
              data['next_review_date']!, _nextReviewDateMeta));
    }
    if (data.containsKey('interval_days')) {
      context.handle(
          _intervalDaysMeta,
          intervalDays.isAcceptableOrUnknown(
              data['interval_days']!, _intervalDaysMeta));
    }
    if (data.containsKey('ease_factor')) {
      context.handle(
          _easeFactorMeta,
          easeFactor.isAcceptableOrUnknown(
              data['ease_factor']!, _easeFactorMeta));
    }
    if (data.containsKey('consecutive_correct')) {
      context.handle(
          _consecutiveCorrectMeta,
          consecutiveCorrect.isAcceptableOrUnknown(
              data['consecutive_correct']!, _consecutiveCorrectMeta));
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalSrsItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalSrsItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      sentenceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sentence_id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      nextReviewDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}next_review_date'])!,
      intervalDays: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}interval_days'])!,
      easeFactor: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}ease_factor'])!,
      consecutiveCorrect: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}consecutive_correct'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
    );
  }

  @override
  $LocalSrsItemsTable createAlias(String alias) {
    return $LocalSrsItemsTable(attachedDatabase, alias);
  }
}

class LocalSrsItem extends DataClass implements Insertable<LocalSrsItem> {
  final String id;
  final String sentenceId;
  final String userId;
  final DateTime nextReviewDate;
  final int intervalDays;
  final double easeFactor;
  final int consecutiveCorrect;
  final bool isSynced;
  const LocalSrsItem(
      {required this.id,
      required this.sentenceId,
      required this.userId,
      required this.nextReviewDate,
      required this.intervalDays,
      required this.easeFactor,
      required this.consecutiveCorrect,
      required this.isSynced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['sentence_id'] = Variable<String>(sentenceId);
    map['user_id'] = Variable<String>(userId);
    map['next_review_date'] = Variable<DateTime>(nextReviewDate);
    map['interval_days'] = Variable<int>(intervalDays);
    map['ease_factor'] = Variable<double>(easeFactor);
    map['consecutive_correct'] = Variable<int>(consecutiveCorrect);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  LocalSrsItemsCompanion toCompanion(bool nullToAbsent) {
    return LocalSrsItemsCompanion(
      id: Value(id),
      sentenceId: Value(sentenceId),
      userId: Value(userId),
      nextReviewDate: Value(nextReviewDate),
      intervalDays: Value(intervalDays),
      easeFactor: Value(easeFactor),
      consecutiveCorrect: Value(consecutiveCorrect),
      isSynced: Value(isSynced),
    );
  }

  factory LocalSrsItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalSrsItem(
      id: serializer.fromJson<String>(json['id']),
      sentenceId: serializer.fromJson<String>(json['sentenceId']),
      userId: serializer.fromJson<String>(json['userId']),
      nextReviewDate: serializer.fromJson<DateTime>(json['nextReviewDate']),
      intervalDays: serializer.fromJson<int>(json['intervalDays']),
      easeFactor: serializer.fromJson<double>(json['easeFactor']),
      consecutiveCorrect: serializer.fromJson<int>(json['consecutiveCorrect']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sentenceId': serializer.toJson<String>(sentenceId),
      'userId': serializer.toJson<String>(userId),
      'nextReviewDate': serializer.toJson<DateTime>(nextReviewDate),
      'intervalDays': serializer.toJson<int>(intervalDays),
      'easeFactor': serializer.toJson<double>(easeFactor),
      'consecutiveCorrect': serializer.toJson<int>(consecutiveCorrect),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  LocalSrsItem copyWith(
          {String? id,
          String? sentenceId,
          String? userId,
          DateTime? nextReviewDate,
          int? intervalDays,
          double? easeFactor,
          int? consecutiveCorrect,
          bool? isSynced}) =>
      LocalSrsItem(
        id: id ?? this.id,
        sentenceId: sentenceId ?? this.sentenceId,
        userId: userId ?? this.userId,
        nextReviewDate: nextReviewDate ?? this.nextReviewDate,
        intervalDays: intervalDays ?? this.intervalDays,
        easeFactor: easeFactor ?? this.easeFactor,
        consecutiveCorrect: consecutiveCorrect ?? this.consecutiveCorrect,
        isSynced: isSynced ?? this.isSynced,
      );
  LocalSrsItem copyWithCompanion(LocalSrsItemsCompanion data) {
    return LocalSrsItem(
      id: data.id.present ? data.id.value : this.id,
      sentenceId:
          data.sentenceId.present ? data.sentenceId.value : this.sentenceId,
      userId: data.userId.present ? data.userId.value : this.userId,
      nextReviewDate: data.nextReviewDate.present
          ? data.nextReviewDate.value
          : this.nextReviewDate,
      intervalDays: data.intervalDays.present
          ? data.intervalDays.value
          : this.intervalDays,
      easeFactor:
          data.easeFactor.present ? data.easeFactor.value : this.easeFactor,
      consecutiveCorrect: data.consecutiveCorrect.present
          ? data.consecutiveCorrect.value
          : this.consecutiveCorrect,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalSrsItem(')
          ..write('id: $id, ')
          ..write('sentenceId: $sentenceId, ')
          ..write('userId: $userId, ')
          ..write('nextReviewDate: $nextReviewDate, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('easeFactor: $easeFactor, ')
          ..write('consecutiveCorrect: $consecutiveCorrect, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sentenceId, userId, nextReviewDate,
      intervalDays, easeFactor, consecutiveCorrect, isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalSrsItem &&
          other.id == this.id &&
          other.sentenceId == this.sentenceId &&
          other.userId == this.userId &&
          other.nextReviewDate == this.nextReviewDate &&
          other.intervalDays == this.intervalDays &&
          other.easeFactor == this.easeFactor &&
          other.consecutiveCorrect == this.consecutiveCorrect &&
          other.isSynced == this.isSynced);
}

class LocalSrsItemsCompanion extends UpdateCompanion<LocalSrsItem> {
  final Value<String> id;
  final Value<String> sentenceId;
  final Value<String> userId;
  final Value<DateTime> nextReviewDate;
  final Value<int> intervalDays;
  final Value<double> easeFactor;
  final Value<int> consecutiveCorrect;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const LocalSrsItemsCompanion({
    this.id = const Value.absent(),
    this.sentenceId = const Value.absent(),
    this.userId = const Value.absent(),
    this.nextReviewDate = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.easeFactor = const Value.absent(),
    this.consecutiveCorrect = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalSrsItemsCompanion.insert({
    required String id,
    required String sentenceId,
    required String userId,
    this.nextReviewDate = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.easeFactor = const Value.absent(),
    this.consecutiveCorrect = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        sentenceId = Value(sentenceId),
        userId = Value(userId);
  static Insertable<LocalSrsItem> custom({
    Expression<String>? id,
    Expression<String>? sentenceId,
    Expression<String>? userId,
    Expression<DateTime>? nextReviewDate,
    Expression<int>? intervalDays,
    Expression<double>? easeFactor,
    Expression<int>? consecutiveCorrect,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sentenceId != null) 'sentence_id': sentenceId,
      if (userId != null) 'user_id': userId,
      if (nextReviewDate != null) 'next_review_date': nextReviewDate,
      if (intervalDays != null) 'interval_days': intervalDays,
      if (easeFactor != null) 'ease_factor': easeFactor,
      if (consecutiveCorrect != null) 'consecutive_correct': consecutiveCorrect,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalSrsItemsCompanion copyWith(
      {Value<String>? id,
      Value<String>? sentenceId,
      Value<String>? userId,
      Value<DateTime>? nextReviewDate,
      Value<int>? intervalDays,
      Value<double>? easeFactor,
      Value<int>? consecutiveCorrect,
      Value<bool>? isSynced,
      Value<int>? rowid}) {
    return LocalSrsItemsCompanion(
      id: id ?? this.id,
      sentenceId: sentenceId ?? this.sentenceId,
      userId: userId ?? this.userId,
      nextReviewDate: nextReviewDate ?? this.nextReviewDate,
      intervalDays: intervalDays ?? this.intervalDays,
      easeFactor: easeFactor ?? this.easeFactor,
      consecutiveCorrect: consecutiveCorrect ?? this.consecutiveCorrect,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sentenceId.present) {
      map['sentence_id'] = Variable<String>(sentenceId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (nextReviewDate.present) {
      map['next_review_date'] = Variable<DateTime>(nextReviewDate.value);
    }
    if (intervalDays.present) {
      map['interval_days'] = Variable<int>(intervalDays.value);
    }
    if (easeFactor.present) {
      map['ease_factor'] = Variable<double>(easeFactor.value);
    }
    if (consecutiveCorrect.present) {
      map['consecutive_correct'] = Variable<int>(consecutiveCorrect.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalSrsItemsCompanion(')
          ..write('id: $id, ')
          ..write('sentenceId: $sentenceId, ')
          ..write('userId: $userId, ')
          ..write('nextReviewDate: $nextReviewDate, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('easeFactor: $easeFactor, ')
          ..write('consecutiveCorrect: $consecutiveCorrect, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueItemsTable extends SyncQueueItems
    with TableInfo<$SyncQueueItemsTable, SyncQueueItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
      'action', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payloadMeta =
      const VerificationMeta('payload');
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
      'payload', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('PENDING'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, action, payload, createdAt, status];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue_items';
  @override
  VerificationContext validateIntegrity(Insertable<SyncQueueItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('action')) {
      context.handle(_actionMeta,
          action.isAcceptableOrUnknown(data['action']!, _actionMeta));
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta,
          payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      action: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}action'])!,
      payload: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
    );
  }

  @override
  $SyncQueueItemsTable createAlias(String alias) {
    return $SyncQueueItemsTable(attachedDatabase, alias);
  }
}

class SyncQueueItem extends DataClass implements Insertable<SyncQueueItem> {
  final int id;
  final String action;
  final String payload;
  final DateTime createdAt;
  final String status;
  const SyncQueueItem(
      {required this.id,
      required this.action,
      required this.payload,
      required this.createdAt,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['action'] = Variable<String>(action);
    map['payload'] = Variable<String>(payload);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['status'] = Variable<String>(status);
    return map;
  }

  SyncQueueItemsCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueItemsCompanion(
      id: Value(id),
      action: Value(action),
      payload: Value(payload),
      createdAt: Value(createdAt),
      status: Value(status),
    );
  }

  factory SyncQueueItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueItem(
      id: serializer.fromJson<int>(json['id']),
      action: serializer.fromJson<String>(json['action']),
      payload: serializer.fromJson<String>(json['payload']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'action': serializer.toJson<String>(action),
      'payload': serializer.toJson<String>(payload),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'status': serializer.toJson<String>(status),
    };
  }

  SyncQueueItem copyWith(
          {int? id,
          String? action,
          String? payload,
          DateTime? createdAt,
          String? status}) =>
      SyncQueueItem(
        id: id ?? this.id,
        action: action ?? this.action,
        payload: payload ?? this.payload,
        createdAt: createdAt ?? this.createdAt,
        status: status ?? this.status,
      );
  SyncQueueItem copyWithCompanion(SyncQueueItemsCompanion data) {
    return SyncQueueItem(
      id: data.id.present ? data.id.value : this.id,
      action: data.action.present ? data.action.value : this.action,
      payload: data.payload.present ? data.payload.value : this.payload,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueItem(')
          ..write('id: $id, ')
          ..write('action: $action, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, action, payload, createdAt, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueItem &&
          other.id == this.id &&
          other.action == this.action &&
          other.payload == this.payload &&
          other.createdAt == this.createdAt &&
          other.status == this.status);
}

class SyncQueueItemsCompanion extends UpdateCompanion<SyncQueueItem> {
  final Value<int> id;
  final Value<String> action;
  final Value<String> payload;
  final Value<DateTime> createdAt;
  final Value<String> status;
  const SyncQueueItemsCompanion({
    this.id = const Value.absent(),
    this.action = const Value.absent(),
    this.payload = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.status = const Value.absent(),
  });
  SyncQueueItemsCompanion.insert({
    this.id = const Value.absent(),
    required String action,
    required String payload,
    this.createdAt = const Value.absent(),
    this.status = const Value.absent(),
  })  : action = Value(action),
        payload = Value(payload);
  static Insertable<SyncQueueItem> custom({
    Expression<int>? id,
    Expression<String>? action,
    Expression<String>? payload,
    Expression<DateTime>? createdAt,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (action != null) 'action': action,
      if (payload != null) 'payload': payload,
      if (createdAt != null) 'created_at': createdAt,
      if (status != null) 'status': status,
    });
  }

  SyncQueueItemsCompanion copyWith(
      {Value<int>? id,
      Value<String>? action,
      Value<String>? payload,
      Value<DateTime>? createdAt,
      Value<String>? status}) {
    return SyncQueueItemsCompanion(
      id: id ?? this.id,
      action: action ?? this.action,
      payload: payload ?? this.payload,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueItemsCompanion(')
          ..write('id: $id, ')
          ..write('action: $action, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LocalSentencePairsTable localSentencePairs =
      $LocalSentencePairsTable(this);
  late final $LocalSrsItemsTable localSrsItems = $LocalSrsItemsTable(this);
  late final $SyncQueueItemsTable syncQueueItems = $SyncQueueItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [localSentencePairs, localSrsItems, syncQueueItems];
}

typedef $$LocalSentencePairsTableCreateCompanionBuilder
    = LocalSentencePairsCompanion Function({
  required String id,
  required String sourceText,
  required String targetText,
  required String languageCode,
  Value<String> difficultyLevel,
  required String topicCategory,
  Value<String?> grammarNotes,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$LocalSentencePairsTableUpdateCompanionBuilder
    = LocalSentencePairsCompanion Function({
  Value<String> id,
  Value<String> sourceText,
  Value<String> targetText,
  Value<String> languageCode,
  Value<String> difficultyLevel,
  Value<String> topicCategory,
  Value<String?> grammarNotes,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$LocalSentencePairsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalSentencePairsTable> {
  $$LocalSentencePairsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sourceText => $composableBuilder(
      column: $table.sourceText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get targetText => $composableBuilder(
      column: $table.targetText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get languageCode => $composableBuilder(
      column: $table.languageCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get difficultyLevel => $composableBuilder(
      column: $table.difficultyLevel,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get topicCategory => $composableBuilder(
      column: $table.topicCategory, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get grammarNotes => $composableBuilder(
      column: $table.grammarNotes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$LocalSentencePairsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalSentencePairsTable> {
  $$LocalSentencePairsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sourceText => $composableBuilder(
      column: $table.sourceText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get targetText => $composableBuilder(
      column: $table.targetText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get languageCode => $composableBuilder(
      column: $table.languageCode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get difficultyLevel => $composableBuilder(
      column: $table.difficultyLevel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get topicCategory => $composableBuilder(
      column: $table.topicCategory,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get grammarNotes => $composableBuilder(
      column: $table.grammarNotes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$LocalSentencePairsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalSentencePairsTable> {
  $$LocalSentencePairsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sourceText => $composableBuilder(
      column: $table.sourceText, builder: (column) => column);

  GeneratedColumn<String> get targetText => $composableBuilder(
      column: $table.targetText, builder: (column) => column);

  GeneratedColumn<String> get languageCode => $composableBuilder(
      column: $table.languageCode, builder: (column) => column);

  GeneratedColumn<String> get difficultyLevel => $composableBuilder(
      column: $table.difficultyLevel, builder: (column) => column);

  GeneratedColumn<String> get topicCategory => $composableBuilder(
      column: $table.topicCategory, builder: (column) => column);

  GeneratedColumn<String> get grammarNotes => $composableBuilder(
      column: $table.grammarNotes, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocalSentencePairsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LocalSentencePairsTable,
    LocalSentencePair,
    $$LocalSentencePairsTableFilterComposer,
    $$LocalSentencePairsTableOrderingComposer,
    $$LocalSentencePairsTableAnnotationComposer,
    $$LocalSentencePairsTableCreateCompanionBuilder,
    $$LocalSentencePairsTableUpdateCompanionBuilder,
    (
      LocalSentencePair,
      BaseReferences<_$AppDatabase, $LocalSentencePairsTable, LocalSentencePair>
    ),
    LocalSentencePair,
    PrefetchHooks Function()> {
  $$LocalSentencePairsTableTableManager(
      _$AppDatabase db, $LocalSentencePairsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalSentencePairsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalSentencePairsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalSentencePairsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> sourceText = const Value.absent(),
            Value<String> targetText = const Value.absent(),
            Value<String> languageCode = const Value.absent(),
            Value<String> difficultyLevel = const Value.absent(),
            Value<String> topicCategory = const Value.absent(),
            Value<String?> grammarNotes = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalSentencePairsCompanion(
            id: id,
            sourceText: sourceText,
            targetText: targetText,
            languageCode: languageCode,
            difficultyLevel: difficultyLevel,
            topicCategory: topicCategory,
            grammarNotes: grammarNotes,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String sourceText,
            required String targetText,
            required String languageCode,
            Value<String> difficultyLevel = const Value.absent(),
            required String topicCategory,
            Value<String?> grammarNotes = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalSentencePairsCompanion.insert(
            id: id,
            sourceText: sourceText,
            targetText: targetText,
            languageCode: languageCode,
            difficultyLevel: difficultyLevel,
            topicCategory: topicCategory,
            grammarNotes: grammarNotes,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalSentencePairsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LocalSentencePairsTable,
    LocalSentencePair,
    $$LocalSentencePairsTableFilterComposer,
    $$LocalSentencePairsTableOrderingComposer,
    $$LocalSentencePairsTableAnnotationComposer,
    $$LocalSentencePairsTableCreateCompanionBuilder,
    $$LocalSentencePairsTableUpdateCompanionBuilder,
    (
      LocalSentencePair,
      BaseReferences<_$AppDatabase, $LocalSentencePairsTable, LocalSentencePair>
    ),
    LocalSentencePair,
    PrefetchHooks Function()>;
typedef $$LocalSrsItemsTableCreateCompanionBuilder = LocalSrsItemsCompanion
    Function({
  required String id,
  required String sentenceId,
  required String userId,
  Value<DateTime> nextReviewDate,
  Value<int> intervalDays,
  Value<double> easeFactor,
  Value<int> consecutiveCorrect,
  Value<bool> isSynced,
  Value<int> rowid,
});
typedef $$LocalSrsItemsTableUpdateCompanionBuilder = LocalSrsItemsCompanion
    Function({
  Value<String> id,
  Value<String> sentenceId,
  Value<String> userId,
  Value<DateTime> nextReviewDate,
  Value<int> intervalDays,
  Value<double> easeFactor,
  Value<int> consecutiveCorrect,
  Value<bool> isSynced,
  Value<int> rowid,
});

class $$LocalSrsItemsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalSrsItemsTable> {
  $$LocalSrsItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sentenceId => $composableBuilder(
      column: $table.sentenceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get nextReviewDate => $composableBuilder(
      column: $table.nextReviewDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get intervalDays => $composableBuilder(
      column: $table.intervalDays, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get easeFactor => $composableBuilder(
      column: $table.easeFactor, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get consecutiveCorrect => $composableBuilder(
      column: $table.consecutiveCorrect,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));
}

class $$LocalSrsItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalSrsItemsTable> {
  $$LocalSrsItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sentenceId => $composableBuilder(
      column: $table.sentenceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get nextReviewDate => $composableBuilder(
      column: $table.nextReviewDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get intervalDays => $composableBuilder(
      column: $table.intervalDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get easeFactor => $composableBuilder(
      column: $table.easeFactor, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get consecutiveCorrect => $composableBuilder(
      column: $table.consecutiveCorrect,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));
}

class $$LocalSrsItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalSrsItemsTable> {
  $$LocalSrsItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sentenceId => $composableBuilder(
      column: $table.sentenceId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get nextReviewDate => $composableBuilder(
      column: $table.nextReviewDate, builder: (column) => column);

  GeneratedColumn<int> get intervalDays => $composableBuilder(
      column: $table.intervalDays, builder: (column) => column);

  GeneratedColumn<double> get easeFactor => $composableBuilder(
      column: $table.easeFactor, builder: (column) => column);

  GeneratedColumn<int> get consecutiveCorrect => $composableBuilder(
      column: $table.consecutiveCorrect, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$LocalSrsItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LocalSrsItemsTable,
    LocalSrsItem,
    $$LocalSrsItemsTableFilterComposer,
    $$LocalSrsItemsTableOrderingComposer,
    $$LocalSrsItemsTableAnnotationComposer,
    $$LocalSrsItemsTableCreateCompanionBuilder,
    $$LocalSrsItemsTableUpdateCompanionBuilder,
    (
      LocalSrsItem,
      BaseReferences<_$AppDatabase, $LocalSrsItemsTable, LocalSrsItem>
    ),
    LocalSrsItem,
    PrefetchHooks Function()> {
  $$LocalSrsItemsTableTableManager(_$AppDatabase db, $LocalSrsItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalSrsItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalSrsItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalSrsItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> sentenceId = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<DateTime> nextReviewDate = const Value.absent(),
            Value<int> intervalDays = const Value.absent(),
            Value<double> easeFactor = const Value.absent(),
            Value<int> consecutiveCorrect = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalSrsItemsCompanion(
            id: id,
            sentenceId: sentenceId,
            userId: userId,
            nextReviewDate: nextReviewDate,
            intervalDays: intervalDays,
            easeFactor: easeFactor,
            consecutiveCorrect: consecutiveCorrect,
            isSynced: isSynced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String sentenceId,
            required String userId,
            Value<DateTime> nextReviewDate = const Value.absent(),
            Value<int> intervalDays = const Value.absent(),
            Value<double> easeFactor = const Value.absent(),
            Value<int> consecutiveCorrect = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalSrsItemsCompanion.insert(
            id: id,
            sentenceId: sentenceId,
            userId: userId,
            nextReviewDate: nextReviewDate,
            intervalDays: intervalDays,
            easeFactor: easeFactor,
            consecutiveCorrect: consecutiveCorrect,
            isSynced: isSynced,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalSrsItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LocalSrsItemsTable,
    LocalSrsItem,
    $$LocalSrsItemsTableFilterComposer,
    $$LocalSrsItemsTableOrderingComposer,
    $$LocalSrsItemsTableAnnotationComposer,
    $$LocalSrsItemsTableCreateCompanionBuilder,
    $$LocalSrsItemsTableUpdateCompanionBuilder,
    (
      LocalSrsItem,
      BaseReferences<_$AppDatabase, $LocalSrsItemsTable, LocalSrsItem>
    ),
    LocalSrsItem,
    PrefetchHooks Function()>;
typedef $$SyncQueueItemsTableCreateCompanionBuilder = SyncQueueItemsCompanion
    Function({
  Value<int> id,
  required String action,
  required String payload,
  Value<DateTime> createdAt,
  Value<String> status,
});
typedef $$SyncQueueItemsTableUpdateCompanionBuilder = SyncQueueItemsCompanion
    Function({
  Value<int> id,
  Value<String> action,
  Value<String> payload,
  Value<DateTime> createdAt,
  Value<String> status,
});

class $$SyncQueueItemsTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueItemsTable> {
  $$SyncQueueItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get action => $composableBuilder(
      column: $table.action, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));
}

class $$SyncQueueItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueItemsTable> {
  $$SyncQueueItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get action => $composableBuilder(
      column: $table.action, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));
}

class $$SyncQueueItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueItemsTable> {
  $$SyncQueueItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$SyncQueueItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncQueueItemsTable,
    SyncQueueItem,
    $$SyncQueueItemsTableFilterComposer,
    $$SyncQueueItemsTableOrderingComposer,
    $$SyncQueueItemsTableAnnotationComposer,
    $$SyncQueueItemsTableCreateCompanionBuilder,
    $$SyncQueueItemsTableUpdateCompanionBuilder,
    (
      SyncQueueItem,
      BaseReferences<_$AppDatabase, $SyncQueueItemsTable, SyncQueueItem>
    ),
    SyncQueueItem,
    PrefetchHooks Function()> {
  $$SyncQueueItemsTableTableManager(
      _$AppDatabase db, $SyncQueueItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> action = const Value.absent(),
            Value<String> payload = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<String> status = const Value.absent(),
          }) =>
              SyncQueueItemsCompanion(
            id: id,
            action: action,
            payload: payload,
            createdAt: createdAt,
            status: status,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String action,
            required String payload,
            Value<DateTime> createdAt = const Value.absent(),
            Value<String> status = const Value.absent(),
          }) =>
              SyncQueueItemsCompanion.insert(
            id: id,
            action: action,
            payload: payload,
            createdAt: createdAt,
            status: status,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncQueueItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncQueueItemsTable,
    SyncQueueItem,
    $$SyncQueueItemsTableFilterComposer,
    $$SyncQueueItemsTableOrderingComposer,
    $$SyncQueueItemsTableAnnotationComposer,
    $$SyncQueueItemsTableCreateCompanionBuilder,
    $$SyncQueueItemsTableUpdateCompanionBuilder,
    (
      SyncQueueItem,
      BaseReferences<_$AppDatabase, $SyncQueueItemsTable, SyncQueueItem>
    ),
    SyncQueueItem,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LocalSentencePairsTableTableManager get localSentencePairs =>
      $$LocalSentencePairsTableTableManager(_db, _db.localSentencePairs);
  $$LocalSrsItemsTableTableManager get localSrsItems =>
      $$LocalSrsItemsTableTableManager(_db, _db.localSrsItems);
  $$SyncQueueItemsTableTableManager get syncQueueItems =>
      $$SyncQueueItemsTableTableManager(_db, _db.syncQueueItems);
}
