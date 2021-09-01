import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../base/utils/constants/color_constant.dart';
import '../../base/utils/constants/textstyle_constants.dart';

class CommonListTileWidget extends StatelessWidget {
  final String titleText;
  final String imagePath;
  final double itemSpace;
  final VoidCallback onTap;

  const CommonListTileWidget(
      {Key? key, required this.titleText, required this.imagePath, required this.onTap, this.itemSpace = 15})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorRes.primaryColor,
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(imagePath),
      ),
      title: Text(
        titleText,
        style: TextStyles.R1875,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: ColorRes.greyText,
      ),
      dense: true,
      contentPadding: EdgeInsetsDirectional.only(start: 0, end: 0, bottom: itemSpace, top: itemSpace),
    );
  }
}
