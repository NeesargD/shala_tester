import 'package:flutter/material.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';

class SplashItem{
  final String image;
  final String title;
  final String subTitle;
  final Color color;

  const SplashItem({required this.image, required this.title, required this.subTitle, required this
      .color});

}
final splashScreenList = [
  SplashItem(
    title: 'YOGA & MEDITATION',
    subTitle: 'Anytime, Anywhere & in your native language',
    color: ColorRes.primaryColor, image: 'assets/splashscreen1.svg',
  ),
  SplashItem(
    title: 'GUIDED EXPERIENCE',
    subTitle: 'By handpicked certified instructors',
    color: ColorRes.primaryColor, image: 'assets/splashscreen2.svg',
  ),
  SplashItem(
    title: 'TAILORED PROGRAMS',
    subTitle: 'To help you achieve your objectives',
    color: ColorRes.primaryColor, image: 'assets/splashscreen3.svg',
  ),
];
