import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';

class InAppPurchaseManager {
  late StreamSubscription _purchaseUpdatedSubscription;
  late StreamSubscription _purchaseErrorSubscription;
  late StreamSubscription _connectionSubscription;
  static List<String> _productLists = Platform.isAndroid ? ["com.app.shalaonline.test", "com.app.shalaonline.test1"] : ["test"];

  List<IAPItem> _inAppPurchaseItems = [];
  late int getPurchaseSubscriptionId;

  //To initialize In App
  Future<void> initSubscription() async {
    var result = await FlutterInappPurchase.instance.initConnection;
    print(result);
  }

  //Use for to fetch keys
  Future<List<IAPItem>> getSubscriptionProducts() async {
    try {
      var subscriptionItems = await FlutterInappPurchase.instance.getSubscriptions(_productLists);
      List<IAPItem> list3 = [];
      subscriptionItems.forEach((e) {
        list3.add(e);
      });
      return _inAppPurchaseItems = list3;
    } catch (e) {
      print(e);
      return [];
    }
  }

  //Used for ending connection
  Future<void> endConnection() async {
    var result = await FlutterInappPurchase.instance.endConnection;
    print(result);
  }

  // On tap of button need to pass product id
  void requestSubscription({BuildContext? context, Future<void> onPurchased(PurchasedItem purchasedItem)?, String? productKey}) {
    FlutterInappPurchase.instance.requestSubscription(productKey!);

    _connectionSubscription = FlutterInappPurchase.connectionUpdated.listen((connected) {
      debugPrint('connected: $connected');
    });
    _purchaseUpdatedSubscription = FlutterInappPurchase.purchaseUpdated.listen((productItem) {
      debugPrint('purchase-updated: $productItem');
      onPurchased!(productItem!);
    });
    _purchaseErrorSubscription = FlutterInappPurchase.purchaseError.listen((purchaseError) {
      debugPrint('purchase-error: $purchaseError');
    });
  }

  // Fetch subscribed product
  Future getSubscribedProducts() async {
    var subscriptionItems = await FlutterInappPurchase.instance.getSubscriptions(_productLists);
    print(subscriptionItems);
    List<IAPItem> list3 = [];

    subscriptionItems.forEach((e) {
      list3.add(e);
    });
    _inAppPurchaseItems = list3;
  }
}
