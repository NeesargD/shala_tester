import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shala_yoga/base/utils/constants/image_constant.dart';
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
          CommonListTileWidget(titleText: "SUBSCRIPTION",
              imagePath: ImageRes.bottom_sheet_subscription, onTap: (){}),
          CommonListTileWidget(titleText: "ABOUT US",
              imagePath: ImageRes.bottom_sheet_about_us, onTap: (){}),
          CommonListTileWidget(titleText: "SETTINGS",
              imagePath: ImageRes.bottom_sheet_setting, onTap: (){
                NavigationUtils.push(context, routeSetting);
              }),
          CommonListTileWidget(titleText: "LOGOUT",
              imagePath: ImageRes.bottom_sheet_setting, onTap: (){}),
        ],
      ),
    );
  }
}
