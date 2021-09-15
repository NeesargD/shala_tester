import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../base/utils/constants/textstyle_constants.dart';
import 'package:shala_yoga/ui/widgets/custom_button.dart';
import '../../../base/utils/constants/color_constant.dart';
import '../../../base/utils/constants/image_constant.dart';

class SignupScreen extends StatefulWidget {
  final Function onTap;

  SignupScreen({required this.onTap});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: 20, end: 20),
      child: Column(
        children: [
          const SizedBox(height: 30),
          TextFormField(
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorRes.primaryColor),
                ),
                hintText: 'Name',
                hintStyle: TextStyles.R1575),
          ),
          const SizedBox(height: 30),
          TextFormField(
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorRes.primaryColor),
                ),
                hintText: 'Email',
                hintStyle: TextStyles.R1575),
          ),
          const SizedBox(height: 30),
          TextFormField(
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorRes.primaryColor),
                ),
                hintText: 'Phone (Optional)',
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
          const SizedBox(height: 25),
          CustomButton(
              textStyle: TextStyles.SB18FF,
              borderColor: ColorRes.primaryColor,
              buttonText: 'CREATE ACCOUNT',
              foregroundColor: ColorRes.primaryColor,
              onTap: () {},
              backgroundColor: ColorRes.primaryColor),
          const SizedBox(height: 25),
          TextButton(
              onPressed: () {
                widget.onTap(true);
              },
              child: Text('I ALREADY HAVE AN ACCOUNT',
                  style: TextStyles.R1575)),
          const SizedBox(height: 30),
           Row(children: <Widget>[
            Expanded(
              child: Divider(color: ColorRes.greyText),
            ),
            Text('OR', style: TextStyles.R1575),
            Expanded(
              child: Divider(color: ColorRes.greyText),
            ),
          ]),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('SIGN UP USING', style: TextStyles.R1575),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: ColorRes.white,
                    border: Border.all(color: ColorRes.greyText),
                  ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.all(14),
                        child: SvgPicture.asset(ImageRes.shalaThumbnail),
                      )),
              const SizedBox(width: 10),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: ColorRes.white,
                    border: Border.all(color: ColorRes.greyText),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(start: 12, end: 12,
                        top:10, bottom: 10),
                    child: SvgPicture.asset(ImageRes.shalaThumbnail),
                  )),
            ],
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
