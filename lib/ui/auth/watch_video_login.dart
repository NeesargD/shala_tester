import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shala_yoga/base/utils/localization/app_localizations.dart';
import 'package:shala_yoga/blocs/auth_bloc/login_bloc/login_bloc.dart';
import 'package:shala_yoga/blocs/auth_bloc/registration_bloc/registration_bloc.dart';
import '../../base/utils/constants/textstyle_constants.dart';
import '../../../base/utils/constants/color_constant.dart';
import '../../../base/utils/constants/image_constant.dart';
import 'signin_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                        Image.asset(ImageRes.shalaThumbnail, fit: BoxFit.fill),
                        Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.arrow_back, color:
                                      ColorRes.white,)),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.access_time,color:
                                        ColorRes.white,)),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.favorite_border,color:
                                      ColorRes.white,)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      margin: EdgeInsetsDirectional.only(top: 43),
                                      padding: EdgeInsetsDirectional.all(15),
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
                              padding: const EdgeInsetsDirectional.only(
                                  start: 34, end: 34, top: 24, bottom: 8),
                              child: Text(AppLocalizations.of(context)!.translate("to_watch_video_sign_in"),
                                  style: TextStyles.SB18FF),
                            ),
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
                    isSelected.value ? BlocProvider(
                      create: (context) => LoginBloc(),
                      child: SignInScreen(
                        onTap: onTap,
                      ),
                    )
                        : BlocProvider(
                      create: (context) => RegistrationBloc(),
                      child: SignupScreen(
                        onTap: onTap,
                      ),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
  void onTap(bool isValue) {
    isSelected.value = isValue;
    setState(() {});
  }
}
