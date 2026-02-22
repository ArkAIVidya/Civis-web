import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../manager/question_loader.dart';
import '../model/question.dart';
import 'user_preferences_repository.dart';
import 'progress_repository.dart';

part 'questions_repository.g.dart';

@riverpod
QuestionLoader questionLoader(Ref ref) {
  return QuestionLoader();
}

@riverpod
QuestionsRepository questionsRepository(Ref ref) {
  final loader = ref.watch(questionLoaderProvider);
  final prefs = ref.watch(userPreferencesRepositoryProvider);
  final progressRepo = ref.watch(progressRepositoryProvider);
  return QuestionsRepository(loader, prefs, progressRepo);
}

class QuestionsRepository {
  final QuestionLoader _loader;
  final UserPreferencesRepository _prefs;
  final ProgressRepository _progressRepo;
  List<Question> _cachedQuestions = [];

  QuestionsRepository(this._loader, this._prefs, this._progressRepo);

  Future<List<Question>> getQuestions() async {
    if (_cachedQuestions.isNotEmpty) return _cachedQuestions;
    _cachedQuestions = await _loader.loadQuestions();
    return _cachedQuestions;
  }

  Future<List<Question>> getResolvedQuestions({String? category}) async {
    final allQuestions = await getQuestions();
    final filtered = category != null
        ? allQuestions
              .where((q) => q.category.trim() == category.trim())
              .toList()
        : allQuestions;

    // Resolve dynamic answers
    return filtered.map((q) => _resolveQuestion(q)).toList();
  }

  Question _resolveQuestion(Question question) {
    if (!question.isDynamic) return question;

    String resolvedAnswer = question.answer;
    final regex = RegExp(r'\[\[(.*?)\]\]');

    final matches = regex.allMatches(question.answer);
    for (final match in matches) {
      final placeholder = match.group(0)!;
      final key = match.group(1)!; // Capture group 1
      final dynamicValue = _prefs.getOfficial(key);

      if (dynamicValue != null) {
        resolvedAnswer = resolvedAnswer.replaceAll(placeholder, dynamicValue);
      }
    }

    // Dart doesn't have copyWith on simple models unless generated or written manually.
    // I didn't verify if I added copyWith to Question model.
    // I used JsonSerializable but typically that doesn't generate copyWith (Freeze does).
    // I will manually return a new Question since I control the class.
    return Question(
      id: question.id,
      category: question.category,
      text: question.text,
      answer: resolvedAnswer, // Updated answer
      isDynamic: question.isDynamic,
    );
  }

  Future<Question> getRandomQuestion() async {
    final allQuestions = await getQuestions();
    if (allQuestions.isEmpty) throw Exception("No questions available");

    List<Question> availableQuestions = List.from(allQuestions);

    if (_prefs.isTriviaFilterUnmastered) {
      // Hardcoded user for now, per existing pattern
      final userProgressList = await _progressRepo.getProgress("current_user");
      final masteredQuestionIds = userProgressList
          .where((p) => p.isCorrect)
          .map((p) => int.parse(p.questionId))
          .toSet();

      final unmasteredQuestions = availableQuestions
          .where((q) => !masteredQuestionIds.contains(q.id))
          .toList();

      if (unmasteredQuestions.isNotEmpty) {
        availableQuestions = unmasteredQuestions;
      }
      // If all are mastered, we just show a random one from allQuestions
    }

    final randomQuestion = (availableQuestions..shuffle()).first;
    return _resolveQuestion(randomQuestion);
  }

  Future<Question?> getQuestionById(int id) async {
    final questions = await getQuestions();
    try {
      final question = questions.firstWhere((q) => q.id == id);
      return _resolveQuestion(question);
    } catch (_) {
      return null;
    }
  }
}
