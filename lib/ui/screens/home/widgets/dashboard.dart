import 'package:driving_test/config/images.dart';
import 'package:driving_test/state/bottomitem/bottom_item_cubit.dart';
import 'package:driving_test/state/chapters/chapter_selector.dart';
import 'package:driving_test/state/iap/iap_selector.dart';
import 'package:driving_test/ui/widgets/illustration_card.dart';
import 'package:driving_test/ui/widgets/test_type_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bottomStateCubit =
        BlocProvider.of<BottomItemCubit>(context, listen: false);

    return ListView(
      children: [
        const IllustrationCardView(),
        SizedBox(
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
                        reviewList.elementAt(index),
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
        ),
        IAPPurchasesSelector((purchases) => OutlinedButton(
              onPressed: () {},
              child: Text(
                purchases.isEmpty
                    ? 'Subscribe Now'
                    : 'Subscription Active ${purchases.first.purchaseID}',
              ),
            )),
        TestTypeCardView(
          title: 'Learn',
          subtitle: 'Read question and answers',
          image: AppImages.imgLearn,
          onPressed: () {
            bottomStateCubit.onItemTapped(1);
          },
        ),
        TestTypeCardView(
          title: 'Test',
          subtitle: 'Attempt exam and test your knowledge',
          image: AppImages.imgTest,
          onPressed: () {
            bottomStateCubit.onItemTapped(2);
          },
        ),
      ],
    );
  }
}
