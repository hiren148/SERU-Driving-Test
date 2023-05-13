import 'package:driving_test/config/colors.dart';
import 'package:driving_test/config/constants.dart';
import 'package:driving_test/domain/entities/fill_blanks_part.dart';
import 'package:driving_test/domain/entities/option.dart';
import 'package:driving_test/domain/entities/question.dart';
import 'package:driving_test/state/exam/exam_state.dart';
import 'package:driving_test/state/learn/learn_bloc.dart';
import 'package:driving_test/state/learn/learn_event.dart';
import 'package:driving_test/state/learn/learn_selector.dart';
import 'package:flutter/gestures.dart';
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
                            return GestureDetector(
                              onTap: () =>
                                  learnBloc.add(OptionSelected(option)),
                              child: OptionBorderColorStatusStateSelector(
                                (isFillBlank,
                                        questionStatus,
                                        selectedOptions,
                                        fillBlankOption,
                                        selectedFillBlankAnswer) =>
                                    Card(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: _buildBorderColor(
                                        isFillBlank,
                                        questionStatus,
                                        selectedOptions,
                                        fillBlankOption,
                                        selectedFillBlankAnswer,
                                        option,
                                      ),
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      option.option,
                                    ),
                                  ),
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
          Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              FlagFirstOrLastQuestionSelector(
                  (isFirst, isLast, questionStatus) {
                switch (questionStatus) {
                  case QuestionStatusState.selected:
                    return Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          learnBloc.add(SubmitClicked());
                        },
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.matisse,
                        ),
                        child: const Text(
                          'Submit',
                        ),
                      ),
                    );
                  case QuestionStatusState.submitted:
                    return Expanded(
                      child: Row(
                        children: [
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
                        ],
                      ),
                    );
                  case QuestionStatusState.initial:
                  default:
                    return const SizedBox.shrink();
                }
              }),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
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
          (partList, selectedFillBlankOptions, questionStatus) => Text.rich(
            TextSpan(
              children: _createSpans(
                  partList, selectedFillBlankOptions, questionStatus),
            ),
          ),
        );
      case AppConstants.questionnaireTypeMultiple:
        return RichText(
          text: TextSpan(
            text: question.question,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: ' (${question.noOfAnswers} correct answers)',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.matisse,
                ),
              ),
            ],
          ),
        );
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

  List<InlineSpan> _createSpans(
      List<FillBlanksPart> parts,
      Map<Option, Option> selectedFillBlankOptions,
      QuestionStatusState questionStatus) {
    final spans = <InlineSpan>[];
    parts.asMap().forEach(
      (index, value) {
        if (AppConstants.fillBlanksPartOption == value.type) {
          final String? blankContent = _getBlankContentByStatus(
              questionStatus, value, selectedFillBlankOptions);
          if (blankContent == null) {
            spans.add(
              WidgetSpan(
                child: GestureDetector(
                  onTap: () {
                    if (value.option != null) {
                      learnBloc.add(BlankSelected(mappedOption: value.option!));
                    }
                  },
                  child: Container(
                    width: 50.0,
                    height: 18.0,
                    color: AppColors.matisse,
                  ),
                ),
              ),
            );
          } else {
            spans.add(
              TextSpan(
                text: blankContent,
                style: const TextStyle(
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.black,
                  fontWeight: FontWeight.bold,
                  color: AppColors.matisse,
                ),
                recognizer: _setClickListener(value),
              ),
            );
          }
        } else {
          spans.add(
            TextSpan(
              text: value.content,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          );
        }
      },
    );

    return spans;
  }

  Color _buildBorderColor(
      bool isFillBlank,
      QuestionStatusState questionStatus,
      List<Option>? selectedOptions,
      Option? fillBlankOption,
      Map<Option, Option>? selectedFillBlankAnswer,
      Option option) {
    if (isFillBlank) {
      final bool isSelected = (option == fillBlankOption) ||
          (selectedFillBlankAnswer?.keys.contains(option) ?? false);
      switch (questionStatus) {
        case QuestionStatusState.submitted:
          if (isSelected) {
            return option == selectedFillBlankAnswer?[option]
                ? Colors.green
                : Colors.red;
          } else {
            return option.isAnswer ? Colors.green : Colors.transparent;
          }
        case QuestionStatusState.initial:
        case QuestionStatusState.selected:
        default:
          return isSelected ? AppColors.matisse : Colors.transparent;
      }
    } else {
      final bool isSelected = selectedOptions?.contains(option) ?? false;
      switch (questionStatus) {
        case QuestionStatusState.submitted:
          return isSelected
              ? (option.isAnswer ? Colors.green : Colors.red)
              : (option.isAnswer ? Colors.green : Colors.transparent);
        case QuestionStatusState.initial:
        case QuestionStatusState.selected:
        default:
          return isSelected ? AppColors.matisse : Colors.transparent;
      }
    }
  }

  String? _getBlankContentByStatus(QuestionStatusState questionStatus,
      FillBlanksPart value, Map<Option, Option> selectedFillBlankOptions) {
    return (questionStatus == QuestionStatusState.submitted
        ? '  ${value.option?.option}  '
        : selectedFillBlankOptions.values.contains(value.option)
            ? '  ${selectedFillBlankOptions.keys.firstWhere((element) => selectedFillBlankOptions[element] == value.option).option}  '
            : null);
  }

  _setClickListener(FillBlanksPart value) {
    if (value.option != null) {
      return TapGestureRecognizer()
        ..onTap = () {
          learnBloc.add(BlankSelected(mappedOption: value.option!));
        };
    } else {
      return null;
    }
  }
}
