class CategoryProgress {
  final String name;
  final int totalQuestions;
  final int completedQuestions;

  double get progress => totalQuestions > 0 ? completedQuestions / totalQuestions : 0.0;

  const CategoryProgress({
    required this.name,
    required this.totalQuestions,
    required this.completedQuestions,
  });
}
