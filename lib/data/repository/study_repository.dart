import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:drift/drift.dart';
import '../db/app_database.dart';
import '../providers.dart';

part 'study_repository.g.dart';

@riverpod
StudyRepository studyRepository(Ref ref) {
  // Use watch to rebuild if database changes (though db instance rarely changes)
  final db = ref.watch(appDatabaseProvider);
  return StudyRepository(db);
}

class StudyRepository {
  final AppDatabase _db;

  StudyRepository(this._db);

  Future<StudyStat?> getStats(String userId) {
    return _db.getStats(userId);
  }

  Future<void> saveProgress(
    String userId,
    int correctIncrement,
    int wrongIncrement,
  ) async {
    // Get current stats or create new
    final currentStats = await _db.getStats(userId);

    if (currentStats == null) {
      await _db.insertStats(
        StudyStatsCompanion.insert(
          userId: userId,
          correctCount: Value(correctIncrement),
          wrongCount: Value(wrongIncrement),
          lastUpdated: Value(DateTime.now()),
        ),
      );
    } else {
      await _db.insertStats(
        StudyStatsCompanion(
          userId: Value(userId),
          correctCount: Value(currentStats.correctCount + correctIncrement),
          wrongCount: Value(currentStats.wrongCount + wrongIncrement),
          lastUpdated: Value(DateTime.now()),
          // rowid not needed as userId is PK and we are doing insertOnConflictUpdate
        ),
      );
    }
  }
}
