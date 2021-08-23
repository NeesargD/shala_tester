import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../base/utils/common_methods.dart';
import '../../base/utils/constants/color_constant.dart';
import '../../base/utils/constants/image_constant.dart';
import '../../base/utils/constants/textstyle_constants.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/custom_button.dart';

class RecommendationScreen extends StatefulWidget {
  const RecommendationScreen({Key? key}) : super(key: key);

  @override
  _RecommendationScreenState createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBarWidget(),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsetsDirectional.fromSTEB(20, 0, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Stack(
                  children: [
                    Container(alignment: Alignment.topRight, child: SvgPicture.asset('assets/home_screen_image.svg')),
                    Container(
                      margin: EdgeInsetsDirectional.fromSTEB(0, 20, 80, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("GREAT!", style: TextStyles.SB4078),
                          Container(
                            width: screenWidth(context: context, percent: 0.55),
                            child: Text(
                                'Based on your answers, we recommend the following '
                                'programs & classes',
                                style: TextStyles.R2075),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "RECOMMENDED\n",
                        style: TextStyles.R1575,
                        children: [
                          TextSpan(text: 'PROGRAMS', style: TextStyles.R2075),
                        ],
                      ),
                    ),
                    Spacer(),
                    IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward, color: ColorRes.greyIcon)),
                  ],
                ),
                Container(
                  height: screenHeight(context: context, percent: 0.30),
                  width: screenWidth(context: context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: ListView.builder(
                    itemCount: 4,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return programs();
                    },
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ListTile(
                  trailing: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward, color: ColorRes.greyIcon)),
                  title: RichText(
                    text: TextSpan(
                      text: "RECOMMENDED\n",
                      style: TextStyles.R1575,
                      children: [
                        TextSpan(text: 'CLASSES', style: TextStyles.R2075),
                      ],
                    ),
                  ),
                ),
                classes(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(width: 2, color: ColorRes.primaryColor),
                      )),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                        child: RichText(
                          text: TextSpan(
                            text: "Join us today for\n",
                            style: TextStyles.R1575,
                            children: [
                              TextSpan(text: '30% Discount', style: TextStyles.R3075),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      top: -9,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                            color: ColorRes.primaryColor,
                          ),
                          child: Text(
                            'LIMITED OFFER',
                            style: TextStyles.SB10FF,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Align(
                  alignment: Alignment.center,
                  child: CustomButton(
                      onTap: () {},
                      buttonText: 'DISCOVER ALL OUR CLASSES',
                      backgroundColor: ColorRes.greyText,
                      foregroundColor: ColorRes.white,
                      borderColor: ColorRes.greyText,
                      widthPercent: 0.90,
                      textStyle: TextStyles.SB15FF),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget programs() {
    return Row(
      children: [
        Stack(
          children: [
            Container(
              height: screenHeight(context: context, percent: 0.30),
              width: screenWidth(context: context, percent: 0.70),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.deepPurple,
              ),
            ),
            Container(
              height: screenHeight(context: context, percent: 0.30),
              width: screenWidth(context: context, percent: 0.70),
              decoration: BoxDecoration(
                  color: Colors.yellow,
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
              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              child: Column(
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
                            '18',
                            style: TextStyles.R31FF,
                          ),
                          Text(
                            'Classes',
                            style: TextStyles.R12FF,
                          ),
                        ],
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
                          'Ar',
                          style: TextStyles.R1075,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: screenWidth(context: context, percent: 0.40),
                    padding: EdgeInsetsDirectional.only(start: 10),
                    child: Text(
                      'Program title again look for title',
                      style: TextStyles.SB1475,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
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
                                  width: 10,
                                ),
                                SvgPicture.asset(ImageRes.yogaStyle),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Text(
                                    "Fitness,Meditation,Fitness,Meditation,Fitness,Meditation,Fitness,Meditation",
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
                                    "Fitness,Meditation,Fitness,Meditation,Fitness,Meditation,Fitness,Meditation",
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

  Widget classes() {
    return Row(
      children: [
        Stack(
          children: [
            Container(
              height: screenHeight(context: context, percent: 0.30),
              width: screenWidth(context: context, percent: 0.70),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  Container(
                    height: screenHeight(context: context, percent: 0.18),
                    width: screenWidth(context: context, percent: 0.70),
                    color: Colors.indigo,
                    padding: EdgeInsetsDirectional.only(top: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 5),
                          decoration: BoxDecoration(
                            color: ColorRes.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text("FREE", style: TextStyles.R12FF),
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
                            'Ar',
                            style: TextStyles.R1075,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: screenHeight(context: context, percent: 0.12),
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
                              alignment: Alignment.centerLeft,
                              width: screenWidth(context: context, percent: 0.50),
                              padding: EdgeInsetsDirectional.only(start: 10),
                              child: Text(
                                'Easy Yoga For Complete Begin For Complete',
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
                                Text("Fitness", style: TextStyles.R1275),
                                Spacer(),
                                SvgPicture.asset(ImageRes.levels),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text("All Levels", style: TextStyles.R1275),
                                Spacer(),
                                SvgPicture.asset(ImageRes.hourGlass),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text("20 min", style: TextStyles.R1275),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: -22,
                        right: 10,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            radius: 22,
                            backgroundColor: ColorRes.primaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            /*Container(
              height: screenHeight(context: context, percent: 0.30),
              width: screenWidth(context: context, percent: 0.70),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              child: Column(
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
                      Container(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 5),
                        decoration: BoxDecoration(
                          color: ColorRes.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text("FREE", style: TextStyles.R12FF),
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
                          'Ar',
                          style: TextStyles.R1075,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),*/
          ],
        ),
        const SizedBox(
          width: 30,
        ),
      ],
    );
    return Container(
      decoration: BoxDecoration(
        color: Colors.yellow,
      ),
      margin: EdgeInsetsDirectional.fromSTEB(0, 10, 60, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  margin: EdgeInsetsDirectional.only(start: 10),
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(color: ColorRes.primaryColor, borderRadius: BorderRadius.circular(10)),
                  child: Text("FREE", style: TextStyles.R12FF)),
              Spacer(),
              IconButton(onPressed: () {}, icon: Icon(Icons.mic, color: ColorRes.white)),
              const SizedBox(
                width: 10,
              )
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.09),
          Container(
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width * 0.60,
            child: ListTile(
              title: Text('Easy Yoga For Complete Begin For Complete', style: TextStyles.SB1475),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.add_location_rounded, color: ColorRes.primaryColor)),
                  Row(
                    children: [
                      Text("Fitness", style: TextStyles.R1275),
                    ],
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.playlist_play_sharp, color: ColorRes.primaryColor)),
                  Row(
                    children: [
                      Text("All Levels", style: TextStyles.R1275),
                    ],
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.access_time, color: ColorRes.primaryColor)),
                  Row(
                    children: [
                      Text("20", style: TextStyles.R1275),
                      Column(
                        children: [
                          Text(
                            "min",
                            style: TextStyles.R1275,
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
