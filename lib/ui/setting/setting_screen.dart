import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shala_yoga/base/utils/constants/string_res.dart';
import 'package:shala_yoga/base/utils/localization/app_language.dart';
import 'package:shala_yoga/base/utils/preference.dart';
import 'package:shala_yoga/ui/setting/language/language.dart';
import '../../base/utils/constants/color_constant.dart';
import '../../base/utils/constants/image_constant.dart';
import '../../base/utils/constants/textstyle_constants.dart';
import '../../base/utils/localization/app_localizations.dart';
import '../../base/utils/navigation/navigation_route_constants.dart';
import '../../base/utils/navigation/navigation_utils.dart';
import '../widgets/common_list_tile_widget.dart';
import '../widgets/custom_button.dart';
import '../../base/utils/common_methods.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:share_plus/share_plus.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  var duration = DateTime.now().timeZoneOffset;

  bool isSelected = false;
  String? code;

  Future<void> checkLanguageMode() async {
    code = await Preferences.getData('language_code');
    if (code == 'en' || code == null) {
      isSelected = false;
    } else {
      isSelected = true;
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var abc = getBundleId();
    checkLanguageMode();
    print(abc);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorRes.greyText),
        elevation: 0,
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.translate("settings"),
            style: TextStyles.L2075),
        backgroundColor: ColorRes.appBarColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(27, 32, 27, 0),
          child: Column(
            children: [
              CommonListTileWidget(
                  titleText:
                      AppLocalizations.of(context)!.translate("my_account"),
                  imagePath: ImageRes.setting_my_account,
                  onTap: () {
                    NavigationUtils.push(context, routeMyAccount);
                  }),
              CommonListTileWidget(
                  titleText:
                      AppLocalizations.of(context)!.translate("time_zone"),
                  imagePath: ImageRes.setting_timezone,
                  onTap: () {},
                  timeLanZone: duration.isNegative
                      ? '-${duration.toString().split(":")[0]}:${duration.toString().split(":")[1]}'
                      : '+${duration.toString().split(":")[0]}:${duration.toString().split(":")[1]}' +
                          ' ${DateTime.now().timeZoneName}'),
              CommonListTileWidget(
                  titleText:
                      AppLocalizations.of(context)!.translate("language"),
                  imagePath: ImageRes.setting_language,
                  timeLanZone: isSelected ? 'AR' : "EN",
                  onTap: () {
                    NavigationUtils.push(context, routeLanguage);
                  }),
              CommonListTileWidget(
                  titleText:
                      AppLocalizations.of(context)!.translate("notification"),
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
                  titleText: AppLocalizations.of(context)!
                      .translate("terms&condition"),
                  imagePath: ImageRes.setting_terms_condition,
                  onTap: () {
                    launchURL(
                        'https://www.shalaonline.com/app/en/terms-of-use');
                  }),
              CommonListTileWidget(
                  titleText:
                      AppLocalizations.of(context)!.translate("privacy_policy"),
                  imagePath: ImageRes.setting_privacy_policy,
                  onTap: () {
                    launchURL(
                        'https://www.shalaonline.com/app/en/privacy-policy');
                  }),
              CommonListTileWidget(
                  titleText: AppLocalizations.of(context)!.translate('about'),
                  imagePath: ImageRes.setting_about,
                  onTap: () {
                    launchURL('https://www.shalaonline.com/app/en/about-us');
                  }),
              CommonListTileWidget(
                  titleText:
                      AppLocalizations.of(context)!.translate('invite_friends'),
                  imagePath: ImageRes.setting_invite_friends,
                  onTap: () {
                    generateDynamicLink();
                  }),
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

  // dynamic link share
  void generateDynamicLink() async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://shalaonline.page.link',
      link: Uri.parse('https://shalaonline.page.link/inviteFriend=1'),
      androidParameters: AndroidParameters(
        packageName: 'com.app.shalaonline',
        minimumVersion: 1,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.example.ios',
        minimumVersion: '1.0.1',
        appStoreId: '123456789',
      ),
    );
    final Uri dynamicUrl = await parameters.buildUrl();
    final ShortDynamicLink shortenedLink =
        await DynamicLinkParameters.shortenUrl(
      dynamicUrl,
      DynamicLinkParametersOptions(
          shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable),
    );
    final Uri shortUrl = shortenedLink.shortUrl;
    print(shortUrl);
    print(dynamicUrl);

    Share.share('Shala Online Yoga $shortUrl');
  }
}
