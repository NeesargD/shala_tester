import 'package:flutter/material.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';
import 'package:shala_yoga/base/utils/constants/textstyle_constants.dart';

class FilterSelected extends StatelessWidget {
  final String filterSelector;
  final VoidCallback onTap;
  final bool isSelected;

  FilterSelected({required this.filterSelector, required this.onTap, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsetsDirectional.only(start: 20, end: 20, top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: isSelected ? ColorRes.primaryColor : ColorRes.greyText.withOpacity(0.25),
          borderRadius: BorderRadius.circular(23.5),
        ),
        child: Text(
          filterSelector,
          style: TextStyles.R14FF,
        ),
      ),
    );
  }
}
