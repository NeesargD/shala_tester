import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shala_yoga/base/utils/common_methods.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';
import 'package:shala_yoga/base/utils/constants/image_constant.dart';
import 'package:shala_yoga/base/utils/constants/textstyle_constants.dart';
import 'package:shala_yoga/base/utils/localization/app_localizations.dart';
import 'package:shala_yoga/ui/widgets/custom_network_image.dart';

class RecommendedProgramList extends StatelessWidget {

  final String coverImage;
  final int countClass;
  final List<String> languages;
  final String title;
  final List<String> style;
  final List<String> level;
  final double height;
  final double width;


  RecommendedProgramList({required this.coverImage, required this.countClass, required this.languages,
      required this.title, required this.style, required this.level, this.height = 0.30, this.width = 0.70});

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Container(
            height: screenHeight(context: context, percent: height),
            width: screenWidth(context: context, percent: width),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: CustomNetworkImage(
                imageUrl: coverImage,
                boxFit: BoxFit.fill,
              ),
              // child: Image.asset(coverImage,
              // fit : BoxFit.cover),
            )),
        Container(
          height: screenHeight(context: context, percent: height),
          width: screenWidth(context: context, percent: width),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: LinearGradient(
                colors: [
                  ColorRes.white,
                  ColorRes.white.withOpacity(0.4),
                  ColorRes.white.withOpacity(0.05),
                ],
                stops: [0.3, 0.55, 1],
                begin: AlignmentDirectional.bottomCenter,
                end: AlignmentDirectional.topCenter,
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
                            '$countClass',
                            style: TextStyles.R31FF,
                          ),
                          Text(
                            AppLocalizations.of(context)!.translate('classes'),
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
                            if (languages.isNotEmpty)
                              SizedBox(
                                height: 20,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: languages.length,
                                  itemBuilder: (BuildContext context, int i) {
                                    return Padding(
                                      padding: const EdgeInsetsDirectional.only(end: 5),
                                      child: CircleAvatar(
                                        backgroundColor: ColorRes.white,
                                        radius: 10,
                                        child: Text(
                                            '${languages[i].substring(0, 2)}',
                                            style: TextStyles.R1075),
                                      ),
                                    );
                                  },
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
                    alignment: AlignmentDirectional.centerStart,
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
                          Expanded(child: Row(
                            children: [
                              const SizedBox(
                                width: 14,
                              ),
                              SvgPicture.asset(ImageRes.yogaStyle),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  style.join(','),
                                  style: TextStyles.R1275,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),),
                          Expanded(child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              SvgPicture.asset(ImageRes.levels),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  level.join(','),
                                  style: TextStyles.R1275,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),),
                          /*SizedBox(
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
                          ),*/
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
    );
  }
}
