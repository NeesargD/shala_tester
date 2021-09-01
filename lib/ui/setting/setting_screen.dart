import 'package:flutter/material.dart';
import 'package:shala_yoga/base/utils/common_methods.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';
import 'package:shala_yoga/base/utils/constants/image_constant.dart';
import 'package:shala_yoga/base/utils/constants/textstyle_constants.dart';
import 'package:shala_yoga/base/utils/navigation/navigation_route_constants.dart';
import 'package:shala_yoga/base/utils/navigation/navigation_utils.dart';
import 'package:shala_yoga/ui/widgets/common_list_tile_widget.dart';
import 'package:shala_yoga/ui/widgets/custom_button.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Settings', style: TextStyles.L2075),
        backgroundColor: ColorRes.appBarColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(27, 32, 27, 0),
          child: Column(
            children: [
              CommonListTileWidget(
                  titleText: "MY ACCOUNT",
                  imagePath: ImageRes.setting_my_account,
                  onTap: () {
                    NavigationUtils.push(context, routeMyAccount);
                  }),
              CommonListTileWidget(
                  titleText: "TIME ZONE", imagePath: ImageRes.setting_timezone,
                  onTap: () {}),
              CommonListTileWidget(
                  titleText: "LANGUAGE", imagePath: ImageRes.setting_language,
                  onTap: ()
              {}),
              CommonListTileWidget(
                  titleText: "NOTIFICATIONS",
                  imagePath: ImageRes.setting_notifications,
                  onTap: () {
                    NavigationUtils.push(context, routeNotification);
                  }),
              SizedBox(height: 38),
              CommonListTileWidget(
                  titleText: "SUPPORT",
                  imagePath: ImageRes.setting_support,
                  onTap: () {
                    NavigationUtils.push(context, routeSupportScreen);
                  }),
              CommonListTileWidget(
                  titleText: "TERMS & CONDITIONS",
                  imagePath: ImageRes.setting_terms_condition,
                  onTap: () {}),
              CommonListTileWidget(
                  titleText: "PRIVACY POLICY", imagePath: ImageRes.setting_privacy_policy,
                  onTap: () {}),
              CommonListTileWidget(
                  titleText: "ABOUT", imagePath: ImageRes.setting_about, onTap: () {}),
              CommonListTileWidget(
                  titleText: "INVITE FRIENDS", imagePath: ImageRes.setting_invite_friends,
                  onTap: () {}),
              SizedBox(height: 35),
              CustomButton(
                onTap: () {},
                buttonText: "LOG OUT",
                backgroundColor: ColorRes.greyText,
                foregroundColor: Colors.transparent,
                borderColor: Colors.transparent,
                textStyle: TextStyles.SB18FF,
                height: 46,
                widthPercent: 0.9,
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    ));
  }
}
