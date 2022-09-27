import 'package:driving_test/data/repositories/question_repository.dart';
import 'package:driving_test/domain/entities/chapter.dart';
import 'package:driving_test/domain/entities/question.dart';
import 'package:driving_test/state/chapters/chapter_event.dart';
import 'package:driving_test/state/chapters/chapter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:stream_transform/stream_transform.dart';

class ChapterBloc extends Bloc<ChapterEvent, ChapterState> {
  final QuestionRepository _questionRepository;

  ChapterBloc(this._questionRepository) : super(const ChapterState.initial()) {
    on<LoadStarted>(
      _onLoadStarted,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
  }

  void _onLoadStarted(LoadStarted event, Emitter<ChapterState> emit) async {
    try {
      emit(state.asLoading());
      final List<Chapter> response = await _questionRepository.getChapterList();
      final Map<Chapter, List<Question>> chapterMap = {};
      for (var element in response) {
        chapterMap[element] =
            await _questionRepository.getQuestionsByChapter(element);
        element.theoryFile = await DefaultCacheManager().getSingleFile(element.theory);
      }
      final List<String> reviewList = await _questionRepository.getReviewList();
      emit(state.asLoadSuccess(response, chapterMap, reviewList));
    } on Exception catch (e) {
      emit(state.asLoadFailure(e));
    }
  }
}
