import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';
import 'package:shala_yoga/base/utils/constants/textstyle_constants.dart';
import 'package:shala_yoga/ui/widgets/custom_button.dart';

import '../../in_app_purchase_manager.dart';

class InApp {
  String? title;
  bool? selected;
  bool? isOffer;

  InApp({this.isOffer = false, this.selected = false, this.title});
}

class SubscribeScreen extends StatefulWidget {
  const SubscribeScreen({Key? key}) : super(key: key);

  @override
  _SubscribeScreenState createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends State<SubscribeScreen> {
  bool selected = false;
  List<IAPItem>? subList;
  List<InApp>? sList = [];

  @override
  void initState() {
    super.initState();
    dummyData();
    Future.delayed(Duration.zero, () {
      initMethod();
    });
  }

  void dummyData() {
    sList!.add(InApp(title: "16AED / MONTH", selected: true));
    sList!.add(InApp(title: "18AED / MONTH", isOffer: true));
    sList!.add(InApp(title: "20AED / MONTH"));
  }

  void initMethod() async {
    await InAppPurchaseManager().initSubscription();
    subList = await InAppPurchaseManager().getSubscriptionProducts();
  }

  @override
  void dispose() {
    InAppPurchaseManager().endConnection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
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
              padding: const EdgeInsetsDirectional.only(
                  start: 34, end: 34, top: 24, bottom: 14),
              child: Text("THIS IS A PREMIUM VIDEO PLEASE SUBSCRIBE TO WATCH",
                  style: TextStyles.SB18FF),
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
            separatorBuilder: (c,i){
              return SizedBox(height: 10,);
            }, itemCount: 4,
                itemBuilder: (c,i){
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.circle, size: 8, color: ColorRes.primaryColor),
                  SizedBox(width: 5),
                  Text("Unlimited access to all our yoga and meditation")
                ],
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
                      for (var j = 0; j < sList!.length; j++) {
                        if (i != j) {
                          sList![j].selected = false;
                        } else {
                          sList![i].selected = true;
                        }
                      }
                      setState(() {});
                    },
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsetsDirectional.only(
                              start: 120, end: 120, top: 20, bottom: 20),
                          decoration: BoxDecoration(
                            color: sList![i].selected!
                                ? ColorRes.white
                                : ColorRes.greyText.withOpacity(0.15),
                            border: sList![i].selected!
                                ? Border.all(color: ColorRes.primaryColor)
                                : null,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(sList![i].title!,
                              style: selected
                                  ? TextStyles.R1578
                                  : TextStyles.R1575),
                        ),
                        sList![i].isOffer!
                            ? PositionedDirectional(
                                end: 10,
                                top: -5,
                                child: Container(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 19, end: 19, top: 3, bottom: 3),
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
                itemCount: sList!.length),
            SizedBox(height: 11),
            Text(
              "Cancel anytime",
              style: TextStyles.L1275,
            ),
            SizedBox(height: 30),
            CustomButton(
                onTap: () {
                  InAppPurchaseManager().requestSubscription(
                      context: context,
                      productKey: "",
                      onPurchased: (purchasedItem) async {
                        print(purchasedItem);

                        // Trans received of purchased product
                      });
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
    ])))));
  }
}
