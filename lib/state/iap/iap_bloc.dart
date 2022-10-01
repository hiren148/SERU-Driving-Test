import 'package:driving_test/config/store_config.dart';
import 'package:driving_test/state/iap/iap_event.dart';
import 'package:driving_test/state/iap/iap_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:stream_transform/stream_transform.dart';

class IAPBloc extends Bloc<IAPEvent, IAPState> {
  IAPBloc() : super(const IAPState.initial()) {
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

    on<BuyNonConsumable>(
      _onBuyNonConsumable,
    );
  }

  void _onInitStoreInfo(InitStoreInfo event, Emitter<IAPState> emit) async {
    emit(state.asLoading(true));

    await Purchases.setup(StoreConfig.instance?.apiKey ?? '');

    try {
      final offering = await Purchases.getOfferings();
      if (offering.current != null) {
        emit(state.asQueryProductResponse(
          true,
          [offering.current!],
          false,
        ));
      } else {
        emit(state.asLoading(false));
      }
    } on PlatformException catch (error) {
      emit(state.asQueryProductError(error.message, false, false));
    }
  }

  void _onPurchaseError(PurchaseError event, Emitter<IAPState> emit) {
    emit(state.asPurchaseUpdated(false));
  }

  void _onPurchasePending(PurchasePending event, Emitter<IAPState> emit) {
    emit(state.asPurchaseUpdated(true));
  }

  void _onPurchaseVerified(PurchaseVerified event, Emitter<IAPState> emit) {
    emit(state.asPurchaseUpdated(false, purchases: event.purchases));
  }

  void _onRestorePurchase(RestorePurchase event, Emitter<IAPState> emit) async {
    try {
      final PurchaserInfo purchaserInfo = await Purchases.restoreTransactions();
      if (purchaserInfo.entitlements.active.isEmpty) {
        emit(state.asPurchaseUpdated(true));
      } else {
        emit(state.asPurchaseUpdated(false,
            purchases: purchaserInfo.entitlements.active.values.toList()));
      }
    } on PlatformException catch (e) {
      emit(state.asQueryProductError(
          e.message, state.isAvailable, state.loading));
    }
  }

  void _onBuyNonConsumable(
      BuyNonConsumable event, Emitter<IAPState> emit) async {
    try {
      await Purchases.purchasePackage(event.purchaseParam);
    } catch (e) {
      emit(state.asQueryProductError(
          e.toString(), state.isAvailable, state.loading));
    }
  }
}
