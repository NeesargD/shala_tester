import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shala_yoga/base/utils/common_methods.dart';
import 'package:shala_yoga/base/utils/toast_utils.dart';
import '../../base/utils/constants/textstyle_constants.dart';
import '../../base/utils/localization/app_localizations.dart';
import '../../base/utils/navigation/navigation_utils.dart';
import '../../blocs/auth_bloc/login_bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/custom_button.dart';
import '../../../base/utils/constants/color_constant.dart';
import '../../../base/utils/constants/image_constant.dart';

class SignInScreen extends StatefulWidget {
  final Function onTap;

  SignInScreen({required this.onTap});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final usernameController1 = TextEditingController();
  final passwordController1 = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void clearText() {
    usernameController1.clear();
    passwordController1.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          EasyLoading.dismiss();
          ToastUtils.showSuccess(message: state.message);
          NavigationUtils.pop(context);
        }
        if (state is LoginLoading) {
          EasyLoading.show();
        }
        if (state is LoginFailure) {
          EasyLoading.dismiss();
          ToastUtils.showFailed(message: state.message);
        }
      },
      child: Form(
        key: formKey,
        child: Container(
          margin: EdgeInsetsDirectional.only(start: 20, end: 20),
          child: Column(
            children: [
              const SizedBox(height: 48),
              InkWell(
                onTap: handleGoogleSignIn,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: ColorRes.greyText, width: 1),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(top: 14, bottom: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(ImageRes.google),
                          const SizedBox(width: 20),
                          Text(
                            AppLocalizations.of(context)!.translate("login_with_google"),
                            style: TextStyles.R1575,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (Platform.isIOS) const SizedBox(height: 28),
              if (Platform.isIOS)
                InkWell(
                  onTap: () {
                    signInWithApple();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: ColorRes.greyText, width: 1),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(top: 10, bottom: 9),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(ImageRes.apple),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                            Text(
                              AppLocalizations.of(context)!.translate("login_with_apple"),
                              style: TextStyles.R1575,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 46),
              Row(children: <Widget>[
                Expanded(
                  child: Divider(thickness: 1, color: ColorRes.greyText.withOpacity(0.5)),
                ),
                Text(AppLocalizations.of(context)!.translate("or"), style: TextStyles.R1575),
                Expanded(
                  child: Divider(thickness: 1, color: ColorRes.greyText.withOpacity(0.5)),
                ),
              ]),
              const SizedBox(height: 30),
              TextFormField(
                  controller: usernameController1,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: ColorRes.primaryColor),
                      ),
                      hintText: AppLocalizations.of(context)!.translate("email_phone_number"),
                      hintStyle: TextStyles.R1575),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    Pattern pattern = r'^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})|([0-9]{10})+$';
                    RegExp regex = new RegExp(pattern.toString());
                    if (value!.isEmpty) {
                      return "Please enter Email or phone number";
                    } else {
                      if (!regex.hasMatch(value))
                        return 'Enter valid Email or phone number';
                      else
                        return null;
                    }
                  }),
              const SizedBox(height: 30),
              TextFormField(
                controller: passwordController1,
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorRes.primaryColor),
                    ),
                    hintText: AppLocalizations.of(context)!.translate("password"),
                    hintStyle: TextStyles.R1575),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.translate("enter_a_password");
                  }
                  if (value.length < 7 || !RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$").hasMatch(value)) {
                    return AppLocalizations.of(context)!.translate("use_more_characters");
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              Container(
                child: CustomButton(
                    textStyle: TextStyles.SB18FF,
                    borderColor: ColorRes.primaryColor,
                    buttonText: AppLocalizations.of(context)!.translate("log_in"),
                    foregroundColor: ColorRes.primaryColor,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        context.read<LoginBloc>().add(GetLoginDetails(
                              username: usernameController1.text.trim(),
                              password: passwordController1.text.trim(),
                            ));
                      }
                    },
                    backgroundColor: ColorRes.primaryColor),
              ),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    widget.onTap(false);
                  },
                  child: Text(AppLocalizations.of(context)!.translate("create_an_new_account"), style: TextStyles.R1575)),
              const SizedBox(height: 30),
              TextButton(onPressed: () {}, child: Text(AppLocalizations.of(context)!.translate("forgot_password"), style: TextStyles.R1575)),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
