import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../base/utils/constants/color_constant.dart';
import '../../base/utils/constants/image_constant.dart';
import '../../base/utils/constants/textstyle_constants.dart';
import '../../blocs/instructor_details_bloc/instructor_details_bloc.dart';
import '../widgets/custom_button.dart';
import '../widgets/failure_widget.dart';
import '../widgets/loading_widget.dart';

class InstructorProfileScreen extends StatefulWidget {
  const InstructorProfileScreen({Key? key}) : super(key: key);

  @override
  _InstructorProfileScreenState createState() => _InstructorProfileScreenState();
}

class _InstructorProfileScreenState extends State<InstructorProfileScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorRes.appBarColor,
        appBar: AppBar(
          backgroundColor: ColorRes.appBarColor,
          elevation: 0,
        ),
        body: BlocBuilder<InstructorDetailsBloc, InstructorDetailsState>(builder: (context, state) {
          if (state is InstructorDetailsFailure) {
            return FailureWidget(message: state.message);
          }
          if (state is InstructorDetailsSuccess) {
            return Container(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: ColorRes.appBackground,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsetsDirectional.only(start: 20),
                            child: CircleAvatar(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(65),
                                  child:
                                  Image.network(state.instructorDetailsModel.content!.instructor!.profilePicture)),
                              radius: 65,
                            ),
                          ),
                          SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    state.instructorDetailsModel.content!.instructor!.firstname +
                                        state.instructorDetailsModel.content!.instructor!.firstname,
                                    style: TextStyles.SB1878),
                                Text('Germany', style: TextStyles.R1375),
                                SizedBox(height: 11),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('${state.instructorDetailsModel.content!.instructor!.follower}',
                                              style: TextStyles.R1875),
                                          Text('Followers', style: TextStyles.R1275),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('${state.instructorDetailsModel.content!.instructor!.classes}',
                                              style: TextStyles.R1875),
                                          Text('Classes', style: TextStyles.R1275),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('${state.instructorDetailsModel.content!.instructor!.program}',
                                              style: TextStyles.R1875),
                                          Text('Programs', style: TextStyles.R1275),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 21),
                      Container(
                        height: 120,
                        margin: EdgeInsetsDirectional.only(start: 25, end: 25, bottom: 0),
                        child: SingleChildScrollView(
                          child: Text(state.instructorDetailsModel.content!.instructor!.description),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 7.7, end: 7.7),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 2,
                                color: ColorRes.greyIndicator,
                              ),
                            ),
                          ),
                          child: TabBar(
                              indicatorSize: TabBarIndicatorSize.tab,
                              labelStyle: TextStyles.SB1578,
                              labelColor: ColorRes.primaryColor,
                              indicatorColor: ColorRes.primaryColor,
                              controller: _tabController,
                              unselectedLabelStyle: TextStyles.SB15AF,
                              unselectedLabelColor: ColorRes.unselectedTextGrey,
                              tabs: [
                                Tab(text: 'CLASSES'),
                                Tab(text: 'PROGRAMS'),
                              ]),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            Container(
                              margin: EdgeInsetsDirectional.only(start: 35, end: 35, top: 29),
                              child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.74,
                                    mainAxisSpacing: 25,
                                    crossAxisSpacing: 25,
                                    crossAxisCount: 2),
                                itemCount: state.instructorDetailsModel.content!.classes.length,
                                itemBuilder: (BuildContext context, int index) {
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
                                        ]),
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            Image.network(
                                              'https://shala.dev.codetrade.io/media/${state.instructorDetailsModel.content!.classes[index].coverImage}',
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
                                                              color: state.instructorDetailsModel.content!
                                                                  .classes[index].isLock ==
                                                                  true
                                                                  ? ColorRes.premiumBackground
                                                                  : ColorRes.primaryColor,
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(10),
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsetsDirectional.fromSTEB(15, 3, 15, 3),
                                                              child: Text(
                                                                  state.instructorDetailsModel.content!.classes[index]
                                                                      .isLock ==
                                                                      true
                                                                      ? "PREMIUM"
                                                                      : "FREE",
                                                                  style: TextStyles.SB10FF),
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
                                                                  child: Text(
                                                                      '${state.instructorDetailsModel.content!.classes[index].languageId}',
                                                                      style: TextStyles.R1075),
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
                                                    state.instructorDetailsModel.content!.classes[index].title,
                                                    style: TextStyles.SB1475,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 3,
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
                                                    Text(state.instructorDetailsModel.content!.classes[index].level,
                                                        style: TextStyles.R1275),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Positioned(
                                              top: -12,
                                              right: 10,
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                    height: 26,
                                                    width: 26,
                                                    decoration: BoxDecoration(
                                                        color: ColorRes.white,
                                                        borderRadius: BorderRadius.circular(25),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            offset: const Offset(0, 3),
                                                            blurRadius: 6,
                                                            color: ColorRes.lightGrey,
                                                          )
                                                        ]),
                                                    child: Text.rich(
                                                      TextSpan(
                                                          text: state.instructorDetailsModel.content!.classes[index]
                                                              .durations +
                                                              "\n",
                                                          style: TextStyles.R1375,
                                                          children: [TextSpan(text: "min", style: TextStyles.R875)]),
                                                      textAlign: TextAlign.center,
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsetsDirectional.only(start: 23, end: 31, top: 32),
                              child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 3 / 4,
                                    mainAxisSpacing: 32,
                                    crossAxisSpacing: 40,
                                    crossAxisCount: 2),
                                itemCount: state.instructorDetailsModel.content!.programs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    decoration: ShapeDecoration(
                                        color: ColorRes.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        shadows: [
                                          BoxShadow(
                                            offset: const Offset(5.0, 5.0),
                                            color: ColorRes.whiteGradient,
                                          )
                                        ]),
                                    child: Stack(
                                      children: [
                                        CachedNetworkImage(
                                          fit: BoxFit.fill,
                                          imageUrl: 'https://shala.dev.codetrade.io/media/${state.instructorDetailsModel.content!.programs[index].coverImage}',
                                        ),
                                        Stack(
                                          children: [
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(width: 9),
                                                    Column(
                                                      children: [
                                                        Text.rich(
                                                          TextSpan(
                                                              text:
                                                              '${state.instructorDetailsModel.content!.programs[index].count}' +
                                                                  "\n",
                                                              style: TextStyles.R31FF,
                                                              children: [
                                                                TextSpan(text: "Classes", style: TextStyles.R12FF),
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
                                                Container(
                                                  margin: EdgeInsetsDirectional.fromSTEB(10, 0, 8, 0),
                                                  child:
                                                  Text(state.instructorDetailsModel.content!.programs[index].title),
                                                  color: ColorRes.white.withOpacity(0),
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
                                                      child: Text(
                                                          state.instructorDetailsModel.content!.programs[index].level,
                                                          overflow: TextOverflow.visible,
                                                          maxLines: 2,
                                                          style: TextStyles.R1275),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                    SvgPicture.asset(ImageRes.yogaStyle),
                                                    const SizedBox(
                                                      width: 3,
                                                    ),
                                                    Flexible(child: Text("Fitness, Meditation, ...", style: TextStyles.R1275)),
                                                  ],
                                                ),
                                                SizedBox(height: 8),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                          controller: _tabController,
                        ),
                      ),
                      Container(
                        margin: EdgeInsetsDirectional.only(start: 35, end: 35),
                        child: CustomButton(
                            onTap: () {},
                            buttonText: "FOLLOW",
                            backgroundColor: ColorRes.white,
                            foregroundColor: ColorRes.white,
                            borderColor: ColorRes.primaryColor,
                            textStyle: TextStyles.SB1878),
                      )
                    ],
                  ),
                ],
              ),
            );
          }
          return LoadingWidget();
        }),

      ),
    );
  }
}
