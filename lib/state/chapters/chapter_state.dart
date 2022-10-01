import 'package:driving_test/domain/entities/chapter.dart';
import 'package:driving_test/domain/entities/question.dart';

enum ChapterStateStatus {
  initial,
  loading,
  loadSuccess,
  loadFailure,
}

class ChapterState {
  final ChapterStateStatus status;
  final List<Chapter> chapterList;
  final Map<Chapter, List<Question>> chapterMap;
  final Exception? error;
  final List<String> reviewList;

  const ChapterState._({
    this.status = ChapterStateStatus.initial,
    this.chapterList = const [],
    this.chapterMap = const {},
    this.error,
    this.reviewList = const [],
  });

  const ChapterState.initial() : this._();

  ChapterState copyWith({
    ChapterStateStatus? status,
    List<Chapter>? chapterList,
    Map<Chapter, List<Question>>? chapterMap,
    Exception? error,
    List<String>? reviewList,
  }) {
    return ChapterState._(
      status: status ?? this.status,
      chapterList: chapterList ?? this.chapterList,
      chapterMap: chapterMap ?? this.chapterMap,
      error: error ?? this.error,
      reviewList: reviewList ?? this.reviewList,
    );
  }

  ChapterState asLoading() {
    return copyWith(
      status: ChapterStateStatus.loading,
    );
  }

  ChapterState asLoadSuccess(List<Chapter> chapterList,
      Map<Chapter, List<Question>> chapterMap, List<String> reviewList) {
    return copyWith(
      status: ChapterStateStatus.loadSuccess,
      chapterList: chapterList,
      chapterMap: chapterMap,
      reviewList: reviewList,
    );
  }

  ChapterState asLoadFailure(Exception error) {
    return copyWith(
      status: ChapterStateStatus.loadFailure,
      error: error,
    );
  }

  List<String> getRandomReviews() {
    final List<String> reviews = [];
    final indices = _generateUniqueIndices(5, reviewList.length);
    for (var index in indices) {
      reviews.add(reviewList.elementAt(index));
    }
    return reviews;
  }

  List<Question> createExam(int noOfQuestions) {
    final int eachChapter = (noOfQuestions / chapterList.length).ceil();
    final List<Question> examQuestions = [];
    for (var questionList in chapterMap.values) {
      final indices = _generateUniqueIndices(eachChapter, questionList.length);
      for (var index in indices) {
        examQuestions.add(questionList.elementAt(index));
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
