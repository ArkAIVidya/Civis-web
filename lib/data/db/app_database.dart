import 'package:drift/drift.dart';

part 'app_database.g.dart';

class QuestionProgress extends Table {
  TextColumn get userId => text()();
  TextColumn get questionId => text()();
  BoolColumn get isCorrect => boolean()();

  @override
  Set<Column> get primaryKey => {userId, questionId};
}

class StudyStats extends Table {
  TextColumn get userId => text()();
  IntColumn get correctCount => integer().withDefault(const Constant(0))();
  IntColumn get wrongCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastUpdated =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {userId};
}

@DriftDatabase(tables: [QuestionProgress, StudyStats])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;

  // Stats Accessor
  Future<StudyStat?> getStats(String userId) {
    return (select(
      studyStats,
    )..where((t) => t.userId.equals(userId))).getSingleOrNull();
  }

  Future<int> insertStats(StudyStatsCompanion stats) {
    return into(studyStats).insertOnConflictUpdate(stats);
  }

  // Progress Accessor
  Future<List<QuestionProgressData>> getProgress(String userId) {
    return (select(
      questionProgress,
    )..where((t) => t.userId.equals(userId))).get();
  }

  Future<void> saveProgress(
    List<QuestionProgressCompanion> progressList,
  ) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(questionProgress, progressList);
    });
  }

  Future<int> saveSingleProgress(QuestionProgressCompanion item) {
    return into(questionProgress).insertOnConflictUpdate(item);
  }

  Future<int> deleteAllProgress(String userId) {
    return (delete(
      questionProgress,
    )..where((t) => t.userId.equals(userId))).go();
  }
}
