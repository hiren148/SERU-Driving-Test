import 'dart:io';

import 'package:driving_test/state/iap/iap_bloc.dart';
import 'package:driving_test/state/iap/iap_event.dart';
import 'package:driving_test/state/iap/iap_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  IAPBloc get iapBloc => context.read<IAPBloc>();

  @override
  Widget build(BuildContext context) {
    return IAPStatusSelector((
      queryProductError,
      purchasePending,
      isAvailable,
      loading,
      notFoundIds,
      purchases,
      products,
    ) =>
        Stack(
          children: _buildWidgetStack(
            queryProductError,
            purchasePending,
            isAvailable,
            loading,
            notFoundIds,
            purchases,
            products,
          ),
        ));
  }

  Widget _buildRestoreButton(
    bool loading,
  ) {
    return loading
        ? Container()
        : Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    // TODO(darrenaustin): Migrate to new API once it lands in stable: https://github.com/flutter/flutter/issues/105724
                    // ignore: deprecated_member_use
                    primary: Colors.white,
                  ),
                  onPressed: () => iapBloc.add(RestorePurchase()),
                  child: const Text('Restore purchases'),
                ),
              ],
            ),
          );
  }

  Card _buildProductList(
    bool loading,
    bool isAvailable,
    List<String> notFoundIds,
    List<PurchaseDetails> _purchases,
    List<ProductDetails> products,
  ) {
    if (loading) {
      return const Card(
          child: ListTile(
              leading: CircularProgressIndicator(),
              title: Text('Fetching products...')));
    }
    if (!isAvailable) {
      return const Card();
    }
    const ListTile productHeader = ListTile(title: Text('Products for Sale'));
    final List<ListTile> productList = <ListTile>[];
    if (notFoundIds.isNotEmpty) {
      productList.add(ListTile(
          title: Text('[${notFoundIds.join(", ")}] not found',
              style: TextStyle(color: ThemeData.light().colorScheme.error)),
          subtitle: const Text(
              'This app needs special configuration to run. Please see example/README.md for instructions.')));
    }

    // This loading previous purchases code is just a demo. Please do not use this as it is.
    // In your app you should always verify the purchase data using the `verificationData` inside the [PurchaseDetails] object before trusting it.
    // We recommend that you use your own server to verify the purchase data.
    final Map<String, PurchaseDetails> purchases =
        Map<String, PurchaseDetails>.fromEntries(
            _purchases.map((PurchaseDetails purchase) {
      if (purchase.pendingCompletePurchase) {
        iapBloc.add(CompletePurchase(purchase: purchase));
      }
      return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
    }));
    productList.addAll(products.map(
      (ProductDetails productDetails) {
        final PurchaseDetails? previousPurchase = purchases[productDetails.id];
        return ListTile(
          title: Text(
            productDetails.title,
          ),
          subtitle: Text(
            productDetails.description,
          ),
          trailing: previousPurchase != null
              ? IconButton(
                  onPressed: () => confirmPriceChange(context),
                  icon: const Icon(Icons.upgrade))
              : TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green[800],
                    // TODO(darrenaustin): Migrate to new API once it lands in stable: https://github.com/flutter/flutter/issues/105724
                    // ignore: deprecated_member_use
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    PurchaseParam purchaseParam = PurchaseParam(
                      productDetails: productDetails,
                    );
                    iapBloc.add(BuyNonConsumable(purchaseParam: purchaseParam));
                  },
                  child: Text(productDetails.price),
                ),
        );
      },
    ));

    return Card(
        child: Column(
            children: <Widget>[productHeader, const Divider()] + productList));
  }

  Card _buildConnectionCheckTile(bool loading, bool isAvailable) {
    if (loading) {
      return const Card(child: ListTile(title: Text('Trying to connect...')));
    }
    final Widget storeHeader = ListTile(
      leading: Icon(isAvailable ? Icons.check : Icons.block,
          color:
              isAvailable ? Colors.green : ThemeData.light().colorScheme.error),
      title: Text('The store is ${isAvailable ? 'available' : 'unavailable'}.'),
    );
    final List<Widget> children = <Widget>[storeHeader];

    if (!isAvailable) {
      children.addAll(<Widget>[
        const Divider(),
        ListTile(
          title: Text('Not connected',
              style: TextStyle(color: ThemeData.light().colorScheme.error)),
          subtitle: const Text(
              'Unable to connect to the payments processor. Has this app been configured correctly? See the example README for instructions.'),
        ),
      ]);
    }
    return Card(child: Column(children: children));
  }

  List<Widget> _buildWidgetStack(
    String? queryProductError,
    bool purchasePending,
    bool isAvailable,
    bool loading,
    List<String> notFoundIds,
    List<PurchaseDetails> purchases,
    List<ProductDetails> products,
  ) {
    final List<Widget> stack = <Widget>[];
    if (queryProductError == null) {
      stack.add(
        ListView(
          children: <Widget>[
            _buildConnectionCheckTile(loading, isAvailable),
            _buildProductList(
              loading,
              isAvailable,
              notFoundIds,
              purchases,
              products,
            ),
            _buildRestoreButton(loading),
          ],
        ),
      );
    } else {
      stack.add(Center(
        child: Text(queryProductError),
      ));
    }
    if (purchasePending) {
      stack.add(
        Stack(
          children: const <Widget>[
            Opacity(
              opacity: 0.3,
              child: ModalBarrier(dismissible: false, color: Colors.grey),
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );
    }
    return stack;
  }

  Future<void> confirmPriceChange(BuildContext context) async {
    if (Platform.isAndroid) {
      final InAppPurchaseAndroidPlatformAddition androidAddition = InAppPurchase
          .instance
          .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
      final BillingResultWrapper priceChangeConfirmationResult =
          await androidAddition.launchPriceChangeConfirmationFlow(
        sku: 'purchaseId',
      );
      if (priceChangeConfirmationResult.responseCode == BillingResponse.ok) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Price change accepted'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            priceChangeConfirmationResult.debugMessage ??
                'Price change failed with code ${priceChangeConfirmationResult.responseCode}',
          ),
        ));
      }
    }
  }
}
