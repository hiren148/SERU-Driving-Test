import 'package:driving_test/config/constants.dart';
import 'package:driving_test/data/repositories/question_repository.dart';
import 'package:driving_test/domain/entities/question.dart';
import 'package:driving_test/state/exam/exam_event.dart';
import 'package:driving_test/state/exam/exam_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

class ExamBloc extends Bloc<ExamEvent, ExamState> {
  final QuestionRepository _questionRepository;

  ExamBloc(this._questionRepository) : super(const ExamState.initial()) {
    on<LoadQuestions>(
      _onLoadQuestions,
      transformer: (events, mapper) => events.switchMap(mapper),
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

  void _onLoadQuestions(LoadQuestions event, Emitter<ExamState> emit) async {
    try {
      emit(state.asExamLoading());
      final chapterList = await _questionRepository.getChapterList();
      final questionList = <Question>[];
      for (var element in chapterList) {
        questionList
            .addAll(await _questionRepository.getQuestionsByChapter(element));
      }
      final examQuestions = await _createExam(questionList);
      emit(state.asLoadSuccess(examQuestions));
    } on Exception catch (e) {
      emit(state.asExamLoadFailure(e));
    }
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

  Future<List<Question>> _createExam(List<Question> questionList) async {
    final List<Question> multipleChoice = [];
    final List<Question> fillBlanks = [];
    final List<Question> examQuestions = [];

    for (var element in questionList) {
      if (AppConstants.questionnaireTypeFillBlanks == element.type) {
        fillBlanks.add(element);
      } else {
        multipleChoice.add(element);
      }
    }

    if (fillBlanks.length <= 18) {
      examQuestions.addAll(fillBlanks);
    } else{
      final indices = _generateUniqueIndices(18, fillBlanks.length);
      for (var index in indices) {
        examQuestions.add(fillBlanks.elementAt(index));
      }
    }

    if (multipleChoice.length <= 19) {
      examQuestions.addAll(multipleChoice);
    } else{
      final indices = _generateUniqueIndices(19, multipleChoice.length);
      for (var index in indices) {
        examQuestions.add(multipleChoice.elementAt(index));
      }
    }
    examQuestions.shuffle();
    return examQuestions;
  }

  List<int> _generateUniqueIndices(int noOfRandom, int length) {
    var indexList = List.generate(length, (index) => index);
    indexList.shuffle();
    if (length <= noOfRandom) {
      return indexList;
    }
    return indexList.sublist(0, noOfRandom);
  }
}
