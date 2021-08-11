import 'package:flutter/material.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';

class SplashItem{
  final String title;
  final String subTitle;
  final Color color;

  const SplashItem({required this.title, required this.subTitle, required this
      .color});

}
final splashScreenList = [
  SplashItem(
    title: 'YOGA & MEDITATION',
    subTitle: 'Anytime, Anywhere & in your native language',
    color: primaryColor,
  ),
  SplashItem(
    title: 'GUIDED EXPERIENCE',
    subTitle: 'By handpicked certified instructors',
    color: primaryColor,
  ),
  SplashItem(
    title: 'TAILORED PROGRAMS',
    subTitle: 'To help you achieve your objectives',
    color: primaryColor,
  ),
];
