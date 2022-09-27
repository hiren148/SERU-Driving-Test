import 'package:driving_test/config/colors.dart';
import 'package:driving_test/config/constants.dart';
import 'package:driving_test/domain/entities/fill_blanks_part.dart';
import 'package:driving_test/domain/entities/option.dart';
import 'package:driving_test/domain/entities/question.dart';
import 'package:driving_test/routes.dart';
import 'package:driving_test/state/exam/exam_bloc.dart';
import 'package:driving_test/state/exam/exam_event.dart';
import 'package:driving_test/state/exam/exam_selector.dart';
import 'package:driving_test/state/exam/exam_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamQuestionnaireScreen extends StatefulWidget {
  const ExamQuestionnaireScreen({Key? key}) : super(key: key);

  @override
  State<ExamQuestionnaireScreen> createState() =>
      _ExamQuestionnaireScreenState();
}

class _ExamQuestionnaireScreenState extends State<ExamQuestionnaireScreen> {
  ExamBloc get examBloc => context.read<ExamBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Driving Test',
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
                                  examBloc.add(OptionSelected(option: option)),
                              child: OptionBorderColorStatusStateSelector(
                                (isFillBlank, questionStatus, selectedOptions,
                                    fillBlankOption, selectedFillBlankAnswer) {
                                  return Card(
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
                                  );
                                },
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
              QuestionStatusStateSelector((questionStatus) {
                switch (questionStatus) {
                  case QuestionStatusState.selected:
                    return Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          examBloc.add(SubmitClicked());
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
                      child: FlagLastQuestionSelector(
                        (isLast) => ElevatedButton(
                          onPressed: () {
                            isLast
                                ? _redirectResultScreen()
                                : examBloc.add(NextClicked());
                          },
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.matisse,
                          ),
                          child: const Text(
                            'Next',
                          ),
                        ),
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
          (partList, selectedFillBlankOptions, questionStatus) => RichText(
            text: TextSpan(
              text: '',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: _createSpans(
                  partList, selectedFillBlankOptions, questionStatus),
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

  List<TextSpan> _createSpans(
      List<FillBlanksPart> parts,
      Map<Option, Option> selectedFillBlankOptions,
      QuestionStatusState questionStatus) {
    final spans = <TextSpan>[];
    parts.asMap().forEach(
      (index, value) {
        spans.add(
          TextSpan(
            text: AppConstants.fillBlanksPartOption == value.type
                ? (questionStatus == QuestionStatusState.submitted
                    ? '  ${value.option?.option}  '
                    : selectedFillBlankOptions.values.contains(value.option)
                        ? '  ${selectedFillBlankOptions.keys.firstWhere((element) => selectedFillBlankOptions[element] == value.option).option}  '
                        : value.content)
                : value.content,
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
            recognizer: _setClickListener(value),
          ),
        );
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

  void _redirectResultScreen() {
    AppNavigator.replaceWith(Routes.success);
  }

  _setClickListener(FillBlanksPart value) {
    if (value.option != null &&
        AppConstants.fillBlanksPartOption == value.type) {
      return TapGestureRecognizer()
        ..onTap = () {
          examBloc.add(BlankSelected(mappedOption: value.option!));
        };
    } else {
      return null;
    }
  }
}
