import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../base/utils/constants/textstyle_constants.dart';
import 'signin_screen.dart';
import 'signup_screen.dart';
import '../../../base/utils/constants/image_constant.dart';
import '../../../base/utils/constants/color_constant.dart';

class LoginSignupScreen extends StatefulWidget {
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  ValueNotifier<bool> isSelected = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: ValueListenableBuilder<bool>(
                valueListenable: isSelected,
                builder: (context, value, child) {
                  return Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Image.asset(ImageRes.yogaPosture, fit: BoxFit.fill),
                          Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.only(top: 20),
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.arrow_back,
                                            color: ColorRes.white,
                                            size: 30,
                                          )),
                                      Spacer(),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.access_time,
                                            color: ColorRes.white,
                                            size: 30,
                                          )),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.favorite_border,
                                            color: ColorRes.white,
                                            size: 30,
                                          )),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        margin: EdgeInsetsDirectional.only(top: 43),
                                        decoration: BoxDecoration(
                                          color: ColorRes.white.withOpacity(0.20),
                                          border: Border.all(color: ColorRes.white),
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.play_arrow_rounded,
                                            color: ColorRes.white,
                                            size: 25,
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
                              child: Padding(
                                  padding: const EdgeInsetsDirectional.only(start: 30, end: 30, top: 20, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            onTap(true);
                                          },
                                          child: Text('login', style: isSelected.value ? TextStyles.SB25FF : TextStyles.L25FF)),
                                      TextButton(
                                          onPressed: () {
                                            onTap(false);
                                          },
                                          child: Text('signup', style: isSelected.value ? TextStyles.L25FF : TextStyles.SB25FF))
                                    ],
                                  )),
                              height: MediaQuery.of(context).size.height * 0.1,
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
                      isSelected.value
                          ? SignInScreen(
                              onTap: onTap,
                            )
                          : SignupScreen(
                              onTap: onTap,
                            )
                    ],
                  );
                })),
      ),
    );
  }

  void onTap(bool isValue) {
    isSelected.value = isValue;
    setState(() {});
  }
}
