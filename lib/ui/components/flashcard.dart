import 'package:flutter/material.dart';
import '../../data/model/question.dart';

class Flashcard extends StatefulWidget {
  final Question question;
  final bool isMastered;
  final ValueChanged<bool> onAnswerRevealed;

  const Flashcard({
    super.key,
    required this.question,
    required this.isMastered,
    required this.onAnswerRevealed,
  });

  @override
  State<Flashcard> createState() => _FlashcardState();
}

class _FlashcardState extends State<Flashcard> {
  bool _isAnswerVisible = false;

  @override
  void didUpdateWidget(covariant Flashcard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question.id != widget.question.id) {
      _isAnswerVisible = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(24),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Question ${widget.question.id}",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              widget.question.text,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            if (!_isAnswerVisible)
              FilledButton(
                onPressed: () => setState(() => _isAnswerVisible = true),
                child: const Text("Show Answer"),
              )
            else ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      "ANSWER",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSecondaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.question.answer,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSecondaryContainer,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Mark as Mastered Toggle
              OutlinedButton.icon(
                onPressed: () {
                  widget.onAnswerRevealed(!widget.isMastered);
                },
                icon: Icon(
                  widget.isMastered ? Icons.check_circle : Icons.circle_outlined,
                  color: widget.isMastered ? Colors.green : null,
                ),
                label: Text(widget.isMastered ? "Mastered" : "Mark as Mastered"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: widget.isMastered ? Colors.green : null,
                  side: widget.isMastered ? const BorderSide(color: Colors.green) : null,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
