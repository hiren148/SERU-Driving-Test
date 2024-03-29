import 'dart:async';
import 'dart:io';

import 'package:driving_test/config/colors.dart';
import 'package:driving_test/config/constants.dart';
import 'package:driving_test/config/images.dart';
import 'package:driving_test/routes.dart';
import 'package:driving_test/state/chapters/chapter_bloc.dart';
import 'package:driving_test/state/chapters/chapter_event.dart';
import 'package:driving_test/state/chapters/chapter_selector.dart';
import 'package:driving_test/state/chapters/chapter_state.dart';
import 'package:driving_test/state/countdowntimer/countdown_cubit.dart';
import 'package:driving_test/state/iap/iap_bloc.dart';
import 'package:driving_test/state/iap/iap_event.dart';
import 'package:driving_test/state/iap/iap_selector.dart';
import 'package:driving_test/ui/widgets/illustration_card.dart';
import 'package:driving_test/ui/widgets/test_type_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/models/offering_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({Key? key}) : super(key: key);

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
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

  void _onPressedStartTest() {
    context.read<CountdownCubit>().startTimer();
    AppNavigator.push(
      Routes.examQuestionnaire,
    );
  }

  void _showIAPDialog(BuildContext context, List<Offering> products) {
    if (products.isNotEmpty && products.first.availablePackages.isNotEmpty) {
      // set up the button
      Widget okButton = TextButton(
        child: const Text("OK"),
        onPressed: () {
          AppNavigator.pop();
          if (Platform.isIOS) {
            _showDisclosure(context, products);
          } else {
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

  Widget _buildExamList() {
    return ListView.builder(
        itemCount: 11,
        itemBuilder: (_, index) {
          if (index == 0) {
            return const IllustrationCardView(image: AppImages.bannerTest);
          } else {
            return IAPStatusSelector(
              (purchasePending, products) => TestTypeCardView(
                title: 'Test $index',
                subtitle: '37 questions, 45 Minute',
                image: AppImages.imgFillBlank,
                onPressed: () {
                  if (purchasePending) {
                    _showIAPDialog(context, products);
                  } else {
                    _onPressedStartTest();
                  }
                },
                purchasePending: purchasePending,
              ),
            );
          }
        });
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
    if (products.isNotEmpty && products.first.availablePackages.isNotEmpty) {
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

    Widget cancelButton = TextButton(
      child: const Text('CANCEL'),
      onPressed: () {
        AppNavigator.pop();
      },
    );
    String period = products.first.availablePackages.first.packageType.name;
    String purchaseAmount =
        products.first.availablePackages.first.storeProduct.priceString;

    TextStyle defaultStyle = const TextStyle(color: AppColors.black);
    TextStyle linkStyle = const TextStyle(color: AppColors.matisse);

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("DISCLOSURE"),
      content: RichText(
        text: TextSpan(children: <TextSpan>[
          TextSpan(
            style: defaultStyle,
            text:
                'A $purchaseAmount $period purchase will be applied to your iTunes account on confirmation.\n\nSubscriptions will automatically renew unless canceled within 24-hours before the end of the current period. You can cancel anytime with your iTunes account settings. Any unused portion of a free trial will be forfeited if you purchase a subscription.\n\nFor more information, see our ',
          ),
          TextSpan(
              style: linkStyle,
              text: 'Privacy Policy',
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  AppNavigator.pop();
                  _launchURL(AppConstants.privacyPolicyURL);
                }),
          TextSpan(style: defaultStyle, text: ' and '),
          TextSpan(
              style: linkStyle,
              text: 'Terms of Use',
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  AppNavigator.pop();
                  _launchURL(AppConstants.termsOfUseURL);
                })
        ]),
      ),
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

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
