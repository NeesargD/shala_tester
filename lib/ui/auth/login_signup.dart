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
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white.withOpacity(0),
        body: SingleChildScrollView(
                child: ValueListenableBuilder<bool>(
                    valueListenable: isSelected,
                    builder: (context, value, child) {
                      return Column(
                        children: [
                          Container(
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
                                            : TextStyles.L25FF.copyWith(color: ColorRes.white.withOpacity(0.35)))),
                                TextButton(
                                    onPressed: () {
                                      onTap(false);
                                    },
                                    child: Text(
                                        AppLocalizations.of(context)!
                                            .translate("sign_up"),
                                        style: isSelected.value
                                            ? TextStyles.L25FF.copyWith(color: ColorRes.white.withOpacity(0.35))
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
