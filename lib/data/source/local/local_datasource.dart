import 'package:driving_test/domain/entities/chapter.dart';
import 'package:driving_test/domain/entities/question.dart';

class LocalDatasource {
  final List<Chapter> _chapterList;
  final Map<Chapter, List<Question>> _chapterMap;

  LocalDatasource(this._chapterList, this._chapterMap);

  Future<bool> hasData() async {
    return _chapterList.isNotEmpty &&
        _chapterList.length == _chapterMap.keys.length;
  }

  Future<List<Chapter>> getChapterList() async {
    return _chapterList;
  }

  Future<List<Question>> getQuestionsByChapter(Chapter chapter) async {
    return _chapterMap[chapter] ?? [];
  }

  Future<void> saveChapterList(List<Chapter> chapterList) async {
    _chapterList.addAll(chapterList);
  }

  Future<void> saveQuestionsByChapter(
      Chapter chapter, List<Question> questionList) async {
    _chapterMap[chapter] = questionList;
  }
}
