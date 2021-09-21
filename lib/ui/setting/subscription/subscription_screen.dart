// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';
// import 'package:in_app_purchase_android/billing_client_wrappers.dart';
// import 'package:in_app_purchase_android/in_app_purchase_android.dart';
// import 'package:in_app_purchase_ios/in_app_purchase_ios.dart';
// import 'package:in_app_purchase_ios/store_kit_wrappers.dart';
// import 'package:shala_yoga/base/utils/toast_utils.dart';
// import 'package:shala_yoga/ui/setting/subscription/consumable.dart';
//
// const bool _kAutoConsume = true;
//
// const String _kConsumableId = 'consumable';
// const String _kUpgradeId = 'com.app.shalaonline.test1';
// const String _kSilverSubscriptionId = 'subscription_silver';
// const String _kGoldSubscriptionId = 'subscription_gold';
// const List<String> _kProductIdAndroid = <String>["com.app.shalaonline.test", "com.app.shalaonline.test1"];
// const List<String> _kProductIds = <String>[
//   _kConsumableId,
//   _kUpgradeId,
//   _kSilverSubscriptionId,
//   _kGoldSubscriptionId,
// ];
//
// class SubscribeScreen extends StatefulWidget {
//   @override
//   _SubscribeScreenState createState() => _SubscribeScreenState();
// }
//
// class _SubscribeScreenState extends State<SubscribeScreen> {
//   final InAppPurchase _inAppPurchase = InAppPurchase.instance;
//   late StreamSubscription<List<PurchaseDetails>> _subscription;
//   List<String> _notFoundIds = [];
//   List<ProductDetails> _products = [];
//   List<PurchaseDetails> _purchases = [];
//   List<String> _consumables = [];
//   bool _isAvailable = false;
//   bool _purchasePending = false;
//   bool _loading = true;
//   String? _queryProductError;
//
//   @override
//   void initState() {
//     final Stream<List<PurchaseDetails>> purchaseUpdated = _inAppPurchase.purchaseStream;
//     _subscription = purchaseUpdated.listen((purchaseDetailsList) {
//       _listenToPurchaseUpdated(purchaseDetailsList);
//     }, onDone: () {
//       _subscription.cancel();
//     }, onError: (error) {
//       // handle error here.
//     });
//     initStoreInfo();
//     super.initState();
//   }
//
//   Future<void> initStoreInfo() async {
//     final bool isAvailable = await _inAppPurchase.isAvailable();
//     if (!isAvailable) {
//       setState(() {
//         _isAvailable = isAvailable;
//         _products = [];
//         _purchases = [];
//         _notFoundIds = [];
//         _consumables = [];
//         _purchasePending = false;
//         _loading = false;
//       });
//       return;
//     }
//
//     if (Platform.isIOS) {
//       var iosPlatformAddition = _inAppPurchase.getPlatformAddition<InAppPurchaseIosPlatformAddition>();
//       await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
//     }
//
//     ProductDetailsResponse productDetailResponse = await _inAppPurchase.queryProductDetails(Platform.isAndroid ? _kProductIdAndroid.toSet() : _kProductIds.toSet());
//     if (productDetailResponse.error != null) {
//       setState(() {
//         _queryProductError = productDetailResponse.error!.message;
//         _isAvailable = isAvailable;
//         _products = productDetailResponse.productDetails;
//         _purchases = [];
//         _notFoundIds = productDetailResponse.notFoundIDs;
//         _consumables = [];
//         _purchasePending = false;
//         _loading = false;
//       });
//       return;
//     }
//
//     if (productDetailResponse.productDetails.isEmpty) {
//       setState(() {
//         _queryProductError = null;
//         _isAvailable = isAvailable;
//         _products = productDetailResponse.productDetails;
//         _purchases = [];
//         _notFoundIds = productDetailResponse.notFoundIDs;
//         _consumables = [];
//         _purchasePending = false;
//         _loading = false;
//       });
//       return;
//     }
//
//     List<String> consumables = await ConsumableStore.load();
//     setState(() {
//       _isAvailable = isAvailable;
//       _products = productDetailResponse.productDetails;
//       _notFoundIds = productDetailResponse.notFoundIDs;
//       _consumables = consumables;
//       _purchasePending = false;
//       _loading = false;
//     });
//   }
//
//   @override
//   void dispose() {
//     if (Platform.isIOS) {
//       var iosPlatformAddition = _inAppPurchase.getPlatformAddition<InAppPurchaseIosPlatformAddition>();
//       iosPlatformAddition.setDelegate(null);
//     }
//     _subscription.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<Widget> stack = [];
//     if (_queryProductError == null) {
//       stack.add(
//         ListView(
//           children: [
//             _buildProductList(),
//             // _buildConsumableBox(),
//             //_buildRestoreButton(),
//           ],
//         ),
//       );
//     } else {
//       stack.add(Center(
//         child: Text(_queryProductError!),
//       ));
//     }
//     if (_purchasePending) {
//       stack.add(
//         Stack(
//           children: [
//             Opacity(
//               opacity: 0.3,
//               child: const ModalBarrier(dismissible: false, color: Colors.grey),
//             ),
//             Center(
//               child: CircularProgressIndicator(),
//             ),
//           ],
//         ),
//       );
//     }
//
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('IAP Example'),
//         ),
//         body: Stack(
//           children: stack,
//         ),
//       ),
//     );
//   }
//
//   Card _buildProductList() {
//     if (_loading) {
//       return Card(child: (ListTile(leading: CircularProgressIndicator(), title: Text('Fetching products...'))));
//     }
//     if (!_isAvailable) {
//       return Card();
//     }
//     List<ListTile> productList = <ListTile>[];
//     if (_notFoundIds.isNotEmpty) {
//       productList.add(ListTile(
//           title: Text('[${_notFoundIds.join(", ")}] not found', style: TextStyle(color: ThemeData.light().errorColor)),
//           subtitle: Text('This app needs special configuration to run. Please see example/README.md for instructions.')));
//     }
//
//     // This loading previous purchases code is just a demo. Please do not use this as it is.
//     // In your app you should always verify the purchase data using the `verificationData` inside the [PurchaseDetails] object before trusting it.
//     // We recommend that you use your own server to verify the purchase data.
//     Map<String, PurchaseDetails> purchases = Map.fromEntries(_purchases.map((PurchaseDetails purchase) {
//       if (purchase.pendingCompletePurchase) {
//         _inAppPurchase.completePurchase(purchase);
//       }
//       return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
//     }));
//     productList.addAll(_products.map(
//       (ProductDetails productDetails) {
//         PurchaseDetails? previousPurchase = purchases[productDetails.id];
//         return ListTile(
//             title: Text(
//               productDetails.title,
//             ),
//             subtitle: Text(
//               productDetails.description,
//             ),
//             trailing: previousPurchase != null
//                 ? IconButton(onPressed: () => confirmPriceChange(context), icon: Icon(Icons.upgrade))
//                 : TextButton(
//                     child: Text(productDetails.price),
//                     style: TextButton.styleFrom(
//                       backgroundColor: Colors.green[800],
//                       primary: Colors.white,
//                     ),
//                     onPressed: () {
//                       late PurchaseParam purchaseParam;
//
//                       if (Platform.isAndroid) {
//                         // NOTE: If you are making a subscription purchase/upgrade/downgrade, we recommend you to
//                         // verify the latest status of you your subscription by using server side receipt validation
//                         // and update the UI accordingly. The subscription purchase status shown
//                         // inside the app may not be accurate.
//                         var oldSubscription;
//                         //_getOldSubscription(productDetails, purchases);
//                         purchaseParam = GooglePlayPurchaseParam(
//                             productDetails: productDetails,
//                             applicationUserName: null,
//                             changeSubscriptionParam: (oldSubscription != null)
//                                 ? ChangeSubscriptionParam(
//                                     oldPurchaseDetails: oldSubscription,
//                                     prorationMode: ProrationMode.immediateWithTimeProration,
//                                   )
//                                 : null);
//                       } else {
//                         purchaseParam = PurchaseParam(
//                           productDetails: productDetails,
//                           applicationUserName: null,
//                         );
//                       }
//
//                       if (productDetails.id == _kConsumableId) {
//                         _inAppPurchase.buyConsumable(purchaseParam: purchaseParam, autoConsume: _kAutoConsume || Platform.isIOS);
//                       } else {
//                         _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
//                       }
//                     },
//                   ));
//       },
//     ));
//
//     return Card(child: Column(children: <Widget>[Divider()] + productList));
//   }
//
//   Card _buildConsumableBox() {
//     if (_loading) {
//       return Card(child: (ListTile(leading: CircularProgressIndicator(), title: Text('Fetching consumables...'))));
//     }
//     if (!_isAvailable || _notFoundIds.contains(_kConsumableId)) {
//       return Card();
//     }
//     final ListTile consumableHeader = ListTile(title: Text('Purchased consumables'));
//     final List<Widget> tokens = _consumables.map((String id) {
//       return GridTile(
//         child: IconButton(
//           icon: Icon(
//             Icons.stars,
//             size: 42.0,
//             color: Colors.orange,
//           ),
//           splashColor: Colors.yellowAccent,
//           onPressed: () => consume(id),
//         ),
//       );
//     }).toList();
//     return Card(
//         child: Column(children: <Widget>[
//       consumableHeader,
//       Divider(),
//       GridView.count(
//         crossAxisCount: 5,
//         children: tokens,
//         shrinkWrap: true,
//         padding: EdgeInsets.all(16.0),
//       )
//     ]));
//   }
//
//   Widget _buildRestoreButton() {
//     if (_loading) {
//       return Container();
//     }
//
//     return Padding(
//       padding: const EdgeInsets.all(4.0),
//       child: Row(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           TextButton(
//             child: Text('Restore purchases'),
//             style: TextButton.styleFrom(
//               backgroundColor: Theme.of(context).primaryColor,
//               primary: Colors.white,
//             ),
//             onPressed: () => _inAppPurchase.restorePurchases(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> consume(String id) async {
//     await ConsumableStore.consume(id);
//     final List<String> consumables = await ConsumableStore.load();
//     setState(() {
//       _consumables = consumables;
//     });
//   }
//
//   void showPendingUI() {
//     setState(() {
//       _purchasePending = true;
//     });
//   }
//
//   void deliverProduct(PurchaseDetails purchaseDetails) async {
//     // IMPORTANT!! Always verify purchase details before delivering the product.
//     if (purchaseDetails.productID == _kConsumableId) {
//       await ConsumableStore.save(purchaseDetails.purchaseID!);
//       List<String> consumables = await ConsumableStore.load();
//       setState(() {
//         _purchasePending = false;
//         _consumables = consumables;
//       });
//     } else {
//       setState(() {
//         _purchases.add(purchaseDetails);
//         _purchasePending = false;
//       });
//     }
//   }
//
//   void handleError(IAPError error) {
//     setState(() {
//       _purchasePending = false;
//     });
//   }
//
//   Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
//     // IMPORTANT!! Always verify a purchase before delivering the product.
//     // For the purpose of an example, we directly return true.
//     return Future<bool>.value(true);
//   }
//
//   void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
//     // handle invalid purchase here if  _verifyPurchase` failed.
//   }
//
//   void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
//     purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
//       if (purchaseDetails.status == PurchaseStatus.pending) {
//         showPendingUI();
//       } else {
//         if (purchaseDetails.status == PurchaseStatus.error) {
//           handleError(purchaseDetails.error!);
//         } else if (purchaseDetails.status == PurchaseStatus.purchased) {
//           bool valid = await _verifyPurchase(purchaseDetails);
//           if (valid) {
//             deliverProduct(purchaseDetails);
//           } else {
//             _handleInvalidPurchase(purchaseDetails);
//             return;
//           }
//         }
//         if (Platform.isAndroid) {
//           if (!_kAutoConsume && purchaseDetails.productID == _kConsumableId) {
//             final InAppPurchaseAndroidPlatformAddition androidAddition = _inAppPurchase.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
//             await androidAddition.consumePurchase(purchaseDetails);
//           }
//         }
//         if (purchaseDetails.pendingCompletePurchase) {
//           await _inAppPurchase.completePurchase(purchaseDetails);
//         }
//       }
//     });
//   }
//
//   Future<void> confirmPriceChange(BuildContext context) async {
//     if (Platform.isAndroid) {
//       final InAppPurchaseAndroidPlatformAddition androidAddition = _inAppPurchase.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
//       var priceChangeConfirmationResult = await androidAddition.launchPriceChangeConfirmationFlow(
//         sku: 'purchaseId',
//       );
//       if (priceChangeConfirmationResult.responseCode == BillingResponse.ok) {
//         ToastUtils.showSuccess(message: "Price change accepted");
//       } else {
//         ToastUtils.showFailed(message: priceChangeConfirmationResult.debugMessage ?? "Price change failed with code ${priceChangeConfirmationResult.responseCode}");
//       }
//     }
//     if (Platform.isIOS) {
//       var iapIosPlatformAddition = _inAppPurchase.getPlatformAddition<InAppPurchaseIosPlatformAddition>();
//       await iapIosPlatformAddition.showPriceConsentIfNeeded();
//     }
//   }
//
// // GooglePlayPurchaseDetails? _getOldSubscription(
// //     ProductDetails productDetails, Map<String, PurchaseDetails> purchases) {
// //   // This is just to demonstrate a subscription upgrade or downgrade.
// //   // This method assumes that you have only 2 subscriptions under a group, 'subscription_silver' & 'subscription_gold'.
// //   // The 'subscription_silver' subscription can be upgraded to 'subscription_gold' and
// //   // the 'subscription_gold' subscription can be downgraded to 'subscription_silver'.
// //   // Please remember to replace the logic of finding the old subscription Id as per your app.
// //   // The old subscription is only required on Android since Apple handles this internally
// //   // by using the subscription group feature in iTunesConnect.
// //   GooglePlayPurchaseDetails? oldSubscription;
// //   if (productDetails.id == _kSilverSubscriptionId &&
// //       purchases[_kGoldSubscriptionId] != null) {
// //     oldSubscription =
// //     purchases[_kGoldSubscriptionId] as GooglePlayPurchaseDetails;
// //   } else if (productDetails.id == _kGoldSubscriptionId &&
// //       purchases[_kSilverSubscriptionId] != null) {
// //     oldSubscription =
// //     purchases[_kSilverSubscriptionId] as GooglePlayPurchaseDetails;
// //   }
// //   return oldSubscription;
// // }
// }
//
// /// Example implementation of the
// /// [`SKPaymentQueueDelegate`](https://developer.apple.com/documentation/storekit/skpaymentqueuedelegate?language=objc).
// ///
// /// The payment queue delegate can be implementated to provide information
// /// needed to complete transactions.
// class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
//   @override
//   bool shouldContinueTransaction(SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
//     return true;
//   }
//
//   @override
//   bool shouldShowPriceConsent() {
//     return false;
//   }
// }

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:intl/intl.dart';
import 'package:shala_yoga/base/utils/common_methods.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';
import 'package:shala_yoga/base/utils/constants/textstyle_constants.dart';
import 'package:shala_yoga/base/utils/toast_utils.dart';
import 'package:shala_yoga/ui/widgets/custom_button.dart';

class SubscribeScreen extends StatefulWidget {
  @override
  _SubscribeScreenState createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends State<SubscribeScreen> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  final String _productMonthly = 'com.app.shalaonline.test2';
  final String _productHalfYearly = 'com.app.shalaonline.test1';
  final String _productAnnual = 'com.app.shalaonline.test';

  bool _available = true;
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  List<InApp>? subscriptionList = [];
  bool selected = false;
  int? selectedIndex;
  List<String> showText = ['Unlimited access to all our yoga and meditation', 'Original Arabic & English classes', 'High quality video and audio content', 'Weekly new releases'];

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated = _inAppPurchase.purchaseStream;

    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      setState(() {
        _purchases.addAll(purchaseDetailsList);
        _listenToPurchaseUpdated(purchaseDetailsList);
      });
    }, onDone: () {
      _subscription!.cancel();
    }, onError: (error) {
      _subscription!.cancel();
    });

    _initialize();

    super.initState();
  }

  @override
  void dispose() {
    _subscription!.cancel();
    super.dispose();
  }

  void _initialize() async {
    _available = await _inAppPurchase.isAvailable();

    List<ProductDetails> products = await _getProducts(
      productIds: Set<String>.from(
        [_productMonthly, _productHalfYearly, _productAnnual],
      ),
    );

    for (int i = 0; i < products.length; i++) {
      subscriptionList!.add(InApp(productDetails: products[i], isOffer: false));
    }

    setState(() {
      _products = products;
    });
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      switch (purchaseDetails.status) {
        case PurchaseStatus.pending:
          //  _showPendingUI();
          break;
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          // bool valid = await _verifyPurchase(purchaseDetails);
          // if (!valid) {
          //   _handleInvalidPurchase(purchaseDetails);
          // }
          break;
        case PurchaseStatus.error:
          print(purchaseDetails.error!);
          // _handleError(purchaseDetails.error!);
          break;
        default:
          break;
      }

      if (purchaseDetails.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchaseDetails);
      }
    });
  }

  Future<List<ProductDetails>> _getProducts({required Set<String> productIds}) async {
    ProductDetailsResponse response = await _inAppPurchase.queryProductDetails(productIds);

    return response.productDetails;
  }

  ListTile _buildProduct({required ProductDetails product}) {
    return ListTile(
      leading: Icon(Icons.attach_money),
      title: Text('${product.title} - ${product.price}'),
      subtitle: Text(product.description),
      trailing: ElevatedButton(
        onPressed: () {
          _subscribe(product: product);
        },
        child: Text(
          'Subscribe',
        ),
      ),
    );
  }

  ListTile _buildPurchase({required PurchaseDetails purchase}) {
    if (purchase.error != null) {
      return ListTile(
        title: Text('${purchase.error}'),
        subtitle: Text(purchase.status.toString()),
      );
    }

    String? transactionDate;
    if (purchase.status == PurchaseStatus.purchased) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(
        int.parse(purchase.transactionDate!),
      );
      transactionDate = ' @ ' + DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
    }

    return ListTile(
      title: Text('${purchase.productID} ${transactionDate ?? ''}'),
      subtitle: Text(purchase.status.toString()),
    );
  }

  void _subscribe({required ProductDetails product}) {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    _inAppPurchase.buyNonConsumable(
      purchaseParam: purchaseParam,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: _available
          ? SingleChildScrollView(
              child: Container(
                  child: Column(children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset('assets/shala_tumbnail.jpg', fit: BoxFit.fill),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: ColorRes.white,
                                )),
                            Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.access_time,
                                  color: ColorRes.white,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: ColorRes.white,
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Container(
                                margin: EdgeInsetsDirectional.only(top: 43),
                                padding: EdgeInsetsDirectional.all(15),
                                decoration: BoxDecoration(
                                  color: ColorRes.white.withOpacity(0.20),
                                  border: Border.all(color: ColorRes.white),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.play_arrow_rounded,
                                    color: ColorRes.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                  ),
                  PositionedDirectional(
                    bottom: -20,
                    child: Container(
                      padding: const EdgeInsetsDirectional.only(start: 34, end: 34, top: 24, bottom: 14),
                      child: Text("THIS IS A PREMIUM VIDEO PLEASE SUBSCRIBE TO WATCH", style: TextStyles.SB18FF),
                      // height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        color: ColorRes.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (c, i) {
                          return SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: 4,
                        itemBuilder: (c, i) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [Icon(Icons.circle, size: 8, color: ColorRes.primaryColor), SizedBox(width: 5), Flexible(child: Text(showText[i]))],
                          );
                        }),
                    SizedBox(height: 30),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (c, i) {
                          return GestureDetector(
                            onTap: () {
                              for (var j = 0; j < subscriptionList!.length; j++) {
                                if (i != j) {
                                  subscriptionList![j].selected = false;
                                } else {
                                  selectedIndex = i;
                                  subscriptionList![i].selected = true;
                                }
                              }
                              setState(() {});
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: screenWidth(context: context),
                                  height: 60,
                                  alignment: AlignmentDirectional.center,
                                  decoration: BoxDecoration(
                                    color: subscriptionList![i].selected! ? ColorRes.white : ColorRes.greyText.withOpacity(0.15),
                                    border: subscriptionList![i].selected! ? Border.all(color: ColorRes.primaryColor) : null,
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        subscriptionList![i].productDetails!.rawPrice.toStringAsFixed(2) + ' ' + subscriptionList![i].productDetails!.currencyCode,
                                        style: selected ? TextStyles.R1578 : TextStyles.R1575,
                                      ),
                                      Text(
                                        subscriptionList![i].productDetails!.description,
                                        style: selected ? TextStyles.R1578 : TextStyles.R1575,
                                      ),
                                    ],
                                  ),
                                ),
                                subscriptionList![i].isOffer!
                                    ? PositionedDirectional(
                                        end: 10,
                                        top: -5,
                                        child: Container(
                                          padding: const EdgeInsetsDirectional.only(start: 19, end: 19, top: 3, bottom: 3),
                                          decoration: BoxDecoration(
                                            color: ColorRes.primaryColor,
                                            borderRadius: BorderRadius.circular(11),
                                          ),
                                          child: Text(
                                            "BEST VALUE",
                                            style: TextStyles.SB10FF,
                                          ),
                                        ))
                                    : Container(),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (c, i) => SizedBox(
                              height: 30,
                            ),
                        itemCount: subscriptionList!.length),
                    SizedBox(height: 11),
                    Text(
                      "Cancel anytime",
                      style: TextStyles.L1275,
                    ),
                    SizedBox(height: 30),
                    CustomButton(
                        onTap: () {
                          if (selectedIndex == null) {
                            ToastUtils.showFailed(message: 'Please select a subscription');
                          } else {
                            _subscribe(product: subscriptionList![selectedIndex!].productDetails!);
                          }
                        },
                        buttonText: "SUBSCRIBE",
                        backgroundColor: ColorRes.primaryColor,
                        foregroundColor: ColorRes.primaryColor,
                        borderColor: Colors.transparent,
                        textStyle: TextStyles.SB18FF),
                    CustomButton(
                        onTap: () {},
                        buttonText: "BROWSE OTHER CLASSES",
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.transparent,
                        borderColor: Colors.transparent,
                        textStyle: TextStyles.R1575),
                    SizedBox(height: 34)
                  ],
                ),
              ),
            ])))
          : Center(
              child: Text('The Store Is Not Available'),
            ),
    ));
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('In App Purchase 1.0.8'),
        ),
        body: _available
            ? Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Current Products ${_products.length}'),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: _products.length,
                          itemBuilder: (context, index) {
                            return _buildProduct(
                              product: _products[index],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Past Purchases: ${_purchases.length}'),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _purchases.length,
                            itemBuilder: (context, index) {
                              return _buildPurchase(
                                purchase: _purchases[index],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Center(
                child: Text('The Store Is Not Available'),
              ),
      );
    }
  }
}

class InApp {
  ProductDetails? productDetails;
  bool? selected;
  bool? isOffer;

  InApp({this.isOffer = false, this.selected = false, this.productDetails});
}
