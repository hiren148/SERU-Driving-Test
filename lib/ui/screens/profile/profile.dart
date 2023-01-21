import 'dart:io';

import 'package:driving_test/config/colors.dart';
import 'package:driving_test/config/constants.dart';
import 'package:driving_test/routes.dart';
import 'package:driving_test/state/iap/iap_bloc.dart';
import 'package:driving_test/state/iap/iap_event.dart';
import 'package:driving_test/state/iap/iap_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  IAPBloc get iapBloc => context.read<IAPBloc>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: <Widget>[
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.account_circle_outlined,
                    color: AppColors.matisse,
                    size: 72.0,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  IAPStatusSelector(
                    (purchasePending, products) => Text(
                      purchasePending ? 'Free User' : 'Subscribed User',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextButton(
                      onPressed: () {
                        _launchURL(
                            AppConstants.privacyPolicyURL);
                      },
                      child: const Text('Privacy Policy')),
                  TextButton(
                      onPressed: () {
                        _launchURL(
                            AppConstants.termsOfUseURL);
                      },
                      child: const Text('Terms of use')),
                  TextButton(
                      onPressed: () {
                        iapBloc.add(RestorePurchase());
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Purchase restored. You are not subscribed user!',
                            ),
                          ),
                        );
                      },
                      child: const Text('Restore Purchases')),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: const <Widget>[
                      Icon(
                        Icons.check_circle_outline,
                        color: AppColors.matisse,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          'Lifetime access to read theoritical data of all chapters',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: <Widget>[
                      IAPStatusSelector(
                        (purchasePending, products) => Icon(
                          purchasePending
                              ? Icons.cancel_outlined
                              : Icons.check_circle_outline,
                          color: AppColors.matisse,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Expanded(
                        child: Text(
                            'Access of chapter-wise single and multi choice questions with answer for preparation'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: <Widget>[
                      IAPStatusSelector(
                        (purchasePending, products) => Icon(
                          purchasePending
                              ? Icons.cancel_outlined
                              : Icons.check_circle_outline,
                          color: AppColors.matisse,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Expanded(
                        child: Text(
                            'Access of chapter-wise fill blank questions with answer for preparation'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: <Widget>[
                      IAPStatusSelector(
                        (purchasePending, products) => Icon(
                          purchasePending
                              ? Icons.cancel_outlined
                              : Icons.check_circle_outline,
                          color: AppColors.matisse,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Expanded(
                        child: Text('Access of practice test for all chapters'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          IAPStatusSelector(
            (purchasePending, products) => purchasePending
                ? ElevatedButton(
                    onPressed: () {
                      if (products.isNotEmpty &&
                          products.first.availablePackages.isNotEmpty) {
                        if(Platform.isIOS|| Platform.isAndroid){
                          _showDisclosure(context,products);
                        }else {
                          _initIAPFlow(products);
                        }
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
        ],
      ),
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
