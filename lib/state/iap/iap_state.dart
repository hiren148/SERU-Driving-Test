import 'package:in_app_purchase/in_app_purchase.dart';

class IAPState {
  final List<String> notFoundIds;
  final List<ProductDetails> products;
  final List<PurchaseDetails> purchases;
  final List<String> consumables;
  final bool isAvailable;
  final bool purchasePending;
  final bool loading;
  final String? queryProductError;

  const IAPState._({
    this.notFoundIds = const <String>[],
    this.products = const <ProductDetails>[],
    this.purchases = const <PurchaseDetails>[],
    this.consumables = const <String>[],
    this.isAvailable = false,
    this.purchasePending = false,
    this.loading = false,
    this.queryProductError,
  });

  const IAPState.initial() : this._();

  IAPState copyWith({
    List<String>? notFoundIds,
    List<ProductDetails>? products,
    List<PurchaseDetails>? purchases,
    List<String>? consumables,
    bool? isAvailable,
    bool? purchasePending,
    bool? loading,
    String? queryProductError,
  }) {
    return IAPState._(
      notFoundIds: notFoundIds ?? this.notFoundIds,
      products: products ?? this.products,
      purchases: purchases ?? this.purchases,
      consumables: consumables ?? this.consumables,
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
    List<String> notFoundIds,
    List<ProductDetails> products,
    bool isAvailable,
    bool loading,
  ) {
    return copyWith(
      queryProductError: queryProductError,
      notFoundIds: notFoundIds,
      products: products,
      isAvailable: isAvailable,
      loading: loading,
    );
  }

  IAPState asQueryProductResponse(
    bool isAvailable,
    List<ProductDetails> products,
    List<String> notFoundIds,
    bool loading,
  ) {
    return copyWith(
      notFoundIds: notFoundIds,
      products: products,
      isAvailable: isAvailable,
      loading: loading,
    );
  }

  IAPState asPurchaseUpdated(bool purchasePending,
      {List<PurchaseDetails>? purchases}) {
    return copyWith(
      purchasePending: purchasePending,
      purchases: purchases,
    );
  }
}
