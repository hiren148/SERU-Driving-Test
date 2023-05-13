import 'package:driving_test/domain/entities/chapter.dart';
import 'package:driving_test/domain/entities/fill_blanks_part.dart';
import 'package:driving_test/domain/entities/option.dart';
import 'package:driving_test/domain/entities/question.dart';
import 'package:driving_test/domain/entities/theory_part.dart';
import 'package:driving_test/state/exam/exam_state.dart';
import 'package:driving_test/state/learn/learn_bloc.dart';
import 'package:driving_test/state/learn/learn_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LearnStateSelector<T> extends BlocSelector<LearnBloc, LearnState, T> {
  LearnStateSelector({
    required T Function(LearnState) selector,
    required Widget Function(T) builder,
  }) : super(
          selector: selector,
          builder: (_, value) => builder(value),
        );
}

class ChapterSelector extends LearnStateSelector<Chapter?> {
  ChapterSelector(Widget Function(Chapter?) builder)
      : super(
          selector: (state) => state.chapter,
          builder: builder,
        );
}

class CurrentQuestionSelector extends LearnStateSelector<Question> {
  CurrentQuestionSelector(Widget Function(Question) builder)
      : super(
          selector: (state) => state.selectedQuestion,
          builder: builder,
        );
}

class OptionSelector extends LearnStateSelector<List<Option>> {
  OptionSelector(Widget Function(List<Option>) builder)
      : super(
          selector: (state) => state.selectedQuestion.options,
          builder: builder,
        );
}

class FillBlanksPartListSelector
    extends LearnStateSelector<FillBlanksPartListState> {
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

class FlagFirstOrLastQuestionSelector
    extends LearnStateSelector<FlagFirstOrLastQuestionSelectorState> {
  FlagFirstOrLastQuestionSelector(Widget Function(bool, bool, QuestionStatusState) builder)
      : super(
          selector: (state) =>
              FlagFirstOrLastQuestionSelectorState(state.isFirst, state.isLast, state.questionStatus),
          builder: (value) => builder(value.isFirst, value.isLast, value.questionStatusState),
        );
}

class FlagFirstOrLastQuestionSelectorState {
  final bool isFirst;
  final bool isLast;
  final QuestionStatusState questionStatusState;

  const FlagFirstOrLastQuestionSelectorState(
    this.isFirst,
    this.isLast,
    this.questionStatusState,
  );
}

class CurrentQuestionIndexSelector
    extends LearnStateSelector<QuestionIndexSelectorState> {
  CurrentQuestionIndexSelector(Widget Function(int, int) builder)
      : super(
          selector: (state) => QuestionIndexSelectorState(
              state.selectedQuestionIndex, state.questions.length),
          builder: (value) => builder(value.currentIndex, value.totalQuestions),
        );
}

class QuestionIndexSelectorState {
  final int currentIndex;
  final int totalQuestions;

  const QuestionIndexSelectorState(this.currentIndex, this.totalQuestions);
}

class TheoryPartListSelector extends LearnStateSelector<List<TheoryPart>> {
  TheoryPartListSelector(Widget Function(List<TheoryPart>) builder)
      : super(
          selector: (state) => state.theoryParts,
          builder: builder,
        );
}

class OptionBorderColorStatusStateSelector
    extends LearnStateSelector<OptionBorderColorStatusState> {
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
