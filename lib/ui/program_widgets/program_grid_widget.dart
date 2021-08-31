import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';
import 'package:shala_yoga/base/utils/constants/image_constant.dart';
import 'package:shala_yoga/base/utils/constants/textstyle_constants.dart';
import 'package:shala_yoga/models/instructor_details_model.dart';
import 'package:shala_yoga/ui/widgets/custom_network_image.dart';

class ProgramGridWidget extends StatelessWidget {
  final Programs programDetails;

  const ProgramGridWidget({Key? key, required this.programDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: ColorRes.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
              child: CustomNetworkImage(
                imageUrl: '${programDetails.coverImage}',
              ),
            ),
          ),
        ),
        Stack(
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
                                    text: "Classes", style: TextStyles.R12FF),
                              ]),
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(Icons.mic, size: 20, color: ColorRes.white),
                    CircleAvatar(
                      backgroundColor: ColorRes.white,
                      radius: 10,
                      child: Text('AR', style: TextStyles.R1075),
                    ),
                    SizedBox(width: 11),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 10, end: 30),
                  child: Text(programDetails.title),
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
      ],
    );
  }
}
