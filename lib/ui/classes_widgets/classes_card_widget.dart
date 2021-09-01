import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shala_yoga/base/utils/common_methods.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';
import 'package:shala_yoga/base/utils/constants/image_constant.dart';
import 'package:shala_yoga/base/utils/constants/textstyle_constants.dart';

class ClassesCardWidget extends StatelessWidget {
  final String image;
  final String day;
  final String title;
  final String style;
  final String level;
  final String duration;
  final String language;
  bool? isLock;

  ClassesCardWidget(
      {required this.image,
      required this.day,
      required this.title,
      required this.style,
      required this.level,
      required this.duration,
      required this.language,
      this.isLock});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: ColorRes.greyIcon, offset: Offset(0, 5), blurRadius: 10)
        ],
        color: ColorRes.white,
      ),
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Expanded(
        flex: 1,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 120,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(image,
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(top: 6, start: 6),
                    child: Container(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 5),
                      decoration: BoxDecoration(
                        color: isLock == true
                            ? ColorRes.premiumBackground
                            : ColorRes.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(isLock == true ? "PREMIUM" : "FREE",
                          style: TextStyles.R12FF),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                    top: 10, end: 10, start: 10, bottom: 11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(day, style: TextStyles.SB1078),
                        Spacer(),
                        Icon(Icons.mic, color: ColorRes.greyIcon),
                        CircleAvatar(
                          backgroundColor: ColorRes.greyIcon,
                          radius: 10,
                          child: Text('${language.substring(0, 2)}',
                              style: TextStyles.R10FF),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          top: 12, bottom: 12, end: 50),
                      child: Text(
                        title,
                        style: TextStyles.SB1475,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(ImageRes.yogaStyle),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(style, style: TextStyles.R1275),
                        SizedBox(width: 30),
                        SvgPicture.asset(ImageRes.levels),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(level, style: TextStyles.R1275),
                        SizedBox(width: 30),
                        SvgPicture.asset(ImageRes.hourGlass),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(duration + "min", style: TextStyles.R1275),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
