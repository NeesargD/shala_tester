import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shala_yoga/base/utils/common_methods.dart';
import 'package:shala_yoga/ui/widgets/custom_network_image.dart';
import '../../base/utils/constants/color_constant.dart';
import '../../base/utils/constants/image_constant.dart';
import '../../base/utils/constants/textstyle_constants.dart';

class ClassesCardWidget extends StatelessWidget {
  final String image;
  final String day;
  final String title;
  final String style;
  final String level;
  final String duration;
  final String language;
  final bool isLock;

  ClassesCardWidget(
      {required this.image,
      required this.day,
      required this.title,
      required this.style,
      required this.level,
      required this.duration,
      required this.language,
      required this.isLock});

  @override
  Widget build(BuildContext context) {
    print(screenWidth(context: context));
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: ColorRes.greyIcon, offset: Offset(0, 5), blurRadius: 10)
        ],
        color: ColorRes.white,
      ),
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: screenHeight(context: context,percent: 0.15),
                    width: screenWidth(context: context,percent: 0.334),
                    child: CustomNetworkImage(
                      imageUrl: image,
                      boxFit: BoxFit.cover,
                    ),
                  ),
                  /*child: Image.asset(image,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height),*/
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 6, start: 6),
                  child: Container(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 3, 15, 3),
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
                Center(
                  child: Container(
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: ColorRes.white,
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      size: 30,
                      color: ColorRes.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                /*top: 10,*/
                end: 10,
                start: 10, /*bottom: 11*/
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text(day, style: TextStyles.SB1078),
                      Spacer(),
                      Icon(
                        Icons.mic,
                        color: ColorRes.greyIcon,
                        size: 20,
                      ),
                      CircleAvatar(
                        backgroundColor: ColorRes.greyIcon,
                        radius: 10,
                        child: Text('${language.substring(0, 2)}',
                            style: TextStyles.R10FF),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(end: 50),
                    child: Text(
                      title,
                      style: TextStyles.SB1475,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(ImageRes.yogaStyle),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            style,
                            style: TextStyles.R1275,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(ImageRes.levels),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            level,
                            style: TextStyles.R1275,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(ImageRes.hourGlass),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            duration + "min",
                            style: TextStyles.R1275,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
