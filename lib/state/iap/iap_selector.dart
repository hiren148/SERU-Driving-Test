import 'package:driving_test/state/iap/iap_bloc.dart';
import 'package:driving_test/state/iap/iap_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

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
      Widget Function(
               bool, List<Offering>)
          builder)
      : super(
          selector: (state) => IAPStatusState(
            // state.queryProductError,
            state.purchasePending,
            // state.isAvailable,
            // state.loading,
            // state.purchases,
            state.products,
          ),
          builder: (value) => builder(
            // value.queryProductError,
            value.purchasePending,
            // value.isAvailable,
            // value.loading,
            // value.purchases,
            value.products,
          ),
        );
}

class IAPStatusState {
  // final String? queryProductError;
  final bool purchasePending;
  // final bool isAvailable;
  // final bool loading;
  // final List<EntitlementInfo> purchases;
  final List<Offering> products;

  IAPStatusState(
    // this.queryProductError,
    this.purchasePending,
    // this.isAvailable,
    // this.loading,
    // this.purchases,
    this.products,
  );
}

class IAPPurchasePendingSelector extends IAPStateSelector<bool> {
  IAPPurchasePendingSelector(Widget Function(bool) builder)
      : super(
          selector: (state) => state.purchasePending,
          builder: builder,
        );
}
