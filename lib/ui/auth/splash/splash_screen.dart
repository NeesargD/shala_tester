import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shala_yoga/base/utils/constants/image_constant.dart';
import 'package:shala_yoga/base/utils/navigation/navigation_route_constants.dart';
import 'package:shala_yoga/base/utils/navigation/navigation_utils.dart';
import '../../../base/extensions/scaffold_extension.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //Variables
  bool performLogoTransition = false;

  //Lifecycle Methods
  @override
  void initState() {
    super.initState();
    startTime();
  }

  //Builder Method
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchOutCurve: Curves.easeInOutCubic,
      switchInCurve: Curves.fastLinearToSlowEaseIn,
      transitionBuilder: (Widget child, Animation<double> animation) =>
          SlideTransition(
        position: Tween<Offset>(begin: Offset(-10, 0), end: Offset(0.35, 0.0))
            .animate(animation),
        child: child,
      ),
      duration: Duration(milliseconds: 500),
      child: !performLogoTransition
          ? Container()
          : Align(
              alignment: Alignment.centerLeft,
              child: SvgPicture.asset(
                ImageRes.icAppLogo
              ),
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
          } else if (timer.tick == 3) {
            NavigationUtils.pushReplacement(context, routeIntro);
            // Your Navigation
            this.dispose();
          }
        },
      );
}
