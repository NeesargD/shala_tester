import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../base/utils/common_methods.dart';
import '../../base/utils/constants/color_constant.dart';
import '../../base/utils/constants/image_constant.dart';
import '../../base/utils/constants/textstyle_constants.dart';
import '../../base/utils/localization/app_localizations.dart';
import '../../models/instructor_details_model.dart';
import '../widgets/custom_network_image.dart';

class ProgramGridWidget extends StatelessWidget {
  final Programs programDetails;
  final double height;
  final double width;
  const ProgramGridWidget({Key? key, required this.programDetails, this.height = 0.30, this.width = 0.70})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        children: [
          PositionedDirectional(
            top: 0,
            start: 0,
            end: 0,
            child: Container(
              height: screenHeight(context: context, percent: height),
              width: screenWidth(context: context, percent: width),
              decoration: BoxDecoration(
                color: ColorRes.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
                child: CustomNetworkImage(boxFit: BoxFit.cover,
                  imageUrl: '${programDetails.coverImage}',
                ),
              ),
            ),
          ),
          Container(
            height: screenHeight(context: context),
            width: screenWidth(context: context),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                gradient: LinearGradient(
                  colors: [
                    ColorRes.white,
                    ColorRes.white.withOpacity(0.4),
                    ColorRes.white.withOpacity(0.05),
                  ],
                  stops: [0.20, 0.50, 1],
                  begin: AlignmentDirectional.bottomCenter,
                  end: AlignmentDirectional.topCenter,
                )),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 9),
                        Column(
                          children: [
                            Text.rich(
                              TextSpan(
                                  text: '${programDetails.count}' + "\n",
                                  style: TextStyles.R31FF,
                                  children: [
                                    TextSpan(
                                        text: AppLocalizations.of(context)!.translate("classes"),
                                        style:
                                    TextStyles.R12FF),
                                  ]),
                            ),
                          ],
                        ),
                        Spacer(),
                        Icon(Icons.mic, size: 20, color: ColorRes.white),
                        CircleAvatar(
                          backgroundColor: ColorRes.white,
                          radius: 10,
                          child: Text(AppLocalizations.of(context)!.translate("ar"), style:
                          TextStyles.R1075),
                        ),
                        SizedBox(width: 11),
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 10, end: 30),
                      child: Text(programDetails.title,
                          style: TextStyles.SB1475),
                    ),
                    SizedBox(height: 9),
                    Row(
                      children: [
                        const SizedBox(
                          width: 12,
                        ),
                        SvgPicture.asset(ImageRes.levels),
                        const SizedBox(
                          width: 3,
                        ),
                        Flexible(
                          child: Text(programDetails.level.join(","),
                              overflow: TextOverflow.visible,
                              maxLines: 2,
                              style: TextStyles.R1275),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        const SizedBox(
                          width: 12,
                        ),
                        SvgPicture.asset(ImageRes.yogaStyle),
                        const SizedBox(
                          width: 3,
                        ),
                        Flexible(
                          child: Text(
                            programDetails.style.join(','),
                            style: TextStyles.R1275,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
