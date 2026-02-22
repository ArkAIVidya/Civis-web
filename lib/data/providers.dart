import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'db/app_database.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  // Use WasmDatabase for Flutter Web with LazyDatabase for initial async load
  final db = AppDatabase(
    LazyDatabase(() async {
      final result = await WasmDatabase.open(
        databaseName: 'civis_db',
        sqlite3Uri: Uri.parse('sqlite3.wasm'),
        driftWorkerUri: Uri.parse('drift_worker.js'),
      );
      return result.resolvedExecutor;
    }),
  );

  ref.onDispose(() => db.close());
  return db;
}
