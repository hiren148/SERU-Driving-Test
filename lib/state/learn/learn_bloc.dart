import 'package:driving_test/config/constants.dart';
import 'package:driving_test/state/learn/learn_event.dart';
import 'package:driving_test/state/learn/learn_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_transform/stream_transform.dart';

class LearnBloc extends Bloc<LearnEvent, LearnState> {
  LearnBloc() : super(const LearnState.initial()) {
    on<LoadQuestions>(
      _onLoadQuestions,
      transformer: (events, mapper) => events.switchMap(mapper),
    );

    on<NextClicked>(
      _onNextClicked,
    );

    on<PrevClicked>(
      _onPrevClicked,
    );

    on<LoadTheory>(
      _onLoadTheory,
    );
  }

  void _onLoadQuestions(LoadQuestions event, Emitter<LearnState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    int? selectedIndex = prefs.getInt(
        'chapter${event.chapter.id}${event.questions.any((element) => AppConstants.questionnaireTypeFillBlanks == element.type)}');
    if (selectedIndex == null ||
        selectedIndex >= (event.questions.length - 1)) {
      selectedIndex = 0;
    }
    emit(state.asLoadSuccess(event.chapter, event.questions, selectedIndex));
  }

  void _onNextClicked(NextClicked event, Emitter<LearnState> emit) async {
    if (state.selectedQuestionIndex < (state.questions.length - 1)) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(
          'chapter${state.chapter?.id}${AppConstants.questionnaireTypeFillBlanks == state.selectedQuestion.type}',
          (state.selectedQuestionIndex + 1));
      emit(state.asQuestionChanged(state.selectedQuestionIndex + 1));
    }
  }

  void _onPrevClicked(PrevClicked event, Emitter<LearnState> emit) async {
    if (state.selectedQuestionIndex > 0) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(
          'chapter${state.chapter?.id}${AppConstants.questionnaireTypeFillBlanks == state.selectedQuestion.type}',
          (state.selectedQuestionIndex - 1));
      emit(state.asQuestionChanged(state.selectedQuestionIndex - 1));
    }
  }

  void _onLoadTheory(LoadTheory event, Emitter<LearnState> emit) {
    emit(state.asLoadTheory(event.chapter));
  }
}
