import 'package:driving_test/data/source/network/network_datasource.dart';
import 'package:driving_test/data/source/network_to_entity_mapper.dart';
import 'package:driving_test/domain/entities/chapter.dart';
import 'package:driving_test/domain/entities/question.dart';
import 'package:driving_test/domain/entities/theory_part.dart';

abstract class QuestionRepository {
  Future<List<Question>> getQuestionsByChapter(Chapter chapter);

  Future<List<Chapter>> getChapterList();

  Future<List<String>> getReviewList();

  Future<List<TheoryPart>> getTheoryByChapter(Chapter chapter);
}

class QuestionDefaultRepository extends QuestionRepository {
  final NetworkDataSource networkDataSource;

  QuestionDefaultRepository(this.networkDataSource);

  @override
  Future<List<Chapter>> getChapterList() async {
    final networkChapters = await networkDataSource.getChapterList();
    return networkChapters.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<Question>> getQuestionsByChapter(Chapter chapter) async {
    final networkQuestions = await networkDataSource.getQuestionData(chapter);
    return networkQuestions.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<String>> getReviewList() async {
    return await networkDataSource.getReviewList();
  }

  @override
  Future<List<TheoryPart>> getTheoryByChapter(Chapter chapter) async {
    return await networkDataSource.getTheoryData(chapter);
  }
}
