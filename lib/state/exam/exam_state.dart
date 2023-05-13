import 'package:driving_test/config/constants.dart';
import 'package:driving_test/domain/entities/fill_blanks_part.dart';
import 'package:driving_test/domain/entities/option.dart';
import 'package:driving_test/domain/entities/question.dart';

enum QuestionStatusState {
  initial,
  selected,
  submitted,
}

enum ExamStatusState {
  initial,
  loading,
  loadSuccess,
  loadFailure,
}

class ExamState {
  final QuestionStatusState questionStatus;
  final ExamStatusState examStatus;
  final List<Question> questions;
  final int selectedQuestionIndex;
  final Map<Question, List<Option>> selectedAnswerMap;
  final Map<Question, Map<Option, Option>> selectedFillBlankAnswerMap;
  final List<Option> selectedOptions;
  final Map<Option, Option> selectedFillBlankOptions;
  final Option? fillBlankSelectedOption;

  Question get selectedQuestion => questions[selectedQuestionIndex];

  bool get isLast => selectedQuestionIndex == (questions.length - 1);

  bool get isFillBlankType =>
      AppConstants.questionnaireTypeFillBlanks == selectedQuestion.type;

  const ExamState._({
    this.questionStatus = QuestionStatusState.initial,
    this.examStatus = ExamStatusState.initial,
    this.questions = const [],
    this.selectedQuestionIndex = 0,
    this.selectedAnswerMap = const {},
    this.selectedFillBlankAnswerMap = const {},
    this.selectedOptions = const [],
    this.selectedFillBlankOptions = const {},
    this.fillBlankSelectedOption,
  });

  const ExamState.initial() : this._();

  ExamState copyWith({
    QuestionStatusState? questionStatus,
    ExamStatusState? examStatusState,
    List<Question>? questions,
    int? selectedQuestionIndex,
    Map<Question, List<Option>>? selectedAnswerMap,
    Map<Question, Map<Option, Option>>? selectedFillBlankAnswerMap,
    List<Option>? selectedOptions,
    Map<Option, Option>? selectedFillBlankOptions,
    Option? fillBlankSelectedOption,
  }) {
    return ExamState._(
      questionStatus: questionStatus ?? this.questionStatus,
      examStatus: examStatusState ?? examStatus,
      questions: questions ?? this.questions,
      selectedQuestionIndex:
          selectedQuestionIndex ?? this.selectedQuestionIndex,
      selectedAnswerMap: selectedAnswerMap ?? this.selectedAnswerMap,
      selectedFillBlankAnswerMap:
          selectedFillBlankAnswerMap ?? this.selectedFillBlankAnswerMap,
      selectedOptions: selectedOptions ?? this.selectedOptions,
      selectedFillBlankOptions:
          selectedFillBlankOptions ?? this.selectedFillBlankOptions,
      fillBlankSelectedOption: fillBlankSelectedOption,
    );
  }

  ExamState asExamLoading() {
    return copyWith(
      questionStatus: QuestionStatusState.initial,
      questions: const [],
      selectedQuestionIndex: 0,
      selectedAnswerMap: const {},
      selectedFillBlankAnswerMap: const {},
      selectedOptions: const [],
      selectedFillBlankOptions: const {},
      fillBlankSelectedOption: null,
      examStatusState: ExamStatusState.loading,
    );
  }

  ExamState asExamLoadFailure(Exception error) {
    return copyWith(
      examStatusState: ExamStatusState.loadFailure,
    );
  }

  ExamState asLoadSuccess(List<Question> questions) {
    return copyWith(
      questions: questions,
      selectedQuestionIndex: 0,
      questionStatus: QuestionStatusState.initial,
      examStatusState: ExamStatusState.loadSuccess,
      selectedOptions: [],
      selectedFillBlankOptions: {},
      selectedAnswerMap: {},
      selectedFillBlankAnswerMap: {},
      fillBlankSelectedOption: null,
    );
  }

  ExamState asOptionSelected(List<Option> options) {
    return copyWith(
      selectedOptions: options,
      questionStatus: options.length == selectedQuestion.noOfAnswers
          ? QuestionStatusState.selected
          : QuestionStatusState.initial,
    );
  }

  ExamState asFillBlankOptionSelected(Option option) {
    return copyWith(
      fillBlankSelectedOption: option,
    );
  }

  ExamState asFillBlankSelected(Map<Option, Option> selectedFillBlankOptions) {
    return copyWith(
      selectedFillBlankOptions: selectedFillBlankOptions,
      fillBlankSelectedOption: null,
      questionStatus:
          selectedFillBlankOptions.length == selectedQuestion.noOfAnswers
              ? QuestionStatusState.selected
              : QuestionStatusState.initial,
    );
  }

  ExamState asSubmitClicked(Map<Question, List<Option>> selectedAnswerMap) {
    return copyWith(
      selectedAnswerMap: selectedAnswerMap,
      questionStatus: QuestionStatusState.submitted,
    );
  }

  ExamState asSubmitFillBlankClicked(
      Map<Question, Map<Option, Option>> selectedFillBlankAnswerMap) {
    return copyWith(
      selectedFillBlankAnswerMap: selectedFillBlankAnswerMap,
      questionStatus: QuestionStatusState.submitted,
    );
  }

  ExamState asNextClicked(int selectedQuestionIndex) {
    return copyWith(
      questionStatus: QuestionStatusState.initial,
      selectedQuestionIndex: selectedQuestionIndex,
      selectedOptions: [],
      selectedFillBlankOptions: {},
      fillBlankSelectedOption: null,
    );
  }

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
        content: '          ',
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

  int getResultScore() {
    var score = 0;
    for (var key in selectedAnswerMap.keys) {
      if (selectedAnswerMap[key]?.every((element) => element.isAnswer) ??
          false) {
        score++;
      }
    }
    for (var question in selectedFillBlankAnswerMap.keys) {
      Map<Option, Option>? optionMap = selectedFillBlankAnswerMap[question];
      if (optionMap != null) {
        for (var option in optionMap.keys) {
          if (option.id == optionMap[option]?.id && option.isAnswer) {
            score++;
          }
        }
      }
    }
    return score;
  }
}
