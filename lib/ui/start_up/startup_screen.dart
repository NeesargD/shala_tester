import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shala_yoga/base/utils/common_methods.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';
import 'package:shala_yoga/base/utils/constants/textstyle_constants.dart';
import 'package:shala_yoga/base/utils/localization/app_localizations.dart';
import 'package:shala_yoga/base/utils/navigation/navigation_route_constants.dart';
import 'package:shala_yoga/base/utils/navigation/navigation_utils.dart';
import 'package:shala_yoga/ui/widgets/custom_button.dart';

class StartUpScreen extends StatefulWidget {
  const StartUpScreen({Key? key}) : super(key: key);

  @override
  _StartUpScreenState createState() => _StartUpScreenState();
}

class _StartUpScreenState extends State<StartUpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: screenWidth(context: context),
            // height: screenHeight(context: context),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 50),
                Center(
                  child: SvgPicture.asset(
                    'assets/shala_logo_ar.svg',
                    width: 100,
                    height: 150,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(start: 71,end: 89,top: 52,bottom: 11),
                  child: Text(
                      AppLocalizations.of(context)!.translate("not_sure_which_program_is_right"),
                      style: TextStyles.SB3075,
                      textAlign: TextAlign.left),
                ),
                Center(
                  child: SvgPicture.asset(
                    'assets/startup_screen_image_with_text.svg',
                    width: MediaQuery.of(context).size.width * 0.70,
                    height: MediaQuery.of(context).size.height * 0.30,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  onTap: () {
                    NavigationUtils.push(context, routeQuestionAnswer);
                  },
                  buttonText:
                      AppLocalizations.of(context)!.translate('start_quiz'),
                  backgroundColor: ColorRes.green,
                  foregroundColor: ColorRes.white,
                  borderColor: ColorRes.green,
                  textStyle: TextStyles.R18FF,
                ),
                CustomButton(
                  onTap: () {
                    NavigationUtils.pushReplacement(context, routeDashboard,
                        arguments: {'index': 0});
                  },
                  buttonText: AppLocalizations.of(context)!.translate('browse_all_classes'),
                  backgroundColor: ColorRes.white,
                  foregroundColor: ColorRes.white,
                  borderColor: ColorRes.greyBorder,
                  textStyle: TextStyles.R1875,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
