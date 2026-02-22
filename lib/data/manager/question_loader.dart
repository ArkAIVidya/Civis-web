import 'dart:convert';
import 'package:flutter/services.dart';
import '../model/question.dart';

import 'package:flutter/foundation.dart';

class QuestionLoader {
  Future<List<Question>> loadQuestions() async {
    try {
      final jsonString = await rootBundle.loadString(
        'assets/civics_questions_data_v2.json',
      );
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => Question.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error loading questions: $e');
      throw Exception('Failed to load questions: $e');
    }
  }
}
