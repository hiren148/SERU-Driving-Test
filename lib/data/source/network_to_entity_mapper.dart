import 'package:driving_test/data/source/network/models/chapter.dart';
import 'package:driving_test/data/source/network/models/question.dart';
import 'package:driving_test/data/source/network/models/question_option.dart';
import 'package:driving_test/domain/entities/chapter.dart';
import 'package:driving_test/domain/entities/option.dart';
import 'package:driving_test/domain/entities/question.dart';

extension QuestionModelX on NetworkQuestionModel {
  Question toEntity() {
    options.shuffle();
    return Question(
      id: id,
      question: question,
      type: type,
      noOfAnswers: noOfAnswer,
      options: options.map((e) => e.toEntity()).toList(),
    );
  }
}

extension QuestionOptionModelX on NetworkQuestionOptionModel {
  Option toEntity() => Option(
        id: id,
        option: option,
        isAnswer: isAnswer,
      );
}

extension ChapterModelX on NetworkChapterModel {
  Chapter toEntity() => Chapter(
        id: id,
        name: name,
        url: url,
        theory: theory,
      );
}
