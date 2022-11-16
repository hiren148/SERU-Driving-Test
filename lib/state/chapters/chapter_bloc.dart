import 'package:driving_test/data/repositories/question_repository.dart';
import 'package:driving_test/domain/entities/chapter.dart';
import 'package:driving_test/domain/entities/question.dart';
import 'package:driving_test/domain/entities/theory_part.dart';
import 'package:driving_test/state/chapters/chapter_event.dart';
import 'package:driving_test/state/chapters/chapter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:stream_transform/stream_transform.dart';

class ChapterBloc extends Bloc<ChapterEvent, ChapterState> {
  final QuestionRepository _questionRepository;

  ChapterBloc(this._questionRepository) : super(const ChapterState.initial()) {
    on<ChapterLoadStarted>(
      _onChapterLoadStarted,
      transformer: (events, mapper) => events.switchMap(mapper),
    );

    on<ReviewLoadStarted>(
      _onReviewLoadStarted,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
  }

  void _onChapterLoadStarted(
      ChapterLoadStarted event, Emitter<ChapterState> emit) async {
    try {
      if (ChapterStateStatus.loading == state.chapterStatus ||
          ChapterStateStatus.loadSuccess == state.chapterStatus) {
        return;
      }

      emit(state.asChapterLoading());
      final List<Chapter> response = await _questionRepository.getChapterList();
      final Map<Chapter, List<Question>> chapterMap = {};
      final Map<Chapter, List<TheoryPart>> theoryMap = {};
      for (var element in response) {
        chapterMap[element] =
            await _questionRepository.getQuestionsByChapter(element);
        theoryMap[element] =
            await _questionRepository.getTheoryByChapter(element);
      }
      emit(state.asChapterLoadSuccess(response, chapterMap, theoryMap));
    } on Exception catch (e) {
      emit(state.asChapterLoadFailure(e));
    }
  }

  void _onReviewLoadStarted(
      ReviewLoadStarted event, Emitter<ChapterState> emit) async {
    try {
      if (ReviewStateStatus.loading == state.reviewStatus ||
          ReviewStateStatus.loadSuccess == state.reviewStatus) {
        return;
      }

      emit(state.asReviewLoading());
      final List<String> reviewList = await _questionRepository.getReviewList();
      emit(state.asReviewLoadSuccess(reviewList));
    } on Exception catch (e) {
      emit(state.asReviewLoadFailure(e));
    }
  }
}
