// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
  id: (json['id'] as num).toInt(),
  category: json['category'] as String,
  text: json['text'] as String,
  answer: json['answer'] as String,
  isDynamic: json['isDynamic'] as bool? ?? false,
);

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
  'id': instance.id,
  'category': instance.category,
  'text': instance.text,
  'answer': instance.answer,
  'isDynamic': instance.isDynamic,
};
