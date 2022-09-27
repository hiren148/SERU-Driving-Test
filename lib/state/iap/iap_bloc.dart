import 'dart:async';

import 'package:driving_test/state/iap/iap_event.dart';
import 'package:driving_test/state/iap/iap_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

const String _kSubscriptionId = 'seru.test.subscription';
const List<String> _kProductIds = <String>[
  _kSubscriptionId,
];

class IAPBloc extends Bloc<IAPEvent, IAPState> {
  final InAppPurchase _inAppPurchase;

  IAPBloc(this._inAppPurchase) : super(const IAPState.initial()) {
    on<InitStoreInfo>(
      _onInitStoreInfo,
      transformer: (events, mapper) => events.switchMap(mapper),
    );

    on<PurchaseError>(
      _onPurchaseError,
    );

    on<PurchasePending>(
      _onPurchasePending,
    );

    on<PurchaseVerified>(
      _onPurchaseVerified,
    );

    on<RestorePurchase>(
      _onRestorePurchase,
    );

    on<CompletePurchase>(
      _onCompletePurchase,
    );

    on<BuyNonConsumable>(
      _onBuyNonConsumable,
    );
  }

  void _onInitStoreInfo(InitStoreInfo event, Emitter<IAPState> emit) async {
    emit(state.asLoading(true));
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      emit(state.asIsAvailable(isAvailable, false));
      return;
    }

    final ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      emit(state.asQueryProductError(
          productDetailResponse.error!.message,
          productDetailResponse.notFoundIDs,
          productDetailResponse.productDetails,
          isAvailable,
          false));
      return;
    }

    if (productDetailResponse.productDetails.isNotEmpty) {
      emit(state.asQueryProductResponse(
        isAvailable,
        productDetailResponse.productDetails,
        productDetailResponse.notFoundIDs,
        false,
      ));
    } else {
      emit(state.asLoading(false));
    }
  }

  void _onPurchaseError(PurchaseError event, Emitter<IAPState> emit) {
    emit(state.asPurchaseUpdated(false));
  }

  void _onPurchasePending(PurchasePending event, Emitter<IAPState> emit) {
    emit(state.asPurchaseUpdated(true));
  }

  void _onPurchaseVerified(PurchaseVerified event, Emitter<IAPState> emit) {
    emit(state.asPurchaseUpdated(false,
        purchases: <PurchaseDetails>[event.purchaseDetails]));
  }

  void _onRestorePurchase(RestorePurchase event, Emitter<IAPState> emit) {
    _inAppPurchase.restorePurchases();
  }

  void _onCompletePurchase(CompletePurchase event, Emitter<IAPState> emit) {
    _inAppPurchase.completePurchase(event.purchase);
  }

  void _onBuyNonConsumable(BuyNonConsumable event, Emitter<IAPState> emit) {
    _inAppPurchase.buyNonConsumable(purchaseParam: event.purchaseParam);
  }
}
