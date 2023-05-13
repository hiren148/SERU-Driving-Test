import 'package:driving_test/domain/entities/fill_blanks_part.dart';
import 'package:driving_test/domain/entities/option.dart';
import 'package:driving_test/domain/entities/question.dart';
import 'package:driving_test/state/exam/exam_bloc.dart';
import 'package:driving_test/state/exam/exam_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamStateSelector<T> extends BlocSelector<ExamBloc, ExamState, T> {
  ExamStateSelector({
    required T Function(ExamState) selector,
    required Widget Function(T) builder,
  }) : super(
          selector: selector,
          builder: (_, value) => builder(value),
        );
}

class CurrentQuestionSelector extends ExamStateSelector<Question> {
  CurrentQuestionSelector(Widget Function(Question) builder)
      : super(
          selector: (state) => state.selectedQuestion,
          builder: builder,
        );
}

class OptionSelector extends ExamStateSelector<List<Option>> {
  OptionSelector(Widget Function(List<Option>) builder)
      : super(
          selector: (state) => state.selectedQuestion.options,
          builder: builder,
        );
}

class FillBlanksPartListSelector
    extends ExamStateSelector<FillBlanksPartListState> {
  FillBlanksPartListSelector(
      Widget Function(
              List<FillBlanksPart>, Map<Option, Option>, QuestionStatusState)
          builder)
      : super(
          selector: (state) => FillBlanksPartListState(
            state.getSelectedQuestionParts(),
            state.selectedFillBlankOptions,
            state.questionStatus,
          ),
          builder: (value) => builder(
            value.partList,
            value.optionMap,
            value.questionStatus,
          ),
        );
}

class FillBlanksPartListState {
  final List<FillBlanksPart> partList;
  final Map<Option, Option> optionMap;
  final QuestionStatusState questionStatus;

  FillBlanksPartListState(this.partList, this.optionMap, this.questionStatus);
}

class QuestionStatusStateSelector
    extends ExamStateSelector<QuestionStatusState> {
  QuestionStatusStateSelector(Widget Function(QuestionStatusState) builder)
      : super(
          selector: (state) => state.questionStatus,
          builder: builder,
        );
}

class OptionBorderColorStatusStateSelector
    extends ExamStateSelector<OptionBorderColorStatusState> {
  OptionBorderColorStatusStateSelector(
      Widget Function(bool, QuestionStatusState, List<Option>?, Option?,
              Map<Option, Option>?)
          builder)
      : super(
          selector: (state) => OptionBorderColorStatusState(
            state.isFillBlankType,
            state.questionStatus,
            selectedAnswers: state.selectedOptions,
            fillBlankOption: state.fillBlankSelectedOption,
            selectedFillBlankAnswer: state.selectedFillBlankOptions,
          ),
          builder: (value) => builder(
            value.isFillBlank,
            value.questionStatus,
            value.selectedAnswers,
            value.fillBlankOption,
            value.selectedFillBlankAnswer,
          ),
        );
}

class OptionBorderColorStatusState {
  final List<Option>? selectedAnswers;
  final Option? fillBlankOption;
  final bool isFillBlank;
  final Map<Option, Option>? selectedFillBlankAnswer;
  final QuestionStatusState questionStatus;

  OptionBorderColorStatusState(
    this.isFillBlank,
    this.questionStatus, {
    this.selectedAnswers,
    this.fillBlankOption,
    this.selectedFillBlankAnswer,
  });
}

class FlagLastQuestionSelector extends ExamStateSelector<bool> {
  FlagLastQuestionSelector(Widget Function(bool) builder)
      : super(
          selector: (state) => state.isLast,
          builder: builder,
        );
}

class ExamResultStateSelector extends ExamStateSelector<ExamResultState> {
  ExamResultStateSelector(Widget Function(int, int) builder)
      : super(
          selector: (state) =>
              ExamResultState(state.questions.length, state.getResultScore()),
          builder: (value) =>
              builder(value.noOfQuestions, value.noOfCorrectAnswer),
        );
}

class ExamResultState {
  final int noOfQuestions;
  final int noOfCorrectAnswer;

  ExamResultState(this.noOfQuestions, this.noOfCorrectAnswer);
}

class CurrentQuestionIndexSelector
    extends ExamStateSelector<QuestionIndexSelectorState> {
  CurrentQuestionIndexSelector(Widget Function(int, int) builder)
      : super(
          selector: (state) => QuestionIndexSelectorState(
              state.selectedQuestionIndex, state.questions.length),
          builder: (value) => builder(value.currentIndex, value.totalQuestion),
        );
}

class QuestionIndexSelectorState {
  final int currentIndex;
  final int totalQuestion;

  const QuestionIndexSelectorState(this.currentIndex, this.totalQuestion);
}

class ExamStateStatusSelector
    extends ExamStateSelector<ExamStatusState> {
  ExamStateStatusSelector(Widget Function(ExamStatusState) builder)
      : super(
          selector: (state) => state.examStatus,
          builder: builder,
        );
}
