import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:civis_web/data/repository/questions_repository.dart';

import '../../components/flashcard.dart';
import 'package:civis_web/data/model/question.dart';

import 'package:civis_web/data/repository/progress_repository.dart';
import 'package:civis_web/data/repository/study_repository.dart';
import 'package:civis_web/data/db/app_database.dart';
import 'package:drift/drift.dart' as drift;

// This model holds both the question and its initial mastery status
class RandomQuestionData {
  final Question question;
  final bool isMastered;

  RandomQuestionData({required this.question, required this.isMastered});
}

// Simple provider for random question
final randomQuestionProvider = FutureProvider.autoDispose<RandomQuestionData>((
  ref,
) async {
  final repo = ref.watch(questionsRepositoryProvider);
  final progressRepo = ref.watch(progressRepositoryProvider);

  final question = await repo.getRandomQuestion();

  final progressList = await progressRepo.getProgress("current_user");
  final isMastered = progressList.any(
    (p) => p.questionId == question.id.toString() && p.isCorrect,
  );

  return RandomQuestionData(question: question, isMastered: isMastered);
});

class RandomQuestionScreen extends ConsumerStatefulWidget {
  const RandomQuestionScreen({super.key});

  @override
  ConsumerState<RandomQuestionScreen> createState() =>
      _RandomQuestionScreenState();
}

class _RandomQuestionScreenState extends ConsumerState<RandomQuestionScreen> {
  // We keep track of local mastery state here for immediate UI updates
  bool? _localIsMastered;
  int? _currentQuestionId;

  Future<void> _toggleMastery(Question question, bool mastered) async {
    setState(() {
      _localIsMastered = mastered;
    });

    try {
      final studyRepo = ref.read(studyRepositoryProvider);
      final progressRepo = ref.read(progressRepositoryProvider);
      const userId = "current_user"; // match the app's structure

      if (mastered) {
        await studyRepo.saveProgress(userId, 1, 0);
      } else {
        await studyRepo.saveProgress(userId, 0, 1);
      }

      await progressRepo.saveSingleProgress(
        QuestionProgressCompanion(
          userId: drift.Value(userId),
          questionId: drift.Value(question.id.toString()),
          isCorrect: drift.Value(mastered),
        ),
      );
    } catch (e) {
      // Rollback on error
      setState(() {
        _localIsMastered = !mastered;
      });
      debugPrint("Error saving trivia progress: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncQuestion = ref.watch(randomQuestionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Trivia"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: asyncQuestion.when(
            data: (data) {
              // Reset local state if question changed
              if (_currentQuestionId != data.question.id) {
                _currentQuestionId = data.question.id;
                _localIsMastered = data.isMastered;
              }

              return SingleChildScrollView(
                child: Flashcard(
                  question: data.question,
                  isMastered: _localIsMastered ?? data.isMastered,
                  onAnswerRevealed: (val) {
                    _toggleMastery(data.question, val);
                  },
                ),
              );
            },
            error: (err, stack) => Center(child: Text('Error: $err')),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _currentQuestionId = null;
          _localIsMastered = null;
          ref.invalidate(randomQuestionProvider);
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
