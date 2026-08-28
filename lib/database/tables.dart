import 'package:drift/drift.dart';

class LocalSentencePairs extends Table {
  TextColumn get id => text()();
  TextColumn get sourceText => text()();
  TextColumn get targetText => text()();
  TextColumn get languageCode => text()();
  TextColumn get difficultyLevel => text().withDefault(const Constant('A1'))();
  TextColumn get topicCategory => text()();
  TextColumn get grammarNotes => text().nullable()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class LocalSrsItems extends Table {
  TextColumn get id => text()();
  TextColumn get sentenceId => text()();
  TextColumn get userId => text()();
  DateTimeColumn get nextReviewDate => dateTime().withDefault(currentDateAndTime)();
  IntColumn get intervalDays => integer().withDefault(const Constant(0))();
  RealColumn get easeFactor => real().withDefault(const Constant(2.5))();
  IntColumn get consecutiveCorrect => integer().withDefault(const Constant(0))();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class SyncQueueItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get action => text()();
  TextColumn get payload => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get status => text().withDefault(const Constant('PENDING'))();
}
