import 'dart:math';

import 'package:driving_test/config/constants.dart';
import 'package:driving_test/config/theme.dart';
import 'package:driving_test/routes.dart';
import 'package:driving_test/state/iap/iap_bloc.dart';
import 'package:driving_test/state/iap/iap_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class DrivingTestApp extends StatefulWidget {
  const DrivingTestApp({Key? key}) : super(key: key);

  @override
  State<DrivingTestApp> createState() => _DrivingTestAppState();
}

class _DrivingTestAppState extends State<DrivingTestApp> {
  IAPBloc get iapBloc => context.read<IAPBloc>();

  @override
  void initState() {
    iapBloc.add(InitStoreInfo());
    Purchases.addCustomerInfoUpdateListener((purchaserInfo) {
      _updatePurchaseStatus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      title: 'SERU Test',
      theme: Theming.lightTheme,
      navigatorKey: AppNavigator.navigatorKey,
      onGenerateRoute: AppNavigator.onGenerateRoute,
      builder: (context, child) {
        if (child == null) return const SizedBox.shrink();

        final data = MediaQuery.of(context);
        final smallestSize = min(data.size.width, data.size.height);
        final textScaleFactor =
            min(smallestSize / AppConstants.designScreenSize.width, 1.0);

        return MediaQuery(
          data: data.copyWith(
            textScaleFactor: textScaleFactor,
          ),
          child: child,
        );
      },
    );
  }

  void _updatePurchaseStatus() async {
    final purchaserInfo = await Purchases.getCustomerInfo();

    final entitlements = purchaserInfo.entitlements.active.values.toList();
    if (entitlements.isEmpty) {
      iapBloc.add(PurchasePending());
    } else {
      iapBloc.add(PurchaseVerified(purchases: entitlements));
    }
  }
}
