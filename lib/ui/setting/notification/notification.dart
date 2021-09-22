import 'package:flutter/material.dart';
import 'package:shala_yoga/base/utils/localization/app_localizations.dart';

import '../../../base/utils/constants/color_constant.dart';
import '../../../base/utils/constants/textstyle_constants.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isSelected = false;

  bool isOn = false;

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
        title: Text(AppLocalizations.of(context)!.translate("notification"), style: TextStyles.L2075),
        backgroundColor: ColorRes.appBarColor,
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.only(start: 20, end: 20, top: 41),
        child: Column(
          children: [
            Row(
              children: [
                Text(AppLocalizations.of(context)!.translate('promotions_updates'), style: TextStyles.SB1878),
                Spacer(),
                Switch.adaptive(
                  onChanged: (value) {
                    setState(() {
                      isSelected = value;
                    });
                  },
                  value: isSelected,
                  activeColor: ColorRes.primaryColor,
                )
              ],
            ),
            Text(
              AppLocalizations.of(context)!.translate('would_like_to_receive_notification'),
              style: TextStyles.L1875,
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Text(AppLocalizations.of(context)!.translate('private'), style: TextStyles.SB1878),
                Spacer(),
                Switch.adaptive(
                  onChanged: (value) {
                    setState(() {
                      isOn = value;
                    });
                  },
                  value: isOn,
                  activeColor: ColorRes.primaryColor,
                )
              ],
            ),
            Text(
              AppLocalizations.of(context)!.translate("get_necessary_notification"),
              style: TextStyles.L1875,
            ),
          ],
        ),
      ),
    ));
  }
}
