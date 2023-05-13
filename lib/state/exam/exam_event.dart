import 'package:driving_test/domain/entities/option.dart';

abstract class ExamEvent {
  const ExamEvent();
}

class LoadQuestions extends ExamEvent {}

class OptionSelected extends ExamEvent {
  final Option option;

  OptionSelected({required this.option});
}

class BlankSelected extends ExamEvent {
  final Option mappedOption;

  BlankSelected({required this.mappedOption});
}

class SubmitClicked extends ExamEvent {}

class NextClicked extends ExamEvent {}
