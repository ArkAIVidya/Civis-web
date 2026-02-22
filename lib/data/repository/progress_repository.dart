import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../db/app_database.dart';
import '../providers.dart';

part 'progress_repository.g.dart';

@riverpod
ProgressRepository progressRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return ProgressRepository(db);
}

class ProgressRepository {
  final AppDatabase _db;

  ProgressRepository(this._db);

  Future<List<QuestionProgressData>> getProgress(String userId) {
    return _db.getProgress(userId);
  }

  Future<void> saveProgress(List<QuestionProgressCompanion> progressList) {
    return _db.saveProgress(progressList);
  }

  Future<void> saveSingleProgress(QuestionProgressCompanion item) {
    return _db.saveSingleProgress(item);
  }

  Future<void> deleteAllProgress(String userId) {
    return _db.deleteAllProgress(userId);
  }
}
