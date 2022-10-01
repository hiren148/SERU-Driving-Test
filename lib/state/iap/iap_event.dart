
import 'package:purchases_flutter/purchases_flutter.dart';

abstract class IAPEvent {
  const IAPEvent();
}

class InitStoreInfo extends IAPEvent {}

class PurchaseError extends IAPEvent {}

class PurchasePending extends IAPEvent {}

class PurchaseVerified extends IAPEvent {
  final List<EntitlementInfo> purchases;

  const PurchaseVerified({required this.purchases});
}

class RestorePurchase extends IAPEvent{}

class BuyNonConsumable extends IAPEvent{
  final Package purchaseParam;

  const BuyNonConsumable({required this.purchaseParam});
}
