import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shala_yoga/base/utils/common_methods.dart';
import '../../base/utils/navigation/navigation_utils.dart';
import '../../base/utils/localization/app_localizations.dart';
import '../../blocs/auth_bloc/registration_bloc/registration_bloc.dart';
import '../../base/utils/constants/textstyle_constants.dart';
import '../widgets/custom_button.dart';
import '../../../base/utils/constants/color_constant.dart';
import '../../../base/utils/constants/image_constant.dart';

class SignupScreen extends StatefulWidget {
  final Function onTap;

  SignupScreen({required this.onTap});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void clearText() {
    emailController.clear();
    nameController.clear();
    phoneNumberController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state is RegistrationSuccess) {
          clearText();
          NavigationUtils.pop(context);
        }
        if (state is RegistrationLoading) {}
        if (state is RegistrationFailure) {
          Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("Registration Failed Please Check Your Credentials")));
          print(state.message);
        }
      },
      child: Form(
        key: formKey,
        child: Container(
          margin: EdgeInsetsDirectional.only(start: 20, end: 20),
          child: Column(
            children: [
              const SizedBox(height: 30),
              TextFormField(
                controller: nameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorRes.primaryColor),
                    ),
                    hintText: AppLocalizations.of(context)!.translate("name"),
                    hintStyle: TextStyles.R1575),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.translate("enter_a_name");
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorRes.primaryColor),
                    ),
                    hintText: AppLocalizations.of(context)!.translate("email"),
                    hintStyle: TextStyles.R1575),
                validator: (value) {
                  if (value!.isEmpty || !RegExp(r'^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+').hasMatch(value)) {
                    return AppLocalizations.of(context)!.translate("enter_a_valid_email");
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: phoneNumberController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorRes.primaryColor),
                    ),
                    hintText: "${AppLocalizations.of(context)!.translate("phone")} (${AppLocalizations.of(context)!.translate("optional")})",
                    hintStyle: TextStyles.R1575),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorRes.primaryColor),
                  ),
                  hintText: AppLocalizations.of(context)!.translate("password"),
                  hintStyle: TextStyles.R1575,
                  errorMaxLines: 2,
                ),
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
              const SizedBox(height: 25),
              CustomButton(
                  textStyle: TextStyles.SB18FF,
                  borderColor: ColorRes.primaryColor,
                  buttonText: AppLocalizations.of(context)!.translate("create_account"),
                  foregroundColor: ColorRes.primaryColor,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      print("success");
                      context.read<RegistrationBloc>().add(GetRegistrationDetails(
                          email: emailController.text.trim(), password: passwordController.text.trim(), name: nameController.text.trim(), phoneNumber: phoneNumberController.text.trim()));
                    }
                  },
                  backgroundColor: ColorRes.primaryColor),
              const SizedBox(height: 25),
              TextButton(
                  onPressed: () {
                    widget.onTap(true);
                  },
                  child: Text(AppLocalizations.of(context)!.translate("already_have_an_account"), style: TextStyles.R1575)),
              const SizedBox(height: 30),
              Row(children: <Widget>[
                Expanded(
                  child: Divider(color: ColorRes.greyText),
                ),
                Text(AppLocalizations.of(context)!.translate("or"), style: TextStyles.R1575),
                Expanded(
                  child: Divider(color: ColorRes.greyText),
                ),
              ]),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.translate("sign_up_using"), style: TextStyles.R1575),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  InkWell(
                    onTap: handleGoogleSignIn,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: ColorRes.white,
                          border: Border.all(color: ColorRes.greyText),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.all(14),
                          child: SvgPicture.asset(ImageRes.google),
                        )),
                  ),
                  const SizedBox(width: 10),
                  if(Platform.isIOS)InkWell(
                    onTap: signInWithApple,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: ColorRes.white,
                          border: Border.all(color: ColorRes.greyText),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(start: 12, end: 12, top: 10, bottom: 10),
                          child: SvgPicture.asset(ImageRes.apple),
                        )),
                  ),
                ],
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
