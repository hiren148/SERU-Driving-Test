import 'package:driving_test/domain/entities/chapter.dart';
import 'package:driving_test/domain/entities/question.dart';
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
    selector: (state) => state.status,
    builder: builder,
  );
}

class ChapterListSelector
    extends ChapterStateSelector<Map<Chapter, List<Question>>> {
  ChapterListSelector(Widget Function(Map<Chapter, List<Question>>) builder)
      : super(
    selector: (state) => state.chapterMap,
    builder: builder,
  );
}

class CreateExamSelector extends ChapterStateSelector<List<Question>> {
  CreateExamSelector(int noOfQuestions, Widget Function(List<Question>) builder)
      : super(
    selector: (state) => state.createExam(noOfQuestions),
    builder: builder,
  );
}

class ReviewListSelector extends ChapterStateSelector<List<String>> {
  ReviewListSelector(Widget Function(List<String>) builder) :super(
    selector: (state) => state.getRandomReviews(),
    builder: builder,
  );
}
