import 'package:flutter/material.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';
import 'package:shala_yoga/base/utils/constants/textstyle_constants.dart';

class FilterSelected extends StatelessWidget {

  final String filterSelector;

  FilterSelected({required this.filterSelector});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorRes.greyText.withOpacity(0.25),
        borderRadius: BorderRadius.circular(23.5),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: 22, end: 22,
            top: 5, bottom: 5),
        child: Text(
          filterSelector, style: TextStyles.R14FF,
        ),
      ),
    );
  }
}
