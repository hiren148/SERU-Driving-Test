import 'package:driving_test/domain/entities/chapter.dart';
import 'package:driving_test/domain/entities/question.dart';
import 'package:driving_test/domain/entities/theory_part.dart';
import 'package:driving_test/state/chapters/chapter_bloc.dart';
import 'package:driving_test/state/chapters/chapter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChapterStateSelector<T>
    extends BlocSelector<ChapterBloc, ChapterState, T> {
  ChapterStateSelector({
    required T Function(ChapterState) selector,
    required Widget Function(T) builder,
  }) : super(
          selector: selector,
          builder: (_, value) => builder(value),
        );
}

class ChapterStateStatusSelector
    extends ChapterStateSelector<ChapterStateStatus> {
  ChapterStateStatusSelector(Widget Function(ChapterStateStatus) builder)
      : super(
          selector: (state) => state.chapterStatus,
          builder: builder,
        );
}

class ReviewStateStatusSelector
    extends ChapterStateSelector<ReviewStateStatus> {
  ReviewStateStatusSelector(Widget Function(ReviewStateStatus) builder)
      : super(
          selector: (state) => state.reviewStatus,
          builder: builder,
        );
}

class ChapterListSelector extends ChapterStateSelector<ChapterMapState> {
  ChapterListSelector(
      Widget Function(
              Map<Chapter, List<Question>>, Map<Chapter, List<TheoryPart>>)
          builder)
      : super(
          selector: (state) => ChapterMapState(
            state.chapterMap,
            state.theoryMap,
          ),
          builder: (value) => builder(
            value.questionMap,
            value.theoryMap,
          ),
        );
}

class ChapterMapState {
  final Map<Chapter, List<Question>> questionMap;
  final Map<Chapter, List<TheoryPart>> theoryMap;

  ChapterMapState(this.questionMap, this.theoryMap);
}

class ReviewListSelector extends ChapterStateSelector<List<String>> {
  ReviewListSelector(Widget Function(List<String>) builder)
      : super(
          selector: (state) => state.getRandomReviews(),
          builder: builder,
        );
}
