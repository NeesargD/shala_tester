import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shala_yoga/base/utils/common_methods.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';
import 'package:shala_yoga/base/utils/constants/image_constant.dart';
import 'package:shala_yoga/base/utils/constants/textstyle_constants.dart';
import 'package:shala_yoga/base/utils/localization/app_localizations.dart';

class RecommendedClassList extends StatelessWidget {
  final String coverImage;
  final String title;
  final String languages;
  final String duration;
  final String style;
  final String image;
  final String level;
  bool? isLock;
  final double height;
  final double width;

  RecommendedClassList(
      {required this.image,
      required this.title,
      required this.languages,
      required this.style,
      required this.coverImage,
      required this.level,
      this.isLock,
      required this.duration,
      this.height = 0.3,
      this.width = 0.7});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context: context, percent: height),
      width: screenWidth(context: context, percent: width),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Container(
            height: 110,
            width: screenWidth(context: context, percent: width),
            child: Stack(
              children: [
                // CachedNetworkImage(
                //   imageUrl: recommendedClass.coverImage,
                //   fit: BoxFit.fill,
                //   height: MediaQuery.of(context).size.height * 0.2,
                //   width: MediaQuery.of(context).size.width,
                // ),
                Image.asset(coverImage,
                    width: screenWidth(context: context, percent: 1),
                    fit: BoxFit.cover),
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            15, 5, 15, 5),
                        decoration: BoxDecoration(
                          color: isLock == true
                              ? ColorRes.premiumBackground
                              : ColorRes.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(isLock == true ? AppLocalizations.of
                          (context)!.translate('premium') : AppLocalizations
                            .of(context)!.translate('free'),
                            style: TextStyles.R12FF),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.mic,
                          color: ColorRes.white,
                          size: 20,
                        ),
                      ),
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: ColorRes.white,
                        child: Text(
                          languages,
                          style: TextStyles.R1075,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 79,
                width: screenWidth(context: context, percent: 0.70),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      width:
                          screenWidth(context: context, percent: 0.50),
                      padding: EdgeInsetsDirectional.only(start: 10),
                      child: Text(
                        title,
                        style: TextStyles.SB1475,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(ImageRes.yogaStyle),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(style, style: TextStyles.R1275),
                        Spacer(),
                        SvgPicture.asset(ImageRes.levels),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(level, style: TextStyles.R1275),
                        Spacer(),
                        SvgPicture.asset(ImageRes.hourGlass),
                        const SizedBox(
                          width: 5,
                        ),
                        Text.rich(
                          TextSpan(
                              text: duration,
                              style: TextStyles.R1275,
                              children: [TextSpan(text: " min")]),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              PositionedDirectional(
                top: -22,
                end: 10,
                child: Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: CircleAvatar(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    radius: 22,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
