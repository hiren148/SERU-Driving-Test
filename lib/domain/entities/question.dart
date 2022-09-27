import 'package:driving_test/domain/entities/option.dart';

class Question {
  final int id;
  final String question;
  final String type;
  final int noOfAnswers;
  final List<Option> options;

  Question({
    required this.id,
    required this.question,
    required this.type,
    required this.noOfAnswers,
    required this.options,
  });
}
