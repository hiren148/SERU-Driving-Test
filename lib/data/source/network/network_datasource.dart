import 'dart:convert';

import 'package:driving_test/core/network.dart';
import 'package:driving_test/data/source/network/models/chapter.dart';
import 'package:driving_test/data/source/network/models/question.dart';
import 'package:driving_test/domain/entities/chapter.dart';

class NetworkDataSource {
  final NetworkManager networkManager;

  NetworkDataSource(this.networkManager);

  static const String chaptersURL =
      "https://gist.githubusercontent.com/hiren148/986612d5fceaf1f447c57e9f1cc00754/raw/042e409a8905959ecb7470fdac42178f941e5875/chapters.json";

  static const String reviewURL =
      "https://gist.githubusercontent.com/hiren148/386acfb5043cbec514db73ad11fce746/raw/708dbea1429351580a2cd918cc34ef0a59e0c3d4/review.json";

  Future<List<NetworkQuestionModel>> getQuestionData(Chapter chapter) async {
    final response =
        await networkManager.request(RequestMethod.get, chapter.url);
    final Map<String, dynamic> questionsMap = json.decode(response.data);
    return (questionsMap['questions'] as List)
        .map((item) => NetworkQuestionModel.fromJson(item))
        .toList();
  }

  Future<List<NetworkChapterModel>> getChapterList() async {
    final response =
        await networkManager.request(RequestMethod.get, chaptersURL);
    final Map<String, dynamic> chapterMap = json.decode(response.data);
    return (chapterMap['chapters'] as List)
        .map((item) => NetworkChapterModel.fromJson(item))
        .toList();
  }

  Future<List<String>> getReviewList() async {
    final response = await networkManager.request(RequestMethod.get, reviewURL);
    final Map<String, dynamic> reviewMap = json.decode(response.data);
    return (reviewMap['reviews'] as List).map((e) => e as String).toList();
  }
}
