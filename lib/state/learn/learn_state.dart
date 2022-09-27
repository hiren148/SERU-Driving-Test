import 'package:driving_test/config/constants.dart';
import 'package:driving_test/domain/entities/chapter.dart';
import 'package:driving_test/domain/entities/fill_blanks_part.dart';
import 'package:driving_test/domain/entities/option.dart';
import 'package:driving_test/domain/entities/question.dart';

class LearnState {
  final Chapter? chapter;
  final List<Question> questions;
  final int selectedQuestionIndex;

  Question get selectedQuestion => questions[selectedQuestionIndex];

  bool get isFirst => selectedQuestionIndex == 0;

  bool get isLast => selectedQuestionIndex == (questions.length - 1);

  List<FillBlanksPart> getSelectedQuestionParts() {
    final fillBlanksParts = <FillBlanksPart>[];
    final matches = RegExp(r'{{[0-9]}}').allMatches(selectedQuestion.question);
    var currentPos = 0;
    for (var value1 in matches) {
      final content =
          selectedQuestion.question.substring(currentPos, value1.start);
      fillBlanksParts.add(FillBlanksPart(
        type: AppConstants.fillBlanksPartQuestion,
        content: content,
      ));

      final encodedBlankId =
          selectedQuestion.question.substring(value1.start, value1.end);
      var blankId = encodedBlankId.replaceAll('{', '');
      blankId = blankId.replaceAll('}', '');
      final Option matchedOption = selectedQuestion.options
          .firstWhere((element) => element.id == int.parse(blankId));
      fillBlanksParts.add(FillBlanksPart(
        type: AppConstants.fillBlanksPartOption,
        content: '  ${matchedOption.option}  ',
        option: matchedOption,
      ));
      currentPos = value1.end;
    }

    if (currentPos < selectedQuestion.question.length) {
      fillBlanksParts.add(FillBlanksPart(
        type: AppConstants.fillBlanksPartQuestion,
        content: selectedQuestion.question.substring(currentPos),
      ));
    }

    return fillBlanksParts;
  }

  const LearnState._({
    this.chapter,
    this.questions = const [],
    this.selectedQuestionIndex = 0,
  });

  const LearnState.initial() : this._();

  LearnState copyWith({
    Chapter? chapter,
    List<Question>? questions,
    int? selectedQuestionIndex,
  }) {
    return LearnState._(
      chapter: chapter ?? this.chapter,
      questions: questions ?? this.questions,
      selectedQuestionIndex:
          selectedQuestionIndex ?? this.selectedQuestionIndex,
    );
  }

  LearnState asLoadSuccess(Chapter chapter, List<Question> questions, int selectedQuestionIndex) {
    return copyWith(
      chapter: chapter,
      questions: questions,
      selectedQuestionIndex: selectedQuestionIndex,
    );
  }

  LearnState asLoadTheory(Chapter chapter){
    return copyWith(
      chapter: chapter,
    );
  }

  LearnState asQuestionChanged(int selectedQuestionIndex) {
    return copyWith(
      selectedQuestionIndex: selectedQuestionIndex,
    );
  }
}
