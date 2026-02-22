// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $QuestionProgressTable extends QuestionProgress
    with TableInfo<$QuestionProgressTable, QuestionProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _questionIdMeta = const VerificationMeta(
    'questionId',
  );
  @override
  late final GeneratedColumn<String> questionId = GeneratedColumn<String>(
    'question_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isCorrectMeta = const VerificationMeta(
    'isCorrect',
  );
  @override
  late final GeneratedColumn<bool> isCorrect = GeneratedColumn<bool>(
    'is_correct',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_correct" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [userId, questionId, isCorrect];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'question_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuestionProgressData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('question_id')) {
      context.handle(
        _questionIdMeta,
        questionId.isAcceptableOrUnknown(data['question_id']!, _questionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('is_correct')) {
      context.handle(
        _isCorrectMeta,
        isCorrect.isAcceptableOrUnknown(data['is_correct']!, _isCorrectMeta),
      );
    } else if (isInserting) {
      context.missing(_isCorrectMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId, questionId};
  @override
  QuestionProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionProgressData(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      questionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_id'],
      )!,
      isCorrect: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_correct'],
      )!,
    );
  }

  @override
  $QuestionProgressTable createAlias(String alias) {
    return $QuestionProgressTable(attachedDatabase, alias);
  }
}

class QuestionProgressData extends DataClass
    implements Insertable<QuestionProgressData> {
  final String userId;
  final String questionId;
  final bool isCorrect;
  const QuestionProgressData({
    required this.userId,
    required this.questionId,
    required this.isCorrect,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['question_id'] = Variable<String>(questionId);
    map['is_correct'] = Variable<bool>(isCorrect);
    return map;
  }

  QuestionProgressCompanion toCompanion(bool nullToAbsent) {
    return QuestionProgressCompanion(
      userId: Value(userId),
      questionId: Value(questionId),
      isCorrect: Value(isCorrect),
    );
  }

  factory QuestionProgressData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionProgressData(
      userId: serializer.fromJson<String>(json['userId']),
      questionId: serializer.fromJson<String>(json['questionId']),
      isCorrect: serializer.fromJson<bool>(json['isCorrect']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'questionId': serializer.toJson<String>(questionId),
      'isCorrect': serializer.toJson<bool>(isCorrect),
    };
  }

  QuestionProgressData copyWith({
    String? userId,
    String? questionId,
    bool? isCorrect,
  }) => QuestionProgressData(
    userId: userId ?? this.userId,
    questionId: questionId ?? this.questionId,
    isCorrect: isCorrect ?? this.isCorrect,
  );
  QuestionProgressData copyWithCompanion(QuestionProgressCompanion data) {
    return QuestionProgressData(
      userId: data.userId.present ? data.userId.value : this.userId,
      questionId: data.questionId.present
          ? data.questionId.value
          : this.questionId,
      isCorrect: data.isCorrect.present ? data.isCorrect.value : this.isCorrect,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuestionProgressData(')
          ..write('userId: $userId, ')
          ..write('questionId: $questionId, ')
          ..write('isCorrect: $isCorrect')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(userId, questionId, isCorrect);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionProgressData &&
          other.userId == this.userId &&
          other.questionId == this.questionId &&
          other.isCorrect == this.isCorrect);
}

class QuestionProgressCompanion extends UpdateCompanion<QuestionProgressData> {
  final Value<String> userId;
  final Value<String> questionId;
  final Value<bool> isCorrect;
  final Value<int> rowid;
  const QuestionProgressCompanion({
    this.userId = const Value.absent(),
    this.questionId = const Value.absent(),
    this.isCorrect = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionProgressCompanion.insert({
    required String userId,
    required String questionId,
    required bool isCorrect,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       questionId = Value(questionId),
       isCorrect = Value(isCorrect);
  static Insertable<QuestionProgressData> custom({
    Expression<String>? userId,
    Expression<String>? questionId,
    Expression<bool>? isCorrect,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (questionId != null) 'question_id': questionId,
      if (isCorrect != null) 'is_correct': isCorrect,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionProgressCompanion copyWith({
    Value<String>? userId,
    Value<String>? questionId,
    Value<bool>? isCorrect,
    Value<int>? rowid,
  }) {
    return QuestionProgressCompanion(
      userId: userId ?? this.userId,
      questionId: questionId ?? this.questionId,
      isCorrect: isCorrect ?? this.isCorrect,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<String>(questionId.value);
    }
    if (isCorrect.present) {
      map['is_correct'] = Variable<bool>(isCorrect.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionProgressCompanion(')
          ..write('userId: $userId, ')
          ..write('questionId: $questionId, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StudyStatsTable extends StudyStats
    with TableInfo<$StudyStatsTable, StudyStat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudyStatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _correctCountMeta = const VerificationMeta(
    'correctCount',
  );
  @override
  late final GeneratedColumn<int> correctCount = GeneratedColumn<int>(
    'correct_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _wrongCountMeta = const VerificationMeta(
    'wrongCount',
  );
  @override
  late final GeneratedColumn<int> wrongCount = GeneratedColumn<int>(
    'wrong_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastUpdatedMeta = const VerificationMeta(
    'lastUpdated',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
    'last_updated',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    userId,
    correctCount,
    wrongCount,
    lastUpdated,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_stats';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudyStat> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('correct_count')) {
      context.handle(
        _correctCountMeta,
        correctCount.isAcceptableOrUnknown(
          data['correct_count']!,
          _correctCountMeta,
        ),
      );
    }
    if (data.containsKey('wrong_count')) {
      context.handle(
        _wrongCountMeta,
        wrongCount.isAcceptableOrUnknown(data['wrong_count']!, _wrongCountMeta),
      );
    }
    if (data.containsKey('last_updated')) {
      context.handle(
        _lastUpdatedMeta,
        lastUpdated.isAcceptableOrUnknown(
          data['last_updated']!,
          _lastUpdatedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  StudyStat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudyStat(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      correctCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_count'],
      )!,
      wrongCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wrong_count'],
      )!,
      lastUpdated: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated'],
      )!,
    );
  }

  @override
  $StudyStatsTable createAlias(String alias) {
    return $StudyStatsTable(attachedDatabase, alias);
  }
}

class StudyStat extends DataClass implements Insertable<StudyStat> {
  final String userId;
  final int correctCount;
  final int wrongCount;
  final DateTime lastUpdated;
  const StudyStat({
    required this.userId,
    required this.correctCount,
    required this.wrongCount,
    required this.lastUpdated,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['correct_count'] = Variable<int>(correctCount);
    map['wrong_count'] = Variable<int>(wrongCount);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  StudyStatsCompanion toCompanion(bool nullToAbsent) {
    return StudyStatsCompanion(
      userId: Value(userId),
      correctCount: Value(correctCount),
      wrongCount: Value(wrongCount),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory StudyStat.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudyStat(
      userId: serializer.fromJson<String>(json['userId']),
      correctCount: serializer.fromJson<int>(json['correctCount']),
      wrongCount: serializer.fromJson<int>(json['wrongCount']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'correctCount': serializer.toJson<int>(correctCount),
      'wrongCount': serializer.toJson<int>(wrongCount),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  StudyStat copyWith({
    String? userId,
    int? correctCount,
    int? wrongCount,
    DateTime? lastUpdated,
  }) => StudyStat(
    userId: userId ?? this.userId,
    correctCount: correctCount ?? this.correctCount,
    wrongCount: wrongCount ?? this.wrongCount,
    lastUpdated: lastUpdated ?? this.lastUpdated,
  );
  StudyStat copyWithCompanion(StudyStatsCompanion data) {
    return StudyStat(
      userId: data.userId.present ? data.userId.value : this.userId,
      correctCount: data.correctCount.present
          ? data.correctCount.value
          : this.correctCount,
      wrongCount: data.wrongCount.present
          ? data.wrongCount.value
          : this.wrongCount,
      lastUpdated: data.lastUpdated.present
          ? data.lastUpdated.value
          : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudyStat(')
          ..write('userId: $userId, ')
          ..write('correctCount: $correctCount, ')
          ..write('wrongCount: $wrongCount, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(userId, correctCount, wrongCount, lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudyStat &&
          other.userId == this.userId &&
          other.correctCount == this.correctCount &&
          other.wrongCount == this.wrongCount &&
          other.lastUpdated == this.lastUpdated);
}

class StudyStatsCompanion extends UpdateCompanion<StudyStat> {
  final Value<String> userId;
  final Value<int> correctCount;
  final Value<int> wrongCount;
  final Value<DateTime> lastUpdated;
  final Value<int> rowid;
  const StudyStatsCompanion({
    this.userId = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.wrongCount = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudyStatsCompanion.insert({
    required String userId,
    this.correctCount = const Value.absent(),
    this.wrongCount = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : userId = Value(userId);
  static Insertable<StudyStat> custom({
    Expression<String>? userId,
    Expression<int>? correctCount,
    Expression<int>? wrongCount,
    Expression<DateTime>? lastUpdated,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (correctCount != null) 'correct_count': correctCount,
      if (wrongCount != null) 'wrong_count': wrongCount,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudyStatsCompanion copyWith({
    Value<String>? userId,
    Value<int>? correctCount,
    Value<int>? wrongCount,
    Value<DateTime>? lastUpdated,
    Value<int>? rowid,
  }) {
    return StudyStatsCompanion(
      userId: userId ?? this.userId,
      correctCount: correctCount ?? this.correctCount,
      wrongCount: wrongCount ?? this.wrongCount,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (correctCount.present) {
      map['correct_count'] = Variable<int>(correctCount.value);
    }
    if (wrongCount.present) {
      map['wrong_count'] = Variable<int>(wrongCount.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudyStatsCompanion(')
          ..write('userId: $userId, ')
          ..write('correctCount: $correctCount, ')
          ..write('wrongCount: $wrongCount, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $QuestionProgressTable questionProgress = $QuestionProgressTable(
    this,
  );
  late final $StudyStatsTable studyStats = $StudyStatsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    questionProgress,
    studyStats,
  ];
}

typedef $$QuestionProgressTableCreateCompanionBuilder =
    QuestionProgressCompanion Function({
      required String userId,
      required String questionId,
      required bool isCorrect,
      Value<int> rowid,
    });
typedef $$QuestionProgressTableUpdateCompanionBuilder =
    QuestionProgressCompanion Function({
      Value<String> userId,
      Value<String> questionId,
      Value<bool> isCorrect,
      Value<int> rowid,
    });

class $$QuestionProgressTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionProgressTable> {
  $$QuestionProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCorrect => $composableBuilder(
    column: $table.isCorrect,
    builder: (column) => ColumnFilters(column),
  );
}

class $$QuestionProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionProgressTable> {
  $$QuestionProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCorrect => $composableBuilder(
    column: $table.isCorrect,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$QuestionProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionProgressTable> {
  $$QuestionProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCorrect =>
      $composableBuilder(column: $table.isCorrect, builder: (column) => column);
}

class $$QuestionProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuestionProgressTable,
          QuestionProgressData,
          $$QuestionProgressTableFilterComposer,
          $$QuestionProgressTableOrderingComposer,
          $$QuestionProgressTableAnnotationComposer,
          $$QuestionProgressTableCreateCompanionBuilder,
          $$QuestionProgressTableUpdateCompanionBuilder,
          (
            QuestionProgressData,
            BaseReferences<
              _$AppDatabase,
              $QuestionProgressTable,
              QuestionProgressData
            >,
          ),
          QuestionProgressData,
          PrefetchHooks Function()
        > {
  $$QuestionProgressTableTableManager(
    _$AppDatabase db,
    $QuestionProgressTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestionProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuestionProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<String> questionId = const Value.absent(),
                Value<bool> isCorrect = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuestionProgressCompanion(
                userId: userId,
                questionId: questionId,
                isCorrect: isCorrect,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                required String questionId,
                required bool isCorrect,
                Value<int> rowid = const Value.absent(),
              }) => QuestionProgressCompanion.insert(
                userId: userId,
                questionId: questionId,
                isCorrect: isCorrect,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$QuestionProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuestionProgressTable,
      QuestionProgressData,
      $$QuestionProgressTableFilterComposer,
      $$QuestionProgressTableOrderingComposer,
      $$QuestionProgressTableAnnotationComposer,
      $$QuestionProgressTableCreateCompanionBuilder,
      $$QuestionProgressTableUpdateCompanionBuilder,
      (
        QuestionProgressData,
        BaseReferences<
          _$AppDatabase,
          $QuestionProgressTable,
          QuestionProgressData
        >,
      ),
      QuestionProgressData,
      PrefetchHooks Function()
    >;
typedef $$StudyStatsTableCreateCompanionBuilder =
    StudyStatsCompanion Function({
      required String userId,
      Value<int> correctCount,
      Value<int> wrongCount,
      Value<DateTime> lastUpdated,
      Value<int> rowid,
    });
typedef $$StudyStatsTableUpdateCompanionBuilder =
    StudyStatsCompanion Function({
      Value<String> userId,
      Value<int> correctCount,
      Value<int> wrongCount,
      Value<DateTime> lastUpdated,
      Value<int> rowid,
    });

class $$StudyStatsTableFilterComposer
    extends Composer<_$AppDatabase, $StudyStatsTable> {
  $$StudyStatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wrongCount => $composableBuilder(
    column: $table.wrongCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StudyStatsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudyStatsTable> {
  $$StudyStatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wrongCount => $composableBuilder(
    column: $table.wrongCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StudyStatsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudyStatsTable> {
  $$StudyStatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get wrongCount => $composableBuilder(
    column: $table.wrongCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => column,
  );
}

class $$StudyStatsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudyStatsTable,
          StudyStat,
          $$StudyStatsTableFilterComposer,
          $$StudyStatsTableOrderingComposer,
          $$StudyStatsTableAnnotationComposer,
          $$StudyStatsTableCreateCompanionBuilder,
          $$StudyStatsTableUpdateCompanionBuilder,
          (
            StudyStat,
            BaseReferences<_$AppDatabase, $StudyStatsTable, StudyStat>,
          ),
          StudyStat,
          PrefetchHooks Function()
        > {
  $$StudyStatsTableTableManager(_$AppDatabase db, $StudyStatsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudyStatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudyStatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudyStatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<int> correctCount = const Value.absent(),
                Value<int> wrongCount = const Value.absent(),
                Value<DateTime> lastUpdated = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudyStatsCompanion(
                userId: userId,
                correctCount: correctCount,
                wrongCount: wrongCount,
                lastUpdated: lastUpdated,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                Value<int> correctCount = const Value.absent(),
                Value<int> wrongCount = const Value.absent(),
                Value<DateTime> lastUpdated = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudyStatsCompanion.insert(
                userId: userId,
                correctCount: correctCount,
                wrongCount: wrongCount,
                lastUpdated: lastUpdated,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StudyStatsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudyStatsTable,
      StudyStat,
      $$StudyStatsTableFilterComposer,
      $$StudyStatsTableOrderingComposer,
      $$StudyStatsTableAnnotationComposer,
      $$StudyStatsTableCreateCompanionBuilder,
      $$StudyStatsTableUpdateCompanionBuilder,
      (StudyStat, BaseReferences<_$AppDatabase, $StudyStatsTable, StudyStat>),
      StudyStat,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$QuestionProgressTableTableManager get questionProgress =>
      $$QuestionProgressTableTableManager(_db, _db.questionProgress);
  $$StudyStatsTableTableManager get studyStats =>
      $$StudyStatsTableTableManager(_db, _db.studyStats);
}
