import 'package:driving_test/config/constants.dart';
import 'package:driving_test/domain/entities/chapter.dart';
import 'package:driving_test/domain/entities/fill_blanks_part.dart';
import 'package:driving_test/domain/entities/option.dart';
import 'package:driving_test/domain/entities/question.dart';
import 'package:driving_test/domain/entities/theory_part.dart';
import 'package:driving_test/state/exam/exam_state.dart';

class LearnState {
  final QuestionStatusState questionStatus;
  final Chapter? chapter;
  final List<Question> questions;
  final List<TheoryPart> theoryParts;
  final int selectedQuestionIndex;
  final List<Option> selectedOptions;
  final Map<Option, Option> selectedFillBlankOptions;
  final Option? fillBlankSelectedOption;

  Question get selectedQuestion => questions[selectedQuestionIndex];

  bool get isFirst => selectedQuestionIndex == 0;

  bool get isLast => selectedQuestionIndex == (questions.length - 1);

  bool get isFillBlankType =>
      AppConstants.questionnaireTypeFillBlanks == selectedQuestion.type;

  List<FillBlanksPart> getSelectedQuestionParts() {
    final fillBlanksParts = <FillBlanksPart>[];
    final matches = RegExp(r'{{[0-9]}}').allMatches(selectedQuestion.question);
    var currentPos = 0;
    for (var value1 in matches) {
      final content =
          selectedQuestion.question.substring(currentPos, value1.start);
      fillBlanksParts.add(FillBlanksPart(
        type: AppConstants.fillBlanksPartQuestion,
        content: content,
      ));

      final encodedBlankId =
          selectedQuestion.question.substring(value1.start, value1.end);
      var blankId = encodedBlankId.replaceAll('{', '');
      blankId = blankId.replaceAll('}', '');
      final Option matchedOption = selectedQuestion.options
          .firstWhere((element) => element.id == int.parse(blankId));
      fillBlanksParts.add(FillBlanksPart(
        type: AppConstants.fillBlanksPartOption,
        content: '  ${matchedOption.option}  ',
        option: matchedOption,
      ));
      currentPos = value1.end;
    }

    if (currentPos < selectedQuestion.question.length) {
      fillBlanksParts.add(FillBlanksPart(
        type: AppConstants.fillBlanksPartQuestion,
        content: selectedQuestion.question.substring(currentPos),
      ));
    }

    return fillBlanksParts;
  }

  const LearnState._({
    this.questionStatus = QuestionStatusState.initial,
    this.chapter,
    this.questions = const [],
    this.theoryParts = const [],
    this.selectedQuestionIndex = 0,
    this.selectedOptions = const [],
    this.selectedFillBlankOptions = const {},
    this.fillBlankSelectedOption,
  });

  const LearnState.initial() : this._();

  LearnState copyWith({
    QuestionStatusState? questionStatus,
    Chapter? chapter,
    List<Question>? questions,
    List<TheoryPart>? theoryParts,
    int? selectedQuestionIndex,
    List<Option>? selectedOptions,
    Map<Option, Option>? selectedFillBlankOptions,
    Option? fillBlankSelectedOption,
  }) {
    return LearnState._(
      questionStatus: questionStatus ?? this.questionStatus,
      chapter: chapter ?? this.chapter,
      questions: questions ?? this.questions,
      theoryParts: theoryParts ?? this.theoryParts,
      selectedQuestionIndex:
          selectedQuestionIndex ?? this.selectedQuestionIndex,
      selectedOptions: selectedOptions ?? this.selectedOptions,
      selectedFillBlankOptions:
          selectedFillBlankOptions ?? this.selectedFillBlankOptions,
      fillBlankSelectedOption:
          fillBlankSelectedOption ,
    );
  }

  LearnState asLoadSuccess(
      Chapter chapter, List<Question> questions, int selectedQuestionIndex) {
    return copyWith(
      chapter: chapter,
      questions: questions,
      selectedQuestionIndex: selectedQuestionIndex,
    );
  }

  LearnState asLoadTheory(Chapter chapter, List<TheoryPart> theoryParts) {
    return copyWith(
      chapter: chapter,
      theoryParts: theoryParts,
    );
  }

  LearnState asQuestionChanged(int selectedQuestionIndex) {
    return copyWith(
      selectedQuestionIndex: selectedQuestionIndex,
      questionStatus: QuestionStatusState.initial,
      selectedOptions: [],
      selectedFillBlankOptions: {},
      fillBlankSelectedOption: null,
    );
  }

  LearnState asOptionSelected(List<Option> options) {
    return copyWith(
      selectedOptions: options,
      questionStatus: options.length == selectedQuestion.noOfAnswers
          ? QuestionStatusState.selected
          : QuestionStatusState.initial,
    );
  }

  LearnState asSubmitClicked() {
    return copyWith(
      questionStatus: QuestionStatusState.submitted,
    );
  }

  LearnState asFillBlankOptionSelected(Option option) {
    return copyWith(
      fillBlankSelectedOption: option,
    );
  }

  LearnState asFillBlankSelected(Map<Option, Option> selectedFillBlankOptions) {
    return copyWith(
      selectedFillBlankOptions: selectedFillBlankOptions,
      fillBlankSelectedOption: null,
      questionStatus:
          selectedFillBlankOptions.length == selectedQuestion.noOfAnswers
              ? QuestionStatusState.selected
              : QuestionStatusState.initial,
    );
  }
}
