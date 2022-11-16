import 'package:driving_test/domain/entities/chapter.dart';
import 'package:driving_test/domain/entities/fill_blanks_part.dart';
import 'package:driving_test/domain/entities/option.dart';
import 'package:driving_test/domain/entities/question.dart';
import 'package:driving_test/domain/entities/theory_part.dart';
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
    extends LearnStateSelector<List<FillBlanksPart>> {
  FillBlanksPartListSelector(Widget Function(List<FillBlanksPart>) builder)
      : super(
          selector: (state) => state.getSelectedQuestionParts(),
          builder: builder,
        );
}

class FlagFirstOrLastQuestionSelector
    extends LearnStateSelector<FlagFirstOrLastQuestionSelectorState> {
  FlagFirstOrLastQuestionSelector(Widget Function(bool, bool) builder)
      : super(
          selector: (state) =>
              FlagFirstOrLastQuestionSelectorState(state.isFirst, state.isLast),
          builder: (value) => builder(value.isFirst, value.isLast),
        );
}

class FlagFirstOrLastQuestionSelectorState {
  final bool isFirst;
  final bool isLast;

  const FlagFirstOrLastQuestionSelectorState(
    this.isFirst,
    this.isLast,
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
