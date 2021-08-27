import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
              imagePath: ' ', onTap: (){}),
          CommonListTileWidget(titleText: "ABOUT US",
              imagePath: ' ', onTap: (){}),
          CommonListTileWidget(titleText: "SETTINGS",
              imagePath: ' ', onTap: (){
                NavigationUtils.push(context, routeSetting);
              }),
          CommonListTileWidget(titleText: "LOGOUT",
              imagePath: ' ', onTap: (){}),
        ],
      ),
    );
  }
}
