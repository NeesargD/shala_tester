import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';
import 'package:shala_yoga/base/utils/constants/image_constant.dart';
import 'package:shala_yoga/base/utils/constants/string_res.dart';
import 'package:shala_yoga/base/utils/constants/textstyle_constants.dart';
import 'package:shala_yoga/base/utils/localization/app_localizations.dart';
import 'package:shala_yoga/models/instructor_details_model.dart';

class ClassesGridWidget extends StatelessWidget {
  final Classes classesDetail;

  const ClassesGridWidget({Key? key, required this.classesDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
          color: ColorRes.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          shadows: [
            BoxShadow(
              offset: const Offset(0.0, 5.0),
              blurRadius: 10,
              color: ColorRes.whiteGradient,
            )
          ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                '${classesDetail.coverImage}',
                alignment: AlignmentDirectional.topCenter,
              ),
              Stack(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsetsDirectional.fromSTEB(5, 8, 0, 0),
                              decoration: ShapeDecoration(
                                color:
                                    classesDetail.isLock == true ? ColorRes.premiumBackground : ColorRes.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(15, 3, 15, 3),
                                child:
                                    Text(classesDetail.isLock == true ?
                                    AppLocalizations.of(context)!.translate('premium') :
                                    AppLocalizations.of(context)!.translate('free'), style:
                                    TextStyles
                                        .SB10FF),
                              ),
                            ),
                            Spacer(),
                            Container(
                              margin: EdgeInsets.only(top: 8),
                              child: Row(
                                children: [
                                  Icon(Icons.mic, color: ColorRes.white),
                                  CircleAvatar(
                                    backgroundColor: ColorRes.white,
                                    radius: 10,
                                    child: Text('${classesDetail.language.substring(0, 2)}', style: TextStyles.R1075),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 11),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.fromSTEB(11, 13, 52, 0),
                    child: Text(
                      classesDetail.title,
                      style: TextStyles.SB1475,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    color: ColorRes.white,
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      const SizedBox(
                        width: 11,
                      ),
                      SvgPicture.asset(ImageRes.yogaStyle),
                      const SizedBox(
                        width: 3,
                      ),
                      Text("Fitness", style: TextStyles.R1275),
                      SizedBox(width: 10),
                      SvgPicture.asset(ImageRes.levels),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(classesDetail.level, style: TextStyles.R1275),
                    ],
                  ),
                ],
              ),
              Positioned(
                top: -13,
                right: 10,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: ColorRes.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 3),
                            blurRadius: 6,
                            color: ColorRes.lightGrey,
                          )
                        ],
                      ),
                      child: Center(
                        child: Text.rich(
                          TextSpan(
                              text: appState.parseDuration(classesDetail.durations).inMinutes.toString(),
                              style: TextStyles.R1275,
                              children: [TextSpan(text: "\nmin", style: TextStyles.R875)]),
                          textAlign: TextAlign.center,
                        ),
                      )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
