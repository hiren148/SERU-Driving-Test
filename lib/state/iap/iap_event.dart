import 'package:in_app_purchase/in_app_purchase.dart';

abstract class IAPEvent {
  const IAPEvent();
}

class InitStoreInfo extends IAPEvent {}

class PurchaseError extends IAPEvent {}

class PurchasePending extends IAPEvent {}

class PurchaseVerified extends IAPEvent {
  final PurchaseDetails purchaseDetails;

  const PurchaseVerified({required this.purchaseDetails});
}

class RestorePurchase extends IAPEvent{}

class CompletePurchase extends IAPEvent{
  final PurchaseDetails purchase;

  const CompletePurchase({required this.purchase});
}

class BuyNonConsumable extends IAPEvent{
  final PurchaseParam purchaseParam;

  const BuyNonConsumable({required this.purchaseParam});
}
