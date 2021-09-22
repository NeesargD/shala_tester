import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shala_yoga/base/utils/constants/string_res.dart';
import 'package:shala_yoga/base/utils/localization/app_language.dart';
import 'package:shala_yoga/base/utils/localization/app_localizations.dart';
import 'package:shala_yoga/base/utils/preference.dart';

import '../../../base/utils/constants/color_constant.dart';
import '../../../base/utils/constants/textstyle_constants.dart';

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
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
    super.initState();
    Future.delayed(Duration.zero, () {
      checkLanguageMode();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: ColorRes.greyText
        ),
        centerTitle: true,
        elevation: 0,
        title: Text(AppLocalizations.of(context)!.translate("language"), style: TextStyles.L2075),
        backgroundColor: ColorRes.appBarColor,
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.only(start: 27, end: 27, top: 41),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.translate('arabic_mode'),
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
                Spacer(),
                Switch.adaptive(
                  onChanged: (value) {
                    if (value) {
                      Provider.of<AppLanguage>(context, listen: false)
                          .changeLanguage(const Locale('ar'));
                      setLanguage('ar');
                    } else {
                      Provider.of<AppLanguage>(context, listen: false)
                          .changeLanguage(const Locale('en'));
                      setLanguage('en');
                    }
                    setState(() {
                      isSelected = value;
                    });
                  },
                  value: isSelected,
                  activeColor: ColorRes.primaryColor,
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }

  void setLanguage(String language) {
    Preferences.saveData(StringRes.selectedLanguage, language);
  }
}
