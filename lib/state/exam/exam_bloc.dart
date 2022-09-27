import 'package:driving_test/state/exam/exam_event.dart';
import 'package:driving_test/state/exam/exam_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamBloc extends Bloc<ExamEvent, ExamState> {
  ExamBloc() : super(const ExamState.initial()) {
    on<LoadQuestions>(
      _onLoadQuestions,
    );

    on<OptionSelected>(
      _onOptionSelect,
    );

    on<SubmitClicked>(
      _onClickSubmit,
    );

    on<NextClicked>(
      _onClickNext,
    );

    on<BlankSelected>(
      _onBlankSelected,
    );
  }

  void _onLoadQuestions(LoadQuestions event, Emitter<ExamState> emit) {
    emit(state.asLoadSuccess(event.questions));
  }

  void _onOptionSelect(OptionSelected event, Emitter<ExamState> emit) {
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

  void _onClickSubmit(SubmitClicked event, Emitter<ExamState> emit) {
    var answerMap = Map.of(state.selectedAnswerMap);
    answerMap[state.selectedQuestion] = state.selectedOptions;
    emit(state.asSubmitClicked(answerMap));
  }

  void _onClickNext(NextClicked event, Emitter<ExamState> emit) {
    if (state.selectedQuestionIndex < (state.questions.length - 1)) {
      emit(state.asNextClicked(state.selectedQuestionIndex + 1));
    }
  }

  void _onBlankSelected(BlankSelected event, Emitter<ExamState> emit) {
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
