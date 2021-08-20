import 'package:flutter/material.dart';
import '../utils/constants/app_constant.dart';

extension ScaffoldExtension on Widget {
  SafeArea baseScaffold({required BuildContext context}) {
    getScreenSize(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: this,
      ),
    );
  }

  Dialog dialogContainer() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 20.0,
      insetPadding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        height: 350,
        padding: EdgeInsets.all(20.0),
        child: this,
      ),
    );
  }
}
