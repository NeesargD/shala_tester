import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shala_yoga/base/utils/common_methods.dart';
import 'package:shala_yoga/base/utils/constants/image_constant.dart';
import 'package:shala_yoga/base/utils/localization/app_localizations.dart';
import 'package:shala_yoga/base/utils/navigation/navigation_route_constants.dart';
import 'package:shala_yoga/base/utils/navigation/navigation_utils.dart';

import 'common_list_tile_widget.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(27, 42, 27, 0),
      child: Column(
        children: [
          CommonListTileWidget(
              titleText:
                  AppLocalizations.of(context)!.translate('subscription'),
              imagePath: ImageRes.bottom_sheet_subscription,
              onTap: () {
                NavigationUtils.push(context, routeSubscription);
              }),
          CommonListTileWidget(
              titleText: AppLocalizations.of(context)!.translate('about_us'),
              imagePath: ImageRes.bottom_sheet_about_us,
              onTap: () {
                launchURL('https://www.shalaonline.com/app/en/about-us');
              }),
          CommonListTileWidget(
              titleText: AppLocalizations.of(context)!.translate("settings"),
              imagePath: ImageRes.bottom_sheet_setting,
              onTap: () {
                NavigationUtils.push(context, routeSetting);
              }),
          CommonListTileWidget(
              titleText: AppLocalizations.of(context)!.translate("log_out"),
              imagePath: ImageRes.bottom_sheet_setting,
              onTap: () {}),
        ],
      ),
    );
  }
}
