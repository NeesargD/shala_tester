import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shala_yoga/base/utils/common_methods.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';
import 'package:shala_yoga/base/utils/constants/image_constant.dart';
import 'package:shala_yoga/base/utils/constants/textstyle_constants.dart';

class ProgramGridRecommended extends StatelessWidget {

  final String coverImage;
  final int countClass;
  final String languages;
  final String title;
  final String style;
  final String level;


  ProgramGridRecommended({required this.coverImage, required this.countClass, required this.languages,
      required this.title, required this.style, required this.level});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Stack(
          children: [
            Container(
                height: screenHeight(context: context, percent: 0.30),
                width: screenWidth(context: context, percent: 0.70),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  // child: CachedNetworkImage(
                  //   imageUrl: coverImage,
                  //   fit: BoxFit.fill,
                  // ),
                  child: Image.asset(coverImage,
                  fit : BoxFit.cover),
                )),
            Container(
              height: screenHeight(context: context, percent: 0.30),
              width: screenWidth(context: context, percent: 0.70),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  gradient: LinearGradient(
                    colors: [
                      ColorRes.white,
                      ColorRes.white.withOpacity(0.4),
                      ColorRes.white.withOpacity(0.05),
                    ],
                    stops: [0.3, 0.55, 1],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  )),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${countClass}',
                                style: TextStyles.R31FF,
                              ),
                              Text(
                                'Classes',
                                style: TextStyles.R12FF,
                              ),
                            ],
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Row(
                              children: [
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
                                    languages
                                    ,style: TextStyles.R1075,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: screenWidth(context: context, percent: 0.40),
                        padding: EdgeInsetsDirectional.only(start: 14),
                        child: Text(
                          title,
                          style: TextStyles.SB1475,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: screenWidth(context: context, percent: 0.33),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 14,
                                    ),
                                    SvgPicture.asset(ImageRes.yogaStyle),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: Text(
                                        style,
                                        style: TextStyles.R1275,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: screenWidth(context: context, percent: 0.33),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SvgPicture.asset(ImageRes.levels),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: Text(
                                        level,
                                        style: TextStyles.R1275,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                          SizedBox(height: 18),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 30,
        ),
      ],
    );
  }
}
