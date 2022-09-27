import 'package:driving_test/config/colors.dart';
import 'package:driving_test/config/constants.dart';
import 'package:driving_test/domain/entities/fill_blanks_part.dart';
import 'package:driving_test/domain/entities/question.dart';
import 'package:driving_test/state/learn/learn_bloc.dart';
import 'package:driving_test/state/learn/learn_event.dart';
import 'package:driving_test/state/learn/learn_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LearnQuestionnaireScreen extends StatefulWidget {
  const LearnQuestionnaireScreen({Key? key}) : super(key: key);

  @override
  State<LearnQuestionnaireScreen> createState() =>
      _LearnQuestionnaireScreenState();
}

class _LearnQuestionnaireScreenState extends State<LearnQuestionnaireScreen> {
  LearnBloc get learnBloc => context.read<LearnBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ChapterSelector(
          (chapter) => Text(
            chapter?.name ?? 'Chapter 1',
          ),
        ),
        backgroundColor: AppColors.matisse,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      CurrentQuestionIndexSelector(
                        (index, totalQuestions) => Text(
                          'Q: ${1 + index}/$totalQuestions',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      CurrentQuestionSelector(
                        (question) => _buildQuestionByType(question),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      OptionSelector(
                        (options) => ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: options.length,
                          itemBuilder: (_, index) {
                            final option = options[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: option.isAnswer
                                      ? Colors.green
                                      : Colors.transparent,
                                  width: 2.0,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  option.option,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          FlagFirstOrLastQuestionSelector((isFirst, isLast) => Row(
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  isFirst
                      ? const SizedBox.shrink()
                      : Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              learnBloc.add(PrevClicked());
                            },
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.matisse,
                            ),
                            child: const Text(
                              'Prev',
                            ),
                          ),
                        ),
                  isFirst || isLast
                      ? const SizedBox.shrink()
                      : const SizedBox(
                          width: 16,
                        ),
                  isLast
                      ? const SizedBox.shrink()
                      : Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              learnBloc.add(NextClicked());
                            },
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.matisse,
                            ),
                            child: const Text(
                              'Next',
                            ),
                          ),
                        ),
                  const SizedBox(
                    width: 16,
                  ),
                ],
              )),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionByType(Question question) {
    switch (question.type) {
      case AppConstants.questionnaireTypeFillBlanks:
        return FillBlanksPartListSelector(
          (partList) => RichText(
            text: TextSpan(
              text: '',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: _createSpans(partList),
            ),
          ),
        );
      case AppConstants.questionnaireTypeMultiple:
      case AppConstants.questionnaireTypeSingle:
      default:
        return Text(
          question.question,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        );
    }
  }

  List<TextSpan> _createSpans(List<FillBlanksPart> parts) {
    final spans = <TextSpan>[];
    parts.asMap().forEach(
      (index, value) {
        spans.add(
          TextSpan(
            text: value.content,
            style: TextStyle(
              fontSize: 18,
              decoration: AppConstants.fillBlanksPartOption == value.type
                  ? TextDecoration.underline
                  : TextDecoration.none,
              decorationColor: Colors.black,
              fontWeight: FontWeight.bold,
              color: AppConstants.fillBlanksPartOption == value.type
                  ? AppColors.matisse
                  : Colors.black,
            ),
          ),
        );
      },
    );

    return spans;
  }
}
