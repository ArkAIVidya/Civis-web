import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'study_view_model.dart';
import '../../components/flashcard.dart';

class StudyScreen extends ConsumerStatefulWidget {
  final String? category;

  const StudyScreen({super.key, this.category});

  @override
  ConsumerState<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends ConsumerState<StudyScreen> {
  late PageController _pageController;
  bool _initialScrollDone = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    // Defer initial load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(studyViewModelProvider.notifier).loadQuestions(widget.category);
    });
  }

  @override
  void didUpdateWidget(StudyScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.category != oldWidget.category) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(studyViewModelProvider.notifier)
            .loadQuestions(widget.category);
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(studyViewModelProvider);
    final notifier = ref.read(studyViewModelProvider.notifier);

    // Load data on first build or category change
    // Using simple approach: check if empty and not loading, or if category mismatch (but we don't store category in state yet)
    // Better: use LaunchedEffect equivalent
    // Since build is called often, we need to be careful.
    // Let's use a flag or check if questions are empty.
    // Ideally we'd use a provider family, but here we have one singleton VM.
    // We'll trust the VM handles multiple calls or we trigger it once in initState/didUpdateWidget?
    // Provider families are better for this.
    // For now, I'll assume standard provider.

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category ?? "Study Mode"),
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
      body: _buildBody(state, notifier),
    );
  }

  Widget _buildBody(StudyUiState state, StudyViewModel notifier) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Error: ${state.error}",
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => notifier.loadQuestions(widget.category),
              child: const Text("Retry"),
            ),
          ],
        ),
      );
    }

    if (state.questions.isEmpty) {
      // Trigger load if empty? Or show "No Questions".
      // We need to trigger load.
      // In Flutter Riverpod, best to trigger in provider initialization or use FutureProvider family.
      // Since I used Notifier, I need to trigger it.
      // I'll use a post-frame callback or Future.microtask.

      return const Center(child: Text("No questions available."));
    }

    if (!_initialScrollDone && state.initialIndex > 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_pageController.hasClients) {
          _pageController.jumpToPage(state.initialIndex);
          _initialScrollDone = true;
        }
      });
    }

    return Column(
      children: [
        // Progress bar?
        LinearProgressIndicator(
          value: (state.questions.isNotEmpty)
              ? (state.answerStatus.length / state.questions.length)
              : 0.0,
        ),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: state.questions.length,
            itemBuilder: (context, index) {
              final question = state.questions[index];
              final isMastered = state.answerStatus[question.id] ?? false;

              return SingleChildScrollView(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Flashcard(
                      question: question,
                      isMastered: isMastered,
                      onAnswerRevealed: (mastered) {
                        notifier.recordAnswer(question.id, mastered);
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
