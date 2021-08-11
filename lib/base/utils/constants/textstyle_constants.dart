import 'package:flutter/material.dart';

import 'color_constant.dart';

class TextStyles {
  TextStyles._();

  /// R - Regular
  /// SB - Semi-Bold
  /// Numbers - FontSize
  /// Last - Color Code

  ///BOLD TEXTSTYLES

  static const TextStyle SB11FF = TextStyle(
    inherit: true,
    fontSize: 11.0,
    fontWeight: FontWeight.w600,
    color: ColorRes.white,
  );


  ///REGULAR TEXTSTYLES

  static const TextStyle R6F5 = TextStyle(
    inherit: true,
    fontSize: 6,
    color: ColorRes.white,
  );


}

