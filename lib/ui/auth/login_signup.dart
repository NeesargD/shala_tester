import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../base/utils/localization/app_localizations.dart';
import '../../base/utils/navigation/navigation_utils.dart';
import '../../blocs/auth_bloc/login_bloc/login_bloc.dart';
import '../../blocs/auth_bloc/registration_bloc/registration_bloc.dart';
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
                          Image.asset(ImageRes.shalaThumbnail,
                              fit: BoxFit.fill),
                          Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.only(top: 20),
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            NavigationUtils.pop(context);
                                          },
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
                                        margin:
                                            EdgeInsetsDirectional.only(top: 10),
                                        decoration: BoxDecoration(
                                          color:
                                              ColorRes.white.withOpacity(0.20),
                                          border:
                                              Border.all(color: ColorRes.white),
                                          borderRadius:
                                              BorderRadius.circular(100),
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        onTap(true);
                                      },
                                      child: Text(
                                          AppLocalizations.of(context)!
                                              .translate("log_in"),
                                          style: isSelected.value
                                              ? TextStyles.SB25FF
                                              : TextStyles.L25FF)),
                                  TextButton(
                                      onPressed: () {
                                        onTap(false);
                                      },
                                      child: Text(
                                          AppLocalizations.of(context)!
                                              .translate("sign_up"),
                                          style: isSelected.value
                                              ? TextStyles.L25FF
                                              : TextStyles.SB25FF))
                                ],
                              ),
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
                          ? BlocProvider(
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
                })),
      ),
    );
  }

  void onTap(bool isValue) {
    isSelected.value = isValue;
    setState(() {});
  }
}
