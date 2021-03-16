import 'dart:async';

import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class SubscriptionController extends GetxController {
  StreamSubscription<List<PurchaseDetails>> _subscription;

  @override
  void onInit() {
    final Stream purchaseUpdates =
        InAppPurchaseConnection.instance.purchaseUpdatedStream;
    _subscription = purchaseUpdates.listen((purchases) {
      _handlePurchaseUpdates(purchases);
    });
    super.onInit();
  }
}
