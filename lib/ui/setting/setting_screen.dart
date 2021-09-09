import 'package:flutter/material.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';
import 'package:shala_yoga/base/utils/constants/image_constant.dart';
import 'package:shala_yoga/base/utils/constants/textstyle_constants.dart';
import 'package:shala_yoga/base/utils/localization/app_localizations.dart';
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
        title: Text(AppLocalizations.of(context)!.translate("settings"), style: TextStyles.L2075),
        backgroundColor: ColorRes.appBarColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(27, 32, 27, 0),
          child: Column(
            children: [
              CommonListTileWidget(
                  titleText: AppLocalizations.of(context)!.translate("my_account"),
                  imagePath: ImageRes.setting_my_account,
                  onTap: () {
                    NavigationUtils.push(context, routeMyAccount);
                  }),
              CommonListTileWidget(
                  titleText: AppLocalizations.of(context)!.translate
                    ("time_zone"), imagePath: ImageRes.setting_timezone,
                  onTap: () {}),
              CommonListTileWidget(
                  titleText: AppLocalizations.of(context)!.translate
                    ("language"), imagePath: ImageRes.setting_language,
                  onTap: ()
              {
                NavigationUtils.push(context, routeLanguage);
              }),
              CommonListTileWidget(
                  titleText: AppLocalizations.of(context)!.translate
                    ("notification"),
                  imagePath: ImageRes.setting_notifications,
                  onTap: () {
                    NavigationUtils.push(context, routeNotification);
                  }),
              SizedBox(height: 38),
              CommonListTileWidget(
                  titleText: AppLocalizations.of(context)!.translate("support"),
                  imagePath: ImageRes.setting_support,
                  onTap: () {
                    NavigationUtils.push(context, routeSupportScreen);
                  }),
              CommonListTileWidget(
                  titleText: AppLocalizations.of(context)!.translate
                    ("terms&condition"),
                  imagePath: ImageRes.setting_terms_condition,
                  onTap: () {}),
              CommonListTileWidget(
                  titleText: AppLocalizations.of(context)!.translate("privacy_policy"), imagePath: ImageRes
                  .setting_privacy_policy,
                  onTap: () {}),
              CommonListTileWidget(
                  titleText: AppLocalizations.of(context)!.translate('about'), imagePath: ImageRes
                  .setting_about, onTap: ()
              {}),
              CommonListTileWidget(
                  titleText: AppLocalizations.of(context)!.translate
                    ('invite_friends'), imagePath: ImageRes
                  .setting_invite_friends,
                  onTap: () {}),
              SizedBox(height: 35),
              CustomButton(
                onTap: () {},
                buttonText: AppLocalizations.of(context)!.translate('log_out'),
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
