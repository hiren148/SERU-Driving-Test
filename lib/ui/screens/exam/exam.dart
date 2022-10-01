import 'package:driving_test/config/images.dart';
import 'package:driving_test/domain/entities/question.dart';
import 'package:driving_test/routes.dart';
import 'package:driving_test/state/chapters/chapter_selector.dart';
import 'package:driving_test/state/exam/exam_bloc.dart';
import 'package:driving_test/state/exam/exam_event.dart';
import 'package:driving_test/state/iap/iap_selector.dart';
import 'package:driving_test/ui/widgets/illustration_card.dart';
import 'package:driving_test/ui/widgets/test_type_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({Key? key}) : super(key: key);

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  ExamBloc get examBloc => context.read<ExamBloc>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const IllustrationCardView(image: AppImages.bannerTest),
        IAPStatusSelector((purchasePending, products) => CreateExamSelector(
              20,
              (questions) => TestTypeCardView(
                title: 'Start new test',
                subtitle: '20 questions',
                image: AppImages.imgFillBlank,
                onPressed: () {
                  if (purchasePending) {
                  } else {
                    _onPressedStartTest(questions);
                  }
                },
                purchasePending: purchasePending,
              ),
            )),
        IAPStatusSelector((purchasePending, products) => CreateExamSelector(
              30,
              (questions) => TestTypeCardView(
                title: 'Start new test',
                subtitle: '30 questions',
                image: AppImages.imgFillBlank,
                onPressed: () {
                  if (purchasePending) {
                  } else {
                    _onPressedStartTest(questions);
                  }
                },
                purchasePending: purchasePending,
              ),
            )),
        IAPStatusSelector((purchasePending, products) => CreateExamSelector(
              50,
              (questions) => TestTypeCardView(
                title: 'Start new test',
                subtitle: '50 questions',
                image: AppImages.imgFillBlank,
                onPressed: () {
                  if (purchasePending) {
                  } else {
                    _onPressedStartTest(questions);
                  }
                },
                purchasePending: purchasePending,
              ),
            )),
      ],
    );
  }

  void _onPressedStartTest(List<Question> questions) {
    questions.shuffle();
    examBloc.add(LoadQuestions(questions: questions));
    AppNavigator.push(
      Routes.examQuestionnaire,
    );
  }
}
