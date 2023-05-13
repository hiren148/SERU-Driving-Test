import 'package:driving_test/domain/entities/chapter.dart';
import 'package:driving_test/domain/entities/question.dart';
import 'package:driving_test/domain/entities/theory_part.dart';

enum ChapterStateStatus {
  initial,
  loading,
  loadSuccess,
  loadFailure,
}

enum ReviewStateStatus {
  initial,
  loading,
  loadSuccess,
  loadFailure,
}

class ChapterState {
  final ChapterStateStatus chapterStatus;
  final ReviewStateStatus reviewStatus;
  final List<Chapter> chapterList;
  final Map<Chapter, List<Question>> chapterMap;
  final Map<Chapter, List<TheoryPart>> theoryMap;
  final Exception? error;
  final List<String> reviewList;

  const ChapterState._({
    this.chapterStatus = ChapterStateStatus.initial,
    this.reviewStatus = ReviewStateStatus.initial,
    this.chapterList = const [],
    this.chapterMap = const {},
    this.theoryMap = const {},
    this.error,
    this.reviewList = const [],
  });

  const ChapterState.initial() : this._();

  ChapterState copyWith({
    ChapterStateStatus? chapterStatus,
    ReviewStateStatus? reviewStatus,
    List<Chapter>? chapterList,
    Map<Chapter, List<Question>>? chapterMap,
    Map<Chapter, List<TheoryPart>>? theoryMap,
    Exception? error,
    List<String>? reviewList,
  }) {
    return ChapterState._(
      chapterStatus: chapterStatus ?? this.chapterStatus,
      reviewStatus: reviewStatus ?? this.reviewStatus,
      chapterList: chapterList ?? this.chapterList,
      chapterMap: chapterMap ?? this.chapterMap,
      theoryMap: theoryMap ?? this.theoryMap,
      error: error ?? this.error,
      reviewList: reviewList ?? this.reviewList,
    );
  }

  ChapterState asChapterLoading() {
    return copyWith(
      chapterStatus: ChapterStateStatus.loading,
    );
  }

  ChapterState asReviewLoading() {
    return copyWith(
      reviewStatus: ReviewStateStatus.loading,
    );
  }

  ChapterState asChapterLoadSuccess(
    List<Chapter> chapterList,
    Map<Chapter, List<Question>> chapterMap,
    Map<Chapter, List<TheoryPart>> theoryMap,
  ) {
    return copyWith(
      chapterStatus: ChapterStateStatus.loadSuccess,
      chapterList: chapterList,
      chapterMap: chapterMap,
      theoryMap: theoryMap,
    );
  }

  ChapterState asReviewLoadSuccess(List<String> reviewList) {
    return copyWith(
      reviewStatus: ReviewStateStatus.loadSuccess,
      reviewList: reviewList,
    );
  }

  ChapterState asChapterLoadFailure(Exception error) {
    return copyWith(
      chapterStatus: ChapterStateStatus.loadFailure,
      error: error,
    );
  }

  ChapterState asReviewLoadFailure(Exception error) {
    return copyWith(
      reviewStatus: ReviewStateStatus.loadFailure,
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



  List<int> _generateUniqueIndices(int noOfRandom, int length) {
    var indexList = List.generate(length, (index) => index);
    indexList.shuffle();
    if (length <= noOfRandom) {
      return indexList;
    }
    return indexList.sublist(0, noOfRandom);
  }
}
