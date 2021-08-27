import 'package:flutter/material.dart';

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
        centerTitle: true,
        elevation: 0,
        title: Text('Notifications', style: TextStyles.L2075),
        backgroundColor: ColorRes.appBarColor,
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.only(start: 27, end: 27, top: 41),
        child: Column(
          children: [
            Row(
              children: [
                Text("PROMOTIONS AND UPDATES", style: TextStyles.SB1878),
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
              "I would like to receive useful notifications from time to "
              "time to encourage me benefit to the max from Shala recommendations.",
              style: TextStyles.L1875,
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Text("PRIVATE", style: TextStyles.SB1878),
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
              "Get notified whenever necessary: New interesting content and reminders that you care about",
              style: TextStyles.L1875,
            ),
          ],
        ),
      ),
    ));
  }
}
