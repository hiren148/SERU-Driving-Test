import 'dart:async';

import 'package:driving_test/config/colors.dart';
import 'package:driving_test/config/images.dart';
import 'package:driving_test/state/bottomitem/bottom_item_cubit.dart';
import 'package:driving_test/state/chapters/chapter_bloc.dart';
import 'package:driving_test/state/chapters/chapter_event.dart';
import 'package:driving_test/state/chapters/chapter_selector.dart';
import 'package:driving_test/state/chapters/chapter_state.dart';
import 'package:driving_test/state/iap/iap_bloc.dart';
import 'package:driving_test/state/iap/iap_event.dart';
import 'package:driving_test/state/iap/iap_selector.dart';
import 'package:driving_test/ui/widgets/illustration_card.dart';
import 'package:driving_test/ui/widgets/test_type_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  IAPBloc get iapBloc => context.read<IAPBloc>();

  ChapterBloc get chapterBloc => context.read<ChapterBloc>();

  @override
  void initState() {
    scheduleMicrotask(() async {
      chapterBloc.add(ReviewLoadStarted());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var bottomStateCubit =
        BlocProvider.of<BottomItemCubit>(context, listen: false);

    return ListView(
      children: [
        const IllustrationCardView(image: AppImages.bannerDashboard),
        ReviewStateStatusSelector((reviewStatus) {
          switch (reviewStatus) {
            case ReviewStateStatus.loading:
              return _buildLoading();
            case ReviewStateStatus.loadSuccess:
              return _buildReviewList();
            case ReviewStateStatus.loadFailure:
              return _buildError();
            default:
              return const SizedBox.shrink();
          }
        }),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IAPStatusSelector(
            (purchasePending, products) => purchasePending
                ? ElevatedButton(
                    onPressed: () {
                      if (products.isNotEmpty &&
                          products.first.availablePackages.isNotEmpty) {
                        iapBloc.add(BuyNonConsumable(
                            purchaseParam:
                                products.first.availablePackages.first));
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
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.matisse,
                    ),
                    child: products.isNotEmpty &&
                            products.first.availablePackages.isNotEmpty
                        ? Text(
                            'Upgrade Now at ${products.first.availablePackages.first.product.priceString}')
                        : const Text(
                            'Upgrade Now',
                          ),
                  )
                : const SizedBox.shrink(),
          ),
        ),
        TestTypeCardView(
          title: 'Learn',
          subtitle: 'Read question and answers',
          image: AppImages.imgLearn,
          onPressed: () {
            bottomStateCubit.onItemTapped(1);
          },
          purchasePending: false,
        ),
        TestTypeCardView(
          title: 'Test',
          subtitle: 'Attempt exam and test your knowledge',
          image: AppImages.imgTest,
          onPressed: () {
            bottomStateCubit.onItemTapped(2);
          },
          purchasePending: false,
        ),
      ],
    );
  }

  Widget _buildReviewList() {
    return SizedBox(
      height: 112.0,
      child: ReviewListSelector(
        (reviewList) => ListView.builder(
          itemCount: reviewList.length,
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
          ),
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => SizedBox(
            width: 208.0,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    '"${reviewList.elementAt(index)}"',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
              ),
            ),
          ),
        ),
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
            chapterBloc.add(ReviewLoadStarted());
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
