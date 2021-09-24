import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shala_yoga/base/utils/toast_utils.dart';
import 'package:shala_yoga/blocs/favourite_bloc/favourite_bloc.dart';
import 'package:shala_yoga/models/classes/class_details_model.dart';
import '../../../base/utils/localization/app_localizations.dart';
import '../../../base/utils/navigation/navigation_route_constants.dart';
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
  late ClassDetailsModel? classDetailsModel;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavouriteBloc, FavouriteState>(
      listener: (context, state) {
        if (state is FavouriteLoading) {
          EasyLoading.show();
        }
        if (state is FavouriteSuccess) {
          EasyLoading.dismiss();
          ToastUtils.showSuccess(message: state.message);
          classDetailsModel!.content!.classes.isFav.value =
              !classDetailsModel!.content!.classes.isFav.value;
        }
        if (state is FavouriteFailure) {
          EasyLoading.dismiss();
          ToastUtils.showFailed(message: state.message);
        }
      },
      child: BlocBuilder<ClassesDetailsBloc, ClassesDetailsState>(
        builder: (context, state) {
          if (state is ClassDetailsFailure) {
            return FailureWidget(
              message: state.message,
            );
          }
          if (state is ClassDetailsSuccess) {
            classDetailsModel = state.classDetailsModel;
            return Scaffold(
              // bottomNavigationBar: BottomAppBar(
              //   child: Container(
              //     decoration: BoxDecoration(
              //         // gradient: LinearGradient(
              //         //     begin: Alignment.topCenter,
              //         //     end: Alignment.bottomCenter,
              //         //     colors: [Colors.white,  Colors.white]),
              //       boxShadow: [
              //         BoxShadow(
              //             color: ColorRes.white,
              //             blurRadius: 20,
              //           spreadRadius: 20
              //         )
              //       ],
              //     ),
              //     height: 120,
              //     padding:
              //         EdgeInsetsDirectional.only(start: 17, end: 17),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         CustomButton(
              //             onTap: () {
              //               if (appState.userId != null) {
              //                 NavigationUtils.push(
              //                     context, routeVideoPlayer, arguments: {
              //                   "videoUrl":
              //                       classDetailsModel!.content!.classes.videoUrl
              //                 });
              //               } else {
              //                 NavigationUtils.push(context, routeLoginSignup);
              //               }
              //             },
              //             buttonText: AppLocalizations.of(context)!
              //                 .translate("start_watching"),
              //             backgroundColor: ColorRes.primaryColor,
              //             foregroundColor: ColorRes.whiteGradient,
              //             borderColor: ColorRes.primaryColor,
              //             textStyle: TextStyles.SB18FF),
              //         SizedBox(height: 15),
              //         CustomButton(
              //             onTap: () {
              //               if (appState.userId != null) {
              //                 _handleClickMe(context);
              //               } else {
              //                 NavigationUtils.push(context, routeLoginSignup);
              //               }
              //             },
              //             buttonText: AppLocalizations.of(context)!
              //                 .translate("watch_later"),
              //             backgroundColor: ColorRes.greyText,
              //             foregroundColor: ColorRes.whiteGradient,
              //             borderColor: ColorRes.greyText,
              //             textStyle: TextStyles.SB18FF),
              //       ],
              //     ),
              //   ),
              //     elevation: 0,
              // ),
              body: SafeArea(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(children: [
                        Stack(
                          children: [
                            Container(
                              width: screenWidth(context: context),
                              height: 250,
                              color: ColorRes.greyText,
                              child: Stack(
                                children: [
                                  SizedBox(
                                    width: screenWidth(context: context),
                                    height:
                                        screenHeight(context: context, percent: 0.38),
                                    child: CustomNetworkImage(
                                      imageUrl: classDetailsModel!
                                          .content!.classes.coverImage,
                                      boxFit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(
                                        start: 23, end: 15, top: 20),
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
                                            IconButton(
                                                onPressed: () {
                                                  if (appState.userId != null) {
                                                    _handleClickMe(context);
                                                  } else {
                                                    NavigationUtils.push(
                                                        context, routeLoginSignup);
                                                  }
                                                },
                                                icon: Icon(Icons.access_time,
                                                    color: ColorRes.white,
                                                )),
                                            ValueListenableBuilder(
                                              valueListenable: classDetailsModel!
                                                  .content!.classes.isFav,
                                              builder: (context, value, child) {
                                                return IconButton(
                                                    onPressed: () {
                                                      if (appState.userId != null) {
                                                        context
                                                            .read<FavouriteBloc>()
                                                            .add(AddToFavourite(
                                                              contentType: 'Classes',
                                                              classId: state
                                                                  .classDetailsModel
                                                                  .content!
                                                                  .classes
                                                                  .id,
                                                            ));
                                                      } else {
                                                        NavigationUtils.push(
                                                            context, routeLoginSignup);
                                                      }
                                                    },
                                                    icon: state
                                                            .classDetailsModel
                                                            .content!
                                                            .classes
                                                            .isFav
                                                            .value
                                                        ? Icon(Icons.favorite,
                                                            color: ColorRes.red)
                                                        : Icon(Icons.favorite_border,
                                                            color: ColorRes.white));
                                              },
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                if (appState.userId != null) {
                                                  NavigationUtils.push(
                                                      context, routeVideoPlayer,
                                                      arguments: {
                                                        "videoUrl": state
                                                            .classDetailsModel
                                                            .content!
                                                            .classes
                                                            .videoUrl
                                                      });
                                                } else {
                                                  NavigationUtils.push(
                                                      context, routeLoginSignup);
                                                }
                                              },
                                              child: Center(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional.only(
                                                      top: 43),
                                                  child: Container(
                                                    padding: EdgeInsetsDirectional.all(15),
                                                    decoration: BoxDecoration(
                                                      color: ColorRes.white
                                                          .withOpacity(0.20),
                                                      border: Border.all(
                                                          color: ColorRes.white),
                                                      borderRadius:
                                                          BorderRadius.circular(25),
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
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsetsDirectional.only(
                                      start: 7, end: 7, top: 240),
                                  width: MediaQuery.of(context).size.width * 0.96,
                                  decoration: BoxDecoration(
                                    color: ColorRes.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16)),
                                  ),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsetsDirectional.only(
                                                start: 17, end: 17),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: screenWidth(
                                                      context: context, percent: 0.60),
                                                  padding:
                                                  EdgeInsetsDirectional.only(top: 15),
                                                  child: Text(
                                                    classDetailsModel!
                                                        .content!.classes.title,
                                                    style: TextStyles.SB2575,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                  ),
                                                ),
                                                SizedBox(height: 3),
                                                RichText(
                                                  text: TextSpan(
                                                      text: AppLocalizations.of(context)!
                                                          .translate("part_of"),
                                                      style: TextStyles.R1275,
                                                      children: [
                                                        TextSpan(
                                                            text: classDetailsModel!
                                                                .content!.classes.partOf,
                                                            style: TextStyles.SB1278)
                                                      ]),
                                                ),
                                                SizedBox(height: 30),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(ImageRes.yogaStyle),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                        classDetailsModel!
                                                            .content!.classes.style
                                                            .join(','),
                                                        style: TextStyles.R1575),
                                                    Spacer(),
                                                    SvgPicture.asset(ImageRes.levels),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                        classDetailsModel!
                                                            .content!.classes.level,
                                                        style: TextStyles.R1575),
                                                    Spacer(),
                                                    SvgPicture.asset(ImageRes.hourGlass),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                        appState
                                                            .parseDuration(
                                                            classDetailsModel!
                                                                .content!
                                                                .classes
                                                                .durations)
                                                            .inMinutes
                                                            .toString() +
                                                            ' min',
                                                        style: TextStyles.R1575),
                                                  ],
                                                ),
                                                SizedBox(height: 30),
                                                ExpandShrinkText(
                                                  classDetailsModel!
                                                      .content!.classes.description,
                                                  trimLines: 5,
                                                ),
                                                SizedBox(height: 25),
                                                Text(
                                                    AppLocalizations.of(context)!
                                                        .translate("class_focus"),
                                                    style: TextStyles.R1575.copyWith(
                                                        color: ColorRes.primaryColor)),
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
                                                endIndent: screenWidth(
                                                    context: context, percent: 0.60),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Padding(
                                            padding: EdgeInsetsDirectional.only(start: 17),
                                            child: Text(
                                                classDetailsModel!.content!.classes.focus
                                                    .join(','),
                                                style: TextStyles.R1375),
                                          ),
                                          SizedBox(height: 23),
                                          Padding(
                                            padding: EdgeInsetsDirectional.only(start: 17),
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .translate("similar_classes"),
                                                style: TextStyles.R1575.copyWith(
                                                    color: ColorRes.primaryColor)),
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
                                                endIndent: screenWidth(
                                                    context: context, percent: 0.60),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          GridView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                childAspectRatio: 0.74,
                                                mainAxisSpacing: 25,
                                                crossAxisSpacing: 25,
                                                crossAxisCount: 2),
                                            itemCount: classDetailsModel!
                                                .content!.similarClasses.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return InkWell(
                                                  onTap: () {
                                                    NavigationUtils.pushReplacement(
                                                        context, routeClassDetailsScreen,
                                                        arguments: {
                                                          "id": state
                                                              .classDetailsModel
                                                              .content!
                                                              .similarClasses[index]
                                                              .id
                                                        });
                                                  },
                                                  child: ClassesGridWidget(
                                                      classesDetail: classDetailsModel!
                                                          .content!.similarClasses[index]));
                                            },
                                          ),
                                          Container(height: MediaQuery.of(context).size.height * 0.17,
                                         color: ColorRes.appBackground,
                                          )
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
                                              child: Text(
                                                  classDetailsModel!
                                                      .content!.classes.language
                                                      .substring(0, 2),
                                                  style: TextStyles.R1075),
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
                                                      NavigationUtils.push(
                                                          context, routeInstructorDetails,
                                                          arguments: {
                                                            'id': state
                                                                .classDetailsModel
                                                                .content!
                                                                .classes
                                                                .instructor
                                                                .id,
                                                          });
                                                    },
                                                    child: CircleAvatar(
                                                      radius: 35,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius.circular(35),
                                                        child: CircularImage(
                                                          imageUrl: state
                                                              .classDetailsModel
                                                              .content!
                                                              .classes
                                                              .instructor
                                                              .profilePicture,
                                                          imageRadius: 35,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 3),
                                                  Text(
                                                    classDetailsModel!.content!.classes
                                                        .instructor.firstname +
                                                        '\n' +
                                                        classDetailsModel!.content!.classes
                                                            .instructor.lastname,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ]),
                    ),
                    PositionedDirectional(
                      bottom: 0,
                      start: 0,
                      end: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  ColorRes.white.withOpacity(0.5),
                                  ColorRes.whiteGradient.withOpacity(0.1),
                                ],
                                stops: [
                                  0.3,
                                  1
                                ])
                          // boxShadow: [BoxShadow(color: ColorRes.white, blurRadius: 20, spreadRadius: 20)],
                        ),
                        height: MediaQuery.of(context).size.height * 0.18,
                        padding: EdgeInsetsDirectional.only(start: 17, end: 17),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomButton(
                                onTap: () {
                                  if (appState.userId != null) {
                                    NavigationUtils.push(
                                        context, routeVideoPlayer, arguments: {
                                      "videoUrl": state.classDetailsModel
                                          .content!.classes.videoUrl
                                    });
                                  } else {
                                    NavigationUtils.push(
                                        context, routeLoginSignup);
                                  }
                                },
                                buttonText: AppLocalizations.of(context)!
                                    .translate("start_watching"),
                                backgroundColor: ColorRes.primaryColor,
                                foregroundColor: ColorRes.whiteGradient,
                                borderColor: ColorRes.primaryColor,
                                textStyle: TextStyles.SB18FF),
                            SizedBox(height: 15),
                            CustomButton(
                                onTap: () {
                                  if (appState.userId != null) {
                                    /// TODO: ADD TO MY WISHLIST LOGIC
                                  } else {
                                    NavigationUtils.push(
                                        context, routeLoginSignup);
                                  }
                                },
                                buttonText: AppLocalizations.of(context)!
                                    .translate("add_to_my_list"),
                                backgroundColor: ColorRes.greyText,
                                foregroundColor: ColorRes.whiteGradient,
                                borderColor: ColorRes.greyText,
                                textStyle: TextStyles.SB18FF),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Scaffold(
            body: LoadingWidget(),
          );
        },
      ),
    );
  }

  void _dateRangePicker(BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: (_) =>
            Center(
              child: Container(
                margin: EdgeInsetsDirectional.only(start:20, end: 20),
                child: CupertinoActionSheet(
                  title:Text("Pick a date", style: TextStyle(color: Colors.black),),
                  actions: [
                    Container(
                      height: 170,
                      child: CupertinoDatePicker(
                          minimumDate: DateTime.now(),
                          initialDateTime: selectedDate != null ? selectedDate : DateTime.now(),
                          onDateTimeChanged: (val) {
                            setState(() {
                              selectedDate = val;
                            });
                          }),
                    ),
                    CupertinoDialogAction(
                      child: Text('Confirm'),
                      onPressed: () {
                        if(selectedDate != null){
                          // Timestamp mytimeStamp = Timestamp.fromDate(selectedDate);
                          // DateTime myDateTime = mytimeStamp.toDate();
                          print(selectedDate!.millisecondsSinceEpoch.toString());
                          Navigator.pop(context);
                          /// TODO: ADD WATCH LATER API
                          setState(() {});
                        }
                        else {
                          ToastUtils.showFailed(message: "Date not selected");
                        }
                        },
                    ),
                  ],
                ),
              ),
            )
    );
  }

  Future<void> _handleClickMe(BuildContext context) async {
    return showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: new Text("Time to Watch"),
          content: new Text("Do you need to set a time to watch?"),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: (){
                Navigator.pop(context);
                _dateRangePicker(context);
              },
              child: Text("Yes"),
            ),
            CupertinoDialogAction(onPressed: (){
              Navigator.pop(context);
            },
              child: Text("Not now"),
            )
          ],

        )
    );
  }
}
