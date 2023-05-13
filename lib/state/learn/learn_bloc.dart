import 'package:driving_test/config/constants.dart';
import 'package:driving_test/state/exam/exam_state.dart';
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
    
    on<OptionSelected>(
      _onOptionSelect,
    );

    on<SubmitClicked>(
      _onClickSubmit,
    );
    
    on<BlankSelected>(
      _onBlankSelected,
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
    emit(state.asLoadTheory(event.chapter, event.theoryParts));
  }
  
  void _onOptionSelect(OptionSelected event, Emitter<LearnState> emit) {
    if (state.questionStatus == QuestionStatusState.initial) {
      if (state.isFillBlankType) {
        if (state.fillBlankSelectedOption == null &&
            !state.selectedFillBlankOptions.keys.contains(event.option)) {
          emit(state.asFillBlankOptionSelected(event.option));
        }
      } else if (!state.selectedOptions.contains(event.option)) {
        var options = List.of(state.selectedOptions);
        options.add(event.option);
        emit(state.asOptionSelected(options));
      }
    }
  }
  
  void _onClickSubmit(SubmitClicked event, Emitter<LearnState> emit) {
    // var answerMap = Map.of(state.selectedAnswerMap);
    // answerMap[state.selectedQuestion] = state.selectedOptions;
    emit(state.asSubmitClicked());
  }
  
  void _onBlankSelected(BlankSelected event, Emitter<LearnState> emit) {
    if (state.questionStatus == QuestionStatusState.initial &&
        state.isFillBlankType) {
      if (state.fillBlankSelectedOption == null ||
          state.selectedFillBlankOptions.values.contains(event.mappedOption)) {
        return;
      }
      var optionMap = Map.of(state.selectedFillBlankOptions);
      optionMap[state.fillBlankSelectedOption!] = event.mappedOption;
      emit(state.asFillBlankSelected(optionMap));
    }
  }
}
