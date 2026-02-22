import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:civis_web/data/repository/questions_repository.dart';

import 'package:civis_web/data/repository/progress_repository.dart';
import 'package:civis_web/data/model/category_progress.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  HomeUiState build() {
    // defer loading to avoid modifying state during build
    Future.microtask(() => loadProgress());
    return HomeUiState();
  }

  Future<void> loadProgress() async {
    state = state.copyWith(isLoading: true);
    try {
      final questionsRepo = ref.read(questionsRepositoryProvider);
      final progressRepo = ref.read(progressRepositoryProvider);

      final allQuestions = await questionsRepo.getQuestions();
      // Hardcoded user for now, or get from auth provider if exists
      final userProgressList = await progressRepo.getProgress("current_user");

      // Convert list to checkable map or set
      // ProgressData has userId, questionId, isCorrect
      final masteredQuestionIds = userProgressList
          .where((p) => p.isCorrect)
          .map((p) => p.questionId)
          .toSet();

      final categories = allQuestions.groupBy((q) => q.category);
      final progressList = categories.entries.map((entry) {
        final name = entry.key;
        final questions = entry.value;
        final completedCount = questions
            .where((q) => masteredQuestionIds.contains(q.id.toString()))
            .length;

        return CategoryProgress(
          name: name,
          totalQuestions: questions.length,
          completedQuestions: completedCount,
        );
      }).toList();

      state = state.copyWith(isLoading: false, categories: progressList);
    } catch (e) {
      debugPrint("HomeViewModel Error: $e");
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

class HomeUiState {
  final List<CategoryProgress> categories;
  final bool isLoading;
  final String? error;

  HomeUiState({this.categories = const [], this.isLoading = false, this.error});

  HomeUiState copyWith({
    List<CategoryProgress>? categories,
    bool? isLoading,
    String? error,
  }) {
    return HomeUiState(
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

extension IterableExtension<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
    <K, List<E>>{},
    (Map<K, List<E>> map, E element) =>
        map..putIfAbsent(keyFunction(element), () => <E>[]).add(element),
  );
}
