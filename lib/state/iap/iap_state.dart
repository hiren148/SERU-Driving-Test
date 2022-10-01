import 'package:purchases_flutter/purchases_flutter.dart';

class IAPState {
  final List<Offering> products;
  final List<EntitlementInfo> purchases;
  final bool isAvailable;
  final bool purchasePending;
  final bool loading;
  final String? queryProductError;

  const IAPState._({
    this.products = const <Offering>[],
    this.purchases = const <EntitlementInfo>[],
    this.isAvailable = false,
    this.purchasePending = false,
    this.loading = false,
    this.queryProductError,
  });

  const IAPState.initial() : this._();

  IAPState copyWith({
    List<Offering>? products,
    List<EntitlementInfo>? purchases,
    bool? isAvailable,
    bool? purchasePending,
    bool? loading,
    String? queryProductError,
  }) {
    return IAPState._(
      products: products ?? this.products,
      purchases: purchases ?? this.purchases,
      isAvailable: isAvailable ?? this.isAvailable,
      purchasePending: purchasePending ?? this.purchasePending,
      loading: loading ?? this.loading,
      queryProductError: queryProductError ?? this.queryProductError,
    );
  }

  IAPState asLoading(bool loading) {
    return copyWith(loading: loading);
  }

  IAPState asIsAvailable(bool isAvailable, bool loading) {
    return copyWith(isAvailable: isAvailable, loading: loading);
  }

  IAPState asQueryProductError(
    String? queryProductError,
    bool isAvailable,
    bool loading,
  ) {
    return copyWith(
      queryProductError: queryProductError,
      isAvailable: isAvailable,
      loading: loading,
    );
  }

  IAPState asQueryProductResponse(
    bool isAvailable,
    List<Offering> products,
    bool loading,
  ) {
    return copyWith(
      products: products,
      isAvailable: isAvailable,
      loading: loading,
    );
  }

  IAPState asPurchaseUpdated(bool purchasePending,
      {List<EntitlementInfo>? purchases}) {
    return copyWith(
      purchasePending: purchasePending,
      purchases: purchases,
    );
  }
}
