import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:civis_web/data/repository/questions_repository.dart';
import 'package:civis_web/data/repository/study_repository.dart';
import 'package:civis_web/data/repository/progress_repository.dart';
import 'package:civis_web/data/model/question.dart';
import 'package:drift/drift.dart' as drift;
import 'package:civis_web/data/db/app_database.dart';

part 'study_view_model.g.dart';

@riverpod
class StudyViewModel extends _$StudyViewModel {
  @override
  StudyUiState build() {
    return StudyUiState();
  }

  Future<void> loadQuestions(String? category) async {
    debugPrint("StudyViewModel: Loading questions for category: $category");
    state = state.copyWith(isLoading: true, error: null);
    try {
      final questionsRepo = ref.read(questionsRepositoryProvider);
      final progressRepo = ref.read(progressRepositoryProvider);

      debugPrint("StudyViewModel: Fetching questions from repo...");
      final questions = await questionsRepo.getResolvedQuestions(
        category: category,
      );
      debugPrint("StudyViewModel: Got ${questions.length} questions");

      // Load progress
      debugPrint("StudyViewModel: Loading progress...");
      final progressList = await progressRepo.getProgress("current_user");
      debugPrint(
        "StudyViewModel: Got progress entries: ${progressList.length}",
      );

      final progressMap = {
        for (var p in progressList)
          if (p.isCorrect) int.parse(p.questionId): true,
      };

      // Find first unmastered index
      int firstUnmastered = 0;
      for (int i = 0; i < questions.length; i++) {
        if (!progressMap.containsKey(questions[i].id)) {
          firstUnmastered = i;
          break;
        }
      }

      state = state.copyWith(
        isLoading: false,
        questions: questions,
        initialIndex: firstUnmastered,
        answerStatus: progressMap,
      );
      debugPrint("StudyViewModel: State updated successfully");
    } catch (e, stack) {
      debugPrint("StudyViewModel Error: $e\n$stack");
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> recordAnswer(int questionId, bool wasCorrect) async {
    final studyRepo = ref.read(studyRepositoryProvider);
    final progressRepo = ref.read(progressRepositoryProvider);
    const userId = "current_user"; // Hardcoded for now

    // Update state immediately for UI responsiveness
    final newStatus = Map<int, bool>.from(state.answerStatus);
    if (wasCorrect) {
      newStatus[questionId] = true;
    } else {
      newStatus.remove(
        questionId,
      ); // Or set to false if tracking wrong answers specifically in map
    }
    state = state.copyWith(answerStatus: newStatus);

    // Persist
    try {
      if (wasCorrect) {
        await studyRepo.saveProgress(userId, 1, 0);
      } else {
        await studyRepo.saveProgress(userId, 0, 1);
      }

      await progressRepo.saveSingleProgress(
        QuestionProgressCompanion(
          userId: drift.Value(userId),
          questionId: drift.Value(questionId.toString()),
          isCorrect: drift.Value(wasCorrect),
        ),
      );
    } catch (e) {
      // Handle error (maybe revert state or show snackbar)
      debugPrint("Error saving progress: $e");
    }
  }
}

class StudyUiState {
  final List<Question> questions;
  final bool isLoading;
  final String? error;
  final int initialIndex;
  final Map<int, bool> answerStatus;

  StudyUiState({
    this.questions = const [],
    this.isLoading = false,
    this.error,
    this.initialIndex = 0,
    this.answerStatus = const {},
  });

  StudyUiState copyWith({
    List<Question>? questions,
    bool? isLoading,
    String? error,
    int? initialIndex,
    Map<int, bool>? answerStatus,
  }) {
    return StudyUiState(
      questions: questions ?? this.questions,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      initialIndex: initialIndex ?? this.initialIndex,
      answerStatus: answerStatus ?? this.answerStatus,
    );
  }
}
