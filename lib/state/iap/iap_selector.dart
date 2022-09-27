import 'package:driving_test/state/iap/iap_bloc.dart';
import 'package:driving_test/state/iap/iap_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class IAPStateSelector<T> extends BlocSelector<IAPBloc, IAPState, T> {
  IAPStateSelector({
    required T Function(IAPState) selector,
    required Widget Function(T) builder,
  }) : super(
          selector: selector,
          builder: (_, value) => builder(value),
        );
}

class IAPStatusSelector extends IAPStateSelector<IAPStatusState> {
  IAPStatusSelector(
      Widget Function(String?, bool, bool, bool, List<String>,
              List<PurchaseDetails>, List<ProductDetails>)
          builder)
      : super(
          selector: (state) => IAPStatusState(
            state.queryProductError,
            state.purchasePending,
            state.isAvailable,
            state.loading,
            state.notFoundIds,
            state.purchases,
            state.products,
          ),
          builder: (value) => builder(
            value.queryProductError,
            value.purchasePending,
            value.isAvailable,
            value.loading,
            value.notFoundIds,
            value.purchases,
            value.products,
          ),
        );
}

class IAPStatusState {
  final String? queryProductError;
  final bool purchasePending;
  final bool isAvailable;
  final bool loading;
  final List<String> notFoundIds;
  final List<PurchaseDetails> purchases;
  final List<ProductDetails> products;

  IAPStatusState(
    this.queryProductError,
    this.purchasePending,
    this.isAvailable,
    this.loading,
    this.notFoundIds,
    this.purchases,
    this.products,
  );
}

class IAPPurchasesSelector extends IAPStateSelector<List<PurchaseDetails>> {
  IAPPurchasesSelector(Widget Function(List<PurchaseDetails>) builder)
      : super(
          selector: (state) => state.purchases,
          builder: builder,
        );
}
