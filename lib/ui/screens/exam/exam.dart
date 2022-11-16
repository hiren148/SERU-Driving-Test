import 'dart:async';

import 'package:driving_test/config/colors.dart';
import 'package:driving_test/config/images.dart';
import 'package:driving_test/domain/entities/question.dart';
import 'package:driving_test/routes.dart';
import 'package:driving_test/state/chapters/chapter_bloc.dart';
import 'package:driving_test/state/chapters/chapter_event.dart';
import 'package:driving_test/state/chapters/chapter_selector.dart';
import 'package:driving_test/state/chapters/chapter_state.dart';
import 'package:driving_test/state/exam/exam_bloc.dart';
import 'package:driving_test/state/exam/exam_event.dart';
import 'package:driving_test/state/iap/iap_bloc.dart';
import 'package:driving_test/state/iap/iap_event.dart';
import 'package:driving_test/state/iap/iap_selector.dart';
import 'package:driving_test/ui/widgets/illustration_card.dart';
import 'package:driving_test/ui/widgets/test_type_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/offering_wrapper.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({Key? key}) : super(key: key);

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  ExamBloc get examBloc => context.read<ExamBloc>();

  IAPBloc get iapBloc => context.read<IAPBloc>();

  ChapterBloc get chapterBloc => context.read<ChapterBloc>();

  @override
  void initState() {
    scheduleMicrotask(() {
      chapterBloc.add(ChapterLoadStarted());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChapterStateStatusSelector((chapterStatus) {
      switch (chapterStatus) {
        case ChapterStateStatus.loading:
          return _buildLoading();
        case ChapterStateStatus.loadSuccess:
          return _buildExamList();
        case ChapterStateStatus.loadFailure:
          return _buildError();
        default:
          return const SizedBox.shrink();
      }
    });
  }

  void _onPressedStartTest(List<Question> questions) {
    questions.shuffle();
    examBloc.add(LoadQuestions(questions: questions));
    AppNavigator.push(
      Routes.examQuestionnaire,
    );
  }

  void _showIAPDialog(BuildContext context, List<Offering> products) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        AppNavigator.pop();
        if (products.isNotEmpty &&
            products.first.availablePackages.isNotEmpty) {
          iapBloc.add(BuyNonConsumable(
              purchaseParam: products.first.availablePackages.first));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Subscription is not available at moment!',
              ),
            ),
          );
        }
      },
    );

    Widget cancelButton = TextButton(
      child: const Text('CANCEL'),
      onPressed: () {
        AppNavigator.pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Upgrade"),
      content: const Text("Upgrade now to unlock all features."),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _buildExamList() {
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
                    _showIAPDialog(context, products);
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
                    _showIAPDialog(context, products);
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
                    _showIAPDialog(context, products);
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

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError() {
    return Column(
      children: [
        const Icon(
          Icons.warning_amber_rounded,
          size: 72,
          color: Colors.black26,
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'Oops!! Something went wrong!',
        ),
        const SizedBox(
          height: 16,
        ),
        ElevatedButton(
          onPressed: () {
            chapterBloc.add(ChapterLoadStarted());
          },
          style: ElevatedButton.styleFrom(
            primary: AppColors.matisse,
          ),
          child: const Text(
            'Try again',
          ),
        ),
      ],
    );
  }
}
