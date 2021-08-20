import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../base/utils/constants/color_constant.dart';
import '../../base/utils/constants/image_constant.dart';
import '../../base/utils/constants/textstyle_constants.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorRes.primaryColor,
      selectedLabelStyle: TextStyles.R1175,
      iconSize: 20,
      unselectedLabelStyle: TextStyles.R1075,
      unselectedItemColor: ColorRes.greyText,
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            ImageRes.home,
            height: 20,
            width: 20,
            fit: BoxFit.contain,
          ),
          label: 'HOME',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            ImageRes.play,
            height: 20,
            width: 20,
            fit: BoxFit.contain,
          ),
          label: 'CLASSES',
        ),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              ImageRes.programs,
              height: 20,
              width: 20,
              fit: BoxFit.contain,
            ),
            label: 'PROGRAMS'),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              ImageRes.yogaPosture,
              height: 20,
              width: 20,
              fit: BoxFit.contain,
            ),
            label: 'INSTRUCTORS'),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              ImageRes.myPractice,
              height: 20,
              width: 20,
              fit: BoxFit.contain,
            ),
            label: 'MY PRACTICE'),
      ],
    );
  }
}
