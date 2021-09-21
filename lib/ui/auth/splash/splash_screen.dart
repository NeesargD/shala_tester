import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shala_yoga/base/utils/constants/app_state.dart';
import 'package:shala_yoga/base/utils/preference.dart';
import 'package:shala_yoga/base/utils/preference_utils.dart';
import '../../../base/utils/constants/image_constant.dart';
import '../../../base/utils/constants/string_res.dart';
import '../../../base/utils/navigation/navigation_route_constants.dart';
import '../../../base/utils/navigation/navigation_utils.dart';
import '../../../base/extensions/scaffold_extension.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //Variables
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  bool performLogoTransition = false;
  var userId;

  //Lifecycle Methods
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      initDynamicLinks();
      getDeviceInfo();
      startTime();
    });
  }

  void getDeviceInfo() async {
    String id = "";
    userId = await Preferences.getIntData(AppState.loginUser);
    if (Platform.isAndroid) {
      final deviceAndroid = await deviceInfo.androidInfo;
      id = deviceAndroid.androidId!;
      print('Running on $id');
    } else {
      final deviceIos = await deviceInfo.iosInfo;
      id = deviceIos.identifierForVendor!;
      print('Running on $id');
    }
    appState.deviceId = id;
    appState.userId = userId;
  }

  // link open and user refer code get
  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      final Uri? deepLink = dynamicLink?.link;
      print("....>>>>>>>......$deepLink");
      if (deepLink != null) {
        print("............$deepLink");
        // Navigator.pushNamed(context, deepLink.path);
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      // Navigator.pushNamed(context, deepLink.path);
    }
    print("....>>>>>>>......$deepLink");
  }

  //Builder Method
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchOutCurve: Curves.easeInOutCubic,
      switchInCurve: Curves.fastLinearToSlowEaseIn,
      transitionBuilder: (Widget child, Animation<double> animation) => SlideTransition(
        position: Tween<Offset>(begin: Offset(-10, 0), end: Offset(0.35, 0.0)).animate(animation),
        child: child,
      ),
      duration: Duration(milliseconds: 500),
      child: !performLogoTransition
          ? Container()
          : Align(
              alignment: Alignment.centerLeft,
              child: SvgPicture.asset(ImageRes.icAppLogo),
            ),
    ).baseScaffold(context: context);
  }

  //Methods
  Timer startTime() => Timer.periodic(
        Duration(seconds: 1),
        (timer) {
          if (timer.tick == 1) {
            setState(() {
              performLogoTransition = !performLogoTransition;
            });
          } else if (timer.tick == 5) {
            if (getBool("intro")) {
              if (getBool("quizSubmitted")) {
                NavigationUtils.pushAndRemoveUntil(context, routeDashboard,
                    arguments: {"index": 0});
              } else {
                NavigationUtils.pushReplacement(context, routeStartUpScreen);
              }
            } else if (appState.userId != null) {
              NavigationUtils.pushAndRemoveUntil(context, routeDashboard, arguments: {"index": 0});
            } else {
              NavigationUtils.pushReplacement(context, routeIntro);
            }
            this.dispose();
          }
        },
      );
}
