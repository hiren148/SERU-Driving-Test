import 'package:driving_test/config/colors.dart';
import 'package:driving_test/config/constants.dart';
import 'package:driving_test/domain/entities/chapter.dart';
import 'package:driving_test/domain/entities/question.dart';
import 'package:driving_test/routes.dart';
import 'package:driving_test/state/chapters/chapter_selector.dart';
import 'package:driving_test/state/learn/learn_bloc.dart';
import 'package:driving_test/state/learn/learn_event.dart';
import 'package:driving_test/ui/widgets/illustration_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({Key? key}) : super(key: key);

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  LearnBloc get learnBloc => context.read<LearnBloc>();

  @override
  Widget build(BuildContext context) {
    return ChapterListSelector(
      (chapterMap) => ListView.builder(
        itemCount: 1 + chapterMap.length,
        itemBuilder: ((_, index) => index == 0
            ? const IllustrationCardView()
            : _buildChapterWidget(
                chapterMap,
                index,
              )),
      ),
    );
  }

  void _onPressedTheory(Chapter chapter) {
    learnBloc.add(LoadTheory(chapter: chapter));
    AppNavigator.push(
      Routes.theory,
    );
  }

  void _onPressMCQ(Chapter chapter, List<Question> questions) {
    final List<Question> mcq = questions
        .where((element) =>
            AppConstants.questionnaireTypeFillBlanks != element.type)
        .toList();
    if (mcq.isNotEmpty) {
      learnBloc.add(LoadQuestions(chapter: chapter, questions: mcq));
      AppNavigator.push(
        Routes.learnQuestionnaire,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'No questions available!',
          ),
        ),
      );
    }
  }

  void _onPressFillBlank(Chapter chapter, List<Question> questions) {
    final List<Question> fillBlanks = questions
        .where((element) =>
            AppConstants.questionnaireTypeFillBlanks == element.type)
        .toList();
    if (fillBlanks.isNotEmpty) {
      learnBloc.add(LoadQuestions(chapter: chapter, questions: fillBlanks));
      AppNavigator.push(
        Routes.learnQuestionnaire,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'No questions available!',
          ),
        ),
      );
    }
  }

  Widget _buildChapterWidget(
      Map<Chapter, List<Question>> chapterMap, int index) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        bottom: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            color: AppColors.matisse,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$index. ${chapterMap.keys.elementAt(index - 1).name}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    '${chapterMap.values.elementAt(index - 1).length} questions',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
            ),
            child: GestureDetector(
              onTap: () {
                _onPressedTheory(
                  chapterMap.keys.elementAt(index - 1),
                );
              },
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: const <Widget>[
                      Expanded(
                        child: Text(
                          'Theory',
                          style: TextStyle(
                            color: AppColors.matisse,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: AppColors.matisse,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
            ),
            child: GestureDetector(
              onTap: () {
                _onPressMCQ(chapterMap.keys.elementAt(index - 1),
                    chapterMap.values.elementAt(index - 1));
              },
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: const <Widget>[
                      Expanded(
                        child: Text(
                          'MCQ',
                          style: TextStyle(
                            color: AppColors.matisse,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: AppColors.matisse,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
            ),
            child: GestureDetector(
              onTap: () {
                _onPressFillBlank(chapterMap.keys.elementAt(index - 1),
                    chapterMap.values.elementAt(index - 1));
              },
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: const <Widget>[
                      Expanded(
                        child: Text(
                          'Fill Blanks',
                          style: TextStyle(
                            color: AppColors.matisse,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: AppColors.matisse,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
