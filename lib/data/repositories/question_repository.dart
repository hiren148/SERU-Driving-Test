import 'package:driving_test/data/source/local/local_datasource.dart';
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
  final LocalDatasource localDatasource;

  QuestionDefaultRepository(this.networkDataSource, this.localDatasource);

  @override
  Future<List<Chapter>> getChapterList() async {
    if (await localDatasource.hasData()) {
      return localDatasource.getChapterList();
    }
    final networkChapters = await networkDataSource.getChapterList();
    final chapterList = networkChapters.map((e) => e.toEntity()).toList();
    localDatasource.saveChapterList(chapterList);
    return chapterList;
  }

  @override
  Future<List<Question>> getQuestionsByChapter(Chapter chapter) async {
    if (await localDatasource.hasData()) {
      return localDatasource.getQuestionsByChapter(chapter);
    }
    final networkQuestions = await networkDataSource.getQuestionData(chapter);
    final questionList = networkQuestions.map((e) => e.toEntity()).toList();
    localDatasource.saveQuestionsByChapter(chapter, questionList);
    return questionList;
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
