import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shala_yoga/ui/auth/login_signup.dart';
import '../../../base/utils/navigation/navigation_route_constants.dart';
import '../../video_player/custom_video_player.dart';
import '../../../base/utils/navigation/navigation_utils.dart';
import '../../widgets/expand_shrink_text.dart';

import '../../../base/utils/common_methods.dart';
import '../../../base/utils/constants/color_constant.dart';
import '../../../base/utils/constants/image_constant.dart';
import '../../../base/utils/constants/string_res.dart';
import '../../../base/utils/constants/textstyle_constants.dart';
import '../../../blocs/classes/classes_details_bloc/classes_details_bloc.dart';
import '../../classes_widgets/classes_grid_widget.dart';
import '../../widgets/circular_image.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_network_image.dart';
import '../../widgets/failure_widget.dart';
import '../../widgets/loading_widget.dart';

class ClassDetailsScreen extends StatefulWidget {
  const ClassDetailsScreen({Key? key}) : super(key: key);

  @override
  _ClassDetailsScreenState createState() => _ClassDetailsScreenState();
}

class _ClassDetailsScreenState extends State<ClassDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassesDetailsBloc, ClassesDetailsState>(
      builder: (context, state) {
        if (state is ClassDetailsFailure) {
          return FailureWidget(
            message: state.message,
          );
        }

        if (state is ClassDetailsSuccess) {
          return Scaffold(
            backgroundColor: ColorRes.whiteGradient,
            bottomNavigationBar: BottomAppBar(
              child: Container(
                decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [ColorRes.white, ColorRes.whiteGradient])),
                height: 120,
                // height: MediaQuery.of(context).size.height * 0.18,
                margin: EdgeInsetsDirectional.only(start: 17, end: 17, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomButton(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChewieDemo(),
                          ));
                        },
                        buttonText: 'START WATCHING',
                        backgroundColor: ColorRes.primaryColor,
                        foregroundColor: ColorRes.whiteGradient,
                        borderColor: ColorRes.primaryColor,
                        textStyle: TextStyles.SB18FF),
                    SizedBox(height: 15),
                    CustomButton(
                        onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context) => LoginSignupScreen(),));
                        },
                        buttonText: 'WATCH LATER',
                        backgroundColor: ColorRes.greyText,
                        foregroundColor: ColorRes.whiteGradient,
                        borderColor: ColorRes.greyText,
                        textStyle: TextStyles.SB18FF),
                  ],
                ),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Stack(children: [
                  Container(
                    width: screenWidth(context: context),
                    height: 250,
                    color: ColorRes.greyText,
                    child: Stack(
                      children: [
                        SizedBox(
                          width: screenWidth(context: context),
                          height: screenHeight(context: context, percent: 0.38),
                          child: CustomNetworkImage(
                            imageUrl: state.classDetailsModel.content!.classes.coverImage,
                            boxFit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: 17, end: 17, bottom: 32),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        NavigationUtils.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.arrow_back,
                                        color: ColorRes.white,
                                      )),
                                  Spacer(),
                                  IconButton(onPressed: () {}, icon: Icon(Icons.access_time, color: ColorRes.white)),
                                  IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border, color: ColorRes.white)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => ChewieDemo(
                                          videoUrl: state.classDetailsModel.content!.classes.videoUrl,
                                        ),
                                      ));
                                    },
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.only(top: 43),
                                        child: Container(
                                          padding: EdgeInsetsDirectional.all(15),
                                          decoration: BoxDecoration(
                                            color: ColorRes.white.withOpacity(0.20),
                                            border: Border.all(color: ColorRes.white),
                                            borderRadius: BorderRadius.circular(25),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.play_arrow_rounded,
                                              color: ColorRes.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 7, end: 7, top: 240),
                    width: MediaQuery.of(context).size.width * 0.96,
                    decoration: BoxDecoration(
                      color: ColorRes.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.only(start: 17, end: 17),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: screenWidth(context: context, percent: 0.60),
                                    padding: EdgeInsetsDirectional.only(top: 15),
                                    child: Text(
                                      state.classDetailsModel.content!.classes.title,
                                      style: TextStyles.SB2575,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  RichText(
                                    text: TextSpan(text: "Part of ", style: TextStyles.R1275, children: [TextSpan(text: state.classDetailsModel.content!.classes.partOf, style: TextStyles.SB1278)]),
                                  ),
                                  SizedBox(height: 30),
                                  Row(
                                    children: [
                                      SvgPicture.asset(ImageRes.yogaStyle),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(state.classDetailsModel.content!.classes.style.join(','), style: TextStyles.R1575),
                                      Spacer(),
                                      SvgPicture.asset(ImageRes.levels),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(state.classDetailsModel.content!.classes.level, style: TextStyles.R1575),
                                      Spacer(),
                                      SvgPicture.asset(ImageRes.hourGlass),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(appState.parseDuration(state.classDetailsModel.content!.classes.durations).inMinutes.toString() + ' min', style: TextStyles.R1575),
                                    ],
                                  ),
                                  SizedBox(height: 30),
                                  ExpandShrinkText(
                                    state.classDetailsModel.content!.classes.description,
                                  trimLines: 5,
                                  ),
                                  /*Container(
                                    height: 120,x
                                    child: Scrollbar(
                                      child: SingleChildScrollView(
                                        child: Text(
                                          state
                                              .classDetailsModel
                                              .content!
                                              .classes
                                              .description,
                                          style: TextStyles.R1375,
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                    ),
                                  ),*/
                                  SizedBox(height: 25),
                                  Text("Class focus", style: TextStyles.R1575.copyWith(color: ColorRes.primaryColor)),
                                ],
                              ),
                            ),
                            Stack(
                              children: [
                                Divider(
                                  color: ColorRes.greyIndicator,
                                  thickness: 2,
                                ),
                                Divider(
                                  color: ColorRes.primaryColor,
                                  thickness: 2,
                                  endIndent: screenWidth(context: context, percent: 0.60),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsetsDirectional.only(start: 17),
                              child: Text(state.classDetailsModel.content!.classes.focus.join(','), style: TextStyles.R1375),
                            ),
                            SizedBox(height: 23),
                            Padding(
                              padding: EdgeInsetsDirectional.only(start: 17),
                              child: Text("Similar Classes", style: TextStyles.R1575.copyWith(color: ColorRes.primaryColor)),
                            ),
                            Stack(
                              children: [
                                Divider(
                                  color: ColorRes.greyIndicator,
                                  thickness: 2,
                                ),
                                Divider(
                                  color: ColorRes.primaryColor,
                                  thickness: 2,
                                  endIndent: screenWidth(context: context, percent: 0.60),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 0.74, mainAxisSpacing: 25, crossAxisSpacing: 25, crossAxisCount: 2),
                              itemCount: state.classDetailsModel.content!.similarClasses.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                    onTap: () {
                                      NavigationUtils.pushReplacement(context, routeClassDetailsScreen, arguments: {"id": state.classDetailsModel.content!.similarClasses[index].id});
                                    },
                                    child: ClassesGridWidget(classesDetail: state.classDetailsModel.content!.similarClasses[index]));
                              },
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                        PositionedDirectional(
                          top: -30,
                          child: Row(
                            children: [
                              Icon(Icons.mic, color: ColorRes.white),
                              CircleAvatar(
                                backgroundColor: ColorRes.white,
                                radius: 10,
                                child: Text(state.classDetailsModel.content!.classes.language.substring(0, 2), style: TextStyles.R1075),
                              ),
                            ],
                          ),
                        ),
                        PositionedDirectional(
                            end: 20,
                            top: -35,
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        NavigationUtils.push(context, routeInstructorDetails, arguments: {
                                          'id': state.classDetailsModel.content!.classes.instructor.id,
                                        });
                                      },
                                      child: CircleAvatar(
                                        radius: 35,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(35),
                                          child: CircularImage(
                                            imageUrl: state.classDetailsModel.content!.classes.instructor.profilePicture,
                                            imageRadius: 35,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      state.classDetailsModel.content!.classes.instructor.firstname + '\n' + state.classDetailsModel.content!.classes.instructor.lastname,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          );
        }

        return Scaffold(
          body: LoadingWidget(),
        );
      },
    );
  }
}
