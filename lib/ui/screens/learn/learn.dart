import 'dart:async';
import 'dart:io';

import 'package:driving_test/config/colors.dart';
import 'package:driving_test/config/constants.dart';
import 'package:driving_test/config/images.dart';
import 'package:driving_test/domain/entities/chapter.dart';
import 'package:driving_test/domain/entities/question.dart';
import 'package:driving_test/domain/entities/theory_part.dart';
import 'package:driving_test/routes.dart';
import 'package:driving_test/state/chapters/chapter_bloc.dart';
import 'package:driving_test/state/chapters/chapter_event.dart';
import 'package:driving_test/state/chapters/chapter_selector.dart';
import 'package:driving_test/state/chapters/chapter_state.dart';
import 'package:driving_test/state/iap/iap_bloc.dart';
import 'package:driving_test/state/iap/iap_event.dart';
import 'package:driving_test/state/iap/iap_selector.dart';
import 'package:driving_test/state/learn/learn_bloc.dart';
import 'package:driving_test/state/learn/learn_event.dart';
import 'package:driving_test/ui/widgets/illustration_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({Key? key}) : super(key: key);

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  LearnBloc get learnBloc => context.read<LearnBloc>();

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
          return _buildChapterList();
        case ChapterStateStatus.loadFailure:
          return _buildError();
        default:
          return const SizedBox.shrink();
      }
    });
  }

  void _onPressedTheory(Chapter chapter, List<TheoryPart> theoryParts) {
    learnBloc.add(LoadTheory(chapter: chapter, theoryParts: theoryParts));
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
    Map<Chapter, List<Question>> chapterMap,
    Map<Chapter, List<TheoryPart>> theoryMap,
    int index,
  ) {
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
                  theoryMap.keys.elementAt(index - 1),
                  theoryMap.values.elementAt(index - 1),
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
          IAPStatusSelector((purchasePending, products) => Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    if (purchasePending) {
                      _showIAPDialog(context, products);
                    } else {
                      _onPressMCQ(chapterMap.keys.elementAt(index - 1),
                          chapterMap.values.elementAt(index - 1));
                    }
                  },
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[
                          const Expanded(
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
                            purchasePending
                                ? Icons.lock_outline
                                : Icons.keyboard_arrow_right,
                            color: AppColors.matisse,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )),
          IAPStatusSelector((purchasePending, products) => Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    if (purchasePending) {
                      _showIAPDialog(context, products);
                    } else {
                      _onPressFillBlank(chapterMap.keys.elementAt(index - 1),
                          chapterMap.values.elementAt(index - 1));
                    }
                  },
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[
                          const Expanded(
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
                            purchasePending
                                ? Icons.lock_outline
                                : Icons.keyboard_arrow_right,
                            color: AppColors.matisse,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  void _showIAPDialog(BuildContext context, List<Offering> products) {
    if (products.isNotEmpty &&
        products.first.availablePackages.isNotEmpty) {
      // set up the button
      Widget okButton = TextButton(
        child: const Text("OK"),
        onPressed: () {
          AppNavigator.pop();
          if(Platform.isIOS){
            _showDisclosure(context,products);
          }else {
            _initIAPFlow(products);
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Subscription is not available at moment!',
          ),
        ),
      );
    }

  }

  Widget _buildChapterList() {
    return ChapterListSelector(
      (chapterMap, theoryMap) => ListView.builder(
        itemCount: 1 + chapterMap.length,
        itemBuilder: ((_, index) => index == 0
            ? const IllustrationCardView(image: AppImages.bannerLearn)
            : _buildChapterWidget(
                chapterMap,
                theoryMap,
                index,
              )),
      ),
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

  void _initIAPFlow(List<Offering> products) {
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
  }

  void _showDisclosure(BuildContext context, List<Offering> products) {
    Widget okButton = TextButton(
      child: const Text('CONFIRM'),
      onPressed: () {
        AppNavigator.pop();
        _initIAPFlow(products);
      },
    );

    Widget privacyPolicyButton = TextButton(
      child: const Text('PRIVACY POLICY'),
      onPressed: () {
        AppNavigator.pop();
        _launchURL(
            AppConstants.privacyPolicyURL);
      },
    );

    Widget termsOfUseButton = TextButton(
      child: const Text('TERMS OF USE'),
      onPressed: () {
        AppNavigator.pop();
        _launchURL(
            AppConstants.termsOfUseURL);
      },
    );

    Widget cancelButton = TextButton(
      child: const Text('CANCEL'),
      onPressed: () {
        AppNavigator.pop();
      },
    );
    String period =products.first.availablePackages.first.packageType.name;
    String purchaseAmount =products.first.availablePackages.first.product.priceString;
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("DISCLOSURE"),
      content: Text("A $purchaseAmount $period purchase will be applied to your iTunes account on confirmation.\n\nSubscriptions will automatically renew unless canceled within 24-hours before the end of the current period. You can cancel anytime with your iTunes account settings. Any unused portion of a free trial will be forfeited if you purchase a subscription."),
      actions: [
        cancelButton,
        termsOfUseButton,
        privacyPolicyButton,
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

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
