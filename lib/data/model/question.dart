import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable()
class Question {
  final int id;
  final String category;
  final String text;
  final String answer;
  final bool isDynamic;

  Question({
    required this.id,
    required this.category,
    required this.text,
    required this.answer,
    this.isDynamic = false,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
