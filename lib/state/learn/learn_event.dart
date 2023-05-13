import 'package:driving_test/domain/entities/chapter.dart';
import 'package:driving_test/domain/entities/option.dart';
import 'package:driving_test/domain/entities/question.dart';
import 'package:driving_test/domain/entities/theory_part.dart';

abstract class LearnEvent {
  const LearnEvent();
}

class LoadQuestions extends LearnEvent {
  final Chapter chapter;
  final List<Question> questions;

  LoadQuestions({
    required this.chapter,
    required this.questions,
  });
}

class LoadTheory extends LearnEvent {
  final Chapter chapter;
  final List<TheoryPart> theoryParts;

  LoadTheory({
    required this.chapter,
    required this.theoryParts,
  });
}

class NextClicked extends LearnEvent {}

class PrevClicked extends LearnEvent {}

class SubmitClicked extends LearnEvent {}

class OptionSelected extends LearnEvent {
  final Option option;

  OptionSelected(this.option);
}

class BlankSelected extends LearnEvent {
  final Option mappedOption;

  BlankSelected({required this.mappedOption});
}
