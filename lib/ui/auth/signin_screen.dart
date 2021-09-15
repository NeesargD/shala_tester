import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shala_yoga/base/utils/constants/textstyle_constants.dart';
import 'package:shala_yoga/ui/widgets/custom_button.dart';
import '../../../base/utils/constants/color_constant.dart';
import '../../../base/utils/constants/image_constant.dart';

class SignInScreen extends StatefulWidget {
final Function onTap;

SignInScreen({required this.onTap});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>{

  @override
  Widget build(BuildContext context) {
    return Container(
              margin: EdgeInsetsDirectional.only(start: 20, end: 20),
              child: Column(
                children: [
                  const SizedBox(height: 48),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: ColorRes.greyText,width: 1),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(top:
                        14, bottom: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(ImageRes.hourGlass),
                            const SizedBox(width: 20),
                            Text('Login with Google', style: TextStyles.R1575,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: ColorRes.greyText,width: 1),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(top:
                        10, bottom: 9),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(ImageRes.hourGlass),
                            SizedBox(width: MediaQuery.of(context).size.width
                                * 0.02),
                            Text('Login with Apple', style: TextStyles.R1575,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 46),
                  Row(children: <Widget>[
                    Expanded(
                      child: Divider(
                          thickness: 1, color: ColorRes.greyText.withOpacity(0.5)),
                    ),
                    Text('OR', style: TextStyles.R1575),
                    Expanded(
                      child: Divider(
                          thickness: 1, color: ColorRes.greyText.withOpacity(0.5)),
                    ),
                  ]),
                  const SizedBox(height: 30),
                  TextFormField(
                    onTap: () {},
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: ColorRes.primaryColor),
                        ),
                        hintText: 'Email or Phone number',
                        hintStyle: TextStyles.R1575),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: ColorRes.primaryColor),
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyles.R1575),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    child: CustomButton(
                        textStyle: TextStyles.SB18FF,
                        borderColor: ColorRes.primaryColor,
                        buttonText: 'Login',
                        foregroundColor: ColorRes.primaryColor,
                        onTap: () {

                        },
                        backgroundColor: ColorRes.primaryColor),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                      onPressed: () {
                        widget.onTap(false);
                      },
                      child: Text('CREATE NEW NOW!', style: TextStyles.R1575)),
                  const SizedBox(height: 30),
                  TextButton(
                      onPressed: () {

                      },
                      child: Text('Forgot Password?', style: TextStyles.R1575)),
                  const SizedBox(height: 30),
                ],
              ),
            );
  }
}
