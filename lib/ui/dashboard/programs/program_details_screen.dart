import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shala_yoga/ui/auth/login_signup.dart';
import 'package:shala_yoga/ui/auth/watch_video_login.dart';
import '../../../base/utils/common_methods.dart';
import '../../../base/utils/constants/color_constant.dart';
import '../../../base/utils/constants/image_constant.dart';
import '../../../base/utils/constants/string_res.dart';
import '../../../base/utils/constants/textstyle_constants.dart';
import '../../../base/utils/localization/app_localizations.dart';
import '../../../base/utils/navigation/navigation_route_constants.dart';
import '../../../base/utils/navigation/navigation_utils.dart';
import '../../../base/utils/toast_utils.dart';
import '../../../blocs/favourite_bloc/favourite_bloc.dart';
import '../../../blocs/programs/program_detail_bloc/program_detail_bloc.dart';
import '../../../models/programs/program_details_model.dart';
import '../../classes_widgets/classes_card_widget.dart';
import '../../widgets/circular_image.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_network_image.dart';
import '../../widgets/expand_shrink_text.dart';
import '../../widgets/failure_widget.dart';
import '../../widgets/loading_widget.dart';

class ProgramDetailScreen extends StatefulWidget {
  const ProgramDetailScreen({Key? key}) : super(key: key);

  @override
  _ProgramDetailScreenState createState() => _ProgramDetailScreenState();
}

class _ProgramDetailScreenState extends State<ProgramDetailScreen> {
  bool textDescription = false;
  late ProgramDetailModel? programDetailModel;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<FavouriteBloc, FavouriteState>(
        listener: (context, state) {
          if (state is FavouriteLoading) {
            EasyLoading.show();
          }
          if (state is FavouriteSuccess) {
            EasyLoading.dismiss();
            // ToastUtils.showSuccess(message: state.message);
            programDetailModel!.content!.programs.isFav.value =
                !programDetailModel!.content!.programs.isFav.value;
          }
          if (state is FavouriteFailure) {
            EasyLoading.dismiss();
            ToastUtils.showFailed(message: state.message);
          }
        },
        child: BlocBuilder<ProgramDetailBloc, ProgramDetailState>(
          builder: (context, state) {
            if (state is ProgramDetailFailure) {
              return Scaffold(
                body: FailureWidget(
                  message: state.message,
                ),
              );
            }
            if (state is ProgramDetailSuccess) {
              programDetailModel = state.programDetailModel;
              return Scaffold(
                backgroundColor: ColorRes.white,
                /*bottomNavigationBar: BottomAppBar(
                  elevation: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [
                      ColorRes.green.withOpacity(0.5),
                      ColorRes.green.withOpacity(0.1),
                    ], stops: [
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
                                NavigationUtils.push(context, routeVideoPlayer,
                                    arguments: {"videoUrl": state.programDetailModel.content!.classes[0].videoUrl});
                              } else {
                                NavigationUtils.push(context, routeLoginSignup);
                              }
                            },
                            buttonText: AppLocalizations.of(context)!.translate("start_watching"),
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
                                NavigationUtils.push(context, routeLoginSignup);
                              }
                            },
                            buttonText: AppLocalizations.of(context)!.translate("add_to_my_list"),
                            backgroundColor: ColorRes.greyText,
                            foregroundColor: ColorRes.whiteGradient,
                            borderColor: ColorRes.greyText,
                            textStyle: TextStyles.SB18FF),
                      ],
                    ),
                  ),
                ),*/
                body: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                width: screenWidth(context: context),
                                child: CustomNetworkImage(
                                  imageUrl: state.programDetailModel.content!
                                      .programs.coverImage,
                                  boxFit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(4),
                                    gradient: LinearGradient(
                                  colors: [
                                    ColorRes.white,
                                    ColorRes.white.withOpacity(0.6),
                                    ColorRes.white.withOpacity(0.05),
                                  ],
                                  stops: [0.06, 0.12, 1],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                )),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(
                                          start: 23, end: 23, top: 20),
                                      child: Column(children: [
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Icon(Icons.arrow_back,
                                                  color: ColorRes.white),
                                            ),
                                            Spacer(),
                                            IconButton(
                                                padding: EdgeInsets.zero,
                                                onPressed: () {
                                                  if (appState.userId != null) {
                                                    _handleClickMe(context);
                                                  } else {
                                                    showModalBottomSheet(
                                                        isScrollControlled:
                                                            true,
                                                        enableDrag: true,
                                                        clipBehavior: Clip.none,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10)),
                                                        ),
                                                        context: context,
                                                        builder: (context) => SizedBox(
                                                            height:
                                                                screenHeight(
                                                                    context:
                                                                        context,
                                                                    percent:
                                                                        0.75),
                                                            child:
                                                                LoginSignupScreen()));
                                                  }
                                                },
                                                icon: Icon(Icons.access_time,
                                                    color: ColorRes.white)),
                                            ValueListenableBuilder(
                                              valueListenable:
                                                  programDetailModel!
                                                      .content!.programs.isFav,
                                              builder: (context, value, child) {
                                                return IconButton(
                                                    padding: EdgeInsets.zero,
                                                    onPressed: () {
                                                      if (appState.userId !=
                                                          null) {
                                                        context
                                                            .read<
                                                                FavouriteBloc>()
                                                            .add(AddToFavourite(
                                                              contentType:
                                                                  'Program',
                                                              programId: state
                                                                  .programDetailModel
                                                                  .content!
                                                                  .programs
                                                                  .id,
                                                            ));
                                                      } else {
                                                        showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            enableDrag: true,
                                                            clipBehavior:
                                                                Clip.none,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10)),
                                                            ),
                                                            context: context,
                                                            builder: (context) => SizedBox(
                                                                height: screenHeight(
                                                                    context:
                                                                        context,
                                                                    percent:
                                                                        0.75),
                                                                child:
                                                                    LoginSignupScreen()));
                                                      }
                                                    },
                                                    icon: programDetailModel!
                                                            .content!
                                                            .programs
                                                            .isFav
                                                            .value
                                                        ? Icon(Icons.favorite,
                                                            color: ColorRes.red)
                                                        : Icon(
                                                            Icons
                                                                .favorite_border,
                                                            color: ColorRes
                                                                .white));
                                              },
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Row(
                                          children: [
                                            Icon(Icons.mic,
                                                color: ColorRes.white),
                                            CircleAvatar(
                                              backgroundColor: ColorRes.white,
                                              radius: 10,
                                              child: Text(
                                                  AppLocalizations.of(context)!
                                                      .translate("ar"),
                                                  style: TextStyles.R1075),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                state.programDetailModel
                                                    .content!.programs.title,
                                                style: TextStyles.SB2275,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    NavigationUtils.push(
                                                        context,
                                                        routeVideoPlayer,
                                                        arguments: {
                                                          "videoUrl": state
                                                              .programDetailModel
                                                              .content!
                                                              .programs
                                                              .teaserVideoUrl
                                                        });
                                                  },
                                                  child: SvgPicture.asset(
                                                      ImageRes.red_video_play),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .translate(
                                                            "watch_teaser"),
                                                    style: TextStyles.L1400),
                                                // SizedBox(height: 20)
                                              ],
                                            ),
                                          ],
                                        ),
                                      ]),
                                    ),
                                    PositionedDirectional(
                                      end: -17,
                                      bottom: -150,
                                      child: SvgPicture.asset(
                                          ImageRes.back_rounded),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: 25, end: 23, top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset(ImageRes.yogaStyle),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: Text(
                                          state.programDetailModel.content!
                                              .programs.style
                                              .join(','),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyles.R1475),
                                    ),
                                    Spacer(),
                                    SvgPicture.asset(ImageRes.levels),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: Text(
                                          state.programDetailModel.content!
                                              .programs.level
                                              .join(', '),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyles.R1475),
                                    ),
                                    Spacer(),
                                    SvgPicture.asset(ImageRes.classes_play),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: RichText(
                                        text: TextSpan(
                                            text:
                                                '${state.programDetailModel.content!.programs.count.toString()}\n',
                                            style: TextStyles.R1475,
                                            children: [
                                              TextSpan(
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .translate('classes'),
                                                  style: TextStyles.R1475)
                                            ]),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 22),
                                ExpandShrinkText(
                                    state.programDetailModel.content!.programs
                                        .description,
                                    trimLines: 5,
                                  ),
                            ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.only(start: 25, end: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    AppLocalizations.of(context)!
                                        .translate('program_focus'),
                                    style: TextStyles.R1578),
                                Stack(
                                  children: [
                                    Divider(
                                        color:
                                            ColorRes.greyIcon.withOpacity(0.80),
                                        thickness: 2),
                                    Divider(
                                        color: ColorRes.primaryColor,
                                        thickness: 2,
                                        endIndent: screenWidth(
                                            context: context, percent: 0.60)),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                    state.programDetailModel.content!.programs
                                        .focus
                                        .join(','),
                                    style: TextStyles.R1375),
                                const SizedBox(height: 23),
                                Text(
                                    AppLocalizations.of(context)!
                                        .translate('classes'),
                                    style: TextStyles.R1578),
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Divider(
                                        color:
                                            ColorRes.greyIcon.withOpacity(0.80),
                                        thickness: 2),
                                    Divider(
                                        color: ColorRes.primaryColor,
                                        thickness: 2,
                                        endIndent: screenWidth(
                                            context: context, percent: 0.60)),
                                    PositionedDirectional(
                                        top: -20,
                                        end: 0,
                                        child: Row(
                                          children: [
                                            Container(
                                              color: ColorRes.white,
                                              child: Padding(
                                                padding:
                                                    EdgeInsetsDirectional.only(
                                                        end: 1),
                                                child: Stack(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                        .only(
                                                                    start: 10),
                                                            child: CircleAvatar(
                                                              radius: 21,
                                                              backgroundColor:
                                                                  Color(0xff9A9A9A)
                                                                      .withOpacity(
                                                                          0.5),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                        .only(
                                                                    start: 5),
                                                            child: CircleAvatar(
                                                              radius: 21,
                                                              backgroundColor:
                                                                  Color(
                                                                      0xff9A9A9A),
                                                            ),
                                                          ),
                                                          CircularImage(
                                                            imageUrl: state
                                                                .programDetailModel
                                                                .content!
                                                                .programs
                                                                .instructor
                                                                .profilePicture,
                                                            imageRadius: 21,
                                                          ),
                                                        ],
                                                      ),
                                              ),
                                            ),
                                            SizedBox(width: 15),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .translate(
                                                      "multiple_instructors"),
                                              style: TextStyles.R1200.copyWith(
                                                  color: Colors.black
                                                      .withOpacity(0.5)),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                                const SizedBox(height: 33),
                                Text(
                                    AppLocalizations.of(context)!
                                        .translate("week_1"),
                                    style: TextStyles.SB1555),
                                const SizedBox(height: 5),
                                ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  shrinkWrap: true,
                                  itemCount: state.programDetailModel.content!
                                      .classes.length,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: 30,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      child: InkWell(
                                        onTap: () {
                                          NavigationUtils.push(
                                              context, routeClassDetailsScreen,
                                              arguments: {
                                                'id': state.programDetailModel
                                                    .content!.classes[index].id
                                              });
                                        },
                                        child: ClassesCardWidget(
                                            image: state
                                                .programDetailModel
                                                .content!
                                                .classes[index]
                                                .coverImage,
                                            day: "TUESDAY",
                                            title: state.programDetailModel
                                                .content!.classes[index].title,
                                            style: state
                                                .programDetailModel
                                                .content!
                                                .classes[index]
                                                .style[0],
                                            isLock: state.programDetailModel
                                                .content!.classes[index].isLock,
                                            level: state.programDetailModel
                                                .content!.classes[index].level,
                                            duration: appState
                                                .parseDuration(state
                                                    .programDetailModel
                                                    .content!
                                                    .classes[index]
                                                    .durations)
                                                .inMinutes
                                                .toString(),
                                            language: state.programDetailModel.content!.classes[index].language),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.19),
                        ],
                      ),
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
                                      "videoUrl": state.programDetailModel
                                          .content!.classes[0].videoUrl
                                    });
                                  } else {
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        enableDrag: true,
                                        clipBehavior: Clip.none,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              topLeft: Radius.circular(10)),
                                        ),
                                        context: context,
                                        builder: (context) => SizedBox(
                                            height: screenHeight(
                                                context: context,
                                                percent: 0.75),
                                            child: LoginScreen()));
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
                                    _handleClickMe(context);
                                  } else {
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        enableDrag: true,
                                        clipBehavior: Clip.none,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              topLeft: Radius.circular(10)),
                                        ),
                                        context: context,
                                        builder: (context) => SizedBox(
                                            height: screenHeight(
                                                context: context,
                                                percent: 0.75),
                                            child: LoginSignupScreen()));
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
                    )
                  ],
                ),
              );
            }
            return Scaffold(
              body: LoadingWidget(),
            );
          },
        ),
      ),
    );
  }

  void _dateRangePicker(BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: (_) => Center(
              child: Container(
                margin: EdgeInsetsDirectional.only(start: 20, end: 20),
                child: CupertinoActionSheet(
                  title: Text(
                    "Pick a date",
                    style: TextStyle(color: Colors.black),
                  ),
                  actions: [
                    Container(
                      height: 170,
                      child: CupertinoDatePicker(
                          minimumDate: DateTime.now(),
                          initialDateTime: selectedDate != null
                              ? selectedDate
                              : DateTime.now(),
                          onDateTimeChanged: (val) {
                            setState(() {
                              selectedDate = val;
                            });
                          }),
                    ),
                    CupertinoDialogAction(
                      child: Text('Confirm'),
                      onPressed: () {
                        if (selectedDate != null) {
                          // Timestamp mytimeStamp = Timestamp.fromDate(selectedDate);
                          // DateTime myDateTime = mytimeStamp.toDate();
                          print(
                              selectedDate!.millisecondsSinceEpoch.toString());
                          Navigator.pop(context);

                          /// TODO: ADD WATCH LATER API
                          setState(() {});
                        } else {
                          ToastUtils.showFailed(message: "Date not selected");
                        }
                      },
                    ),
                  ],
                ),
              ),
            ));
  }

  Future<void> _handleClickMe(BuildContext context) async {
    return showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: new Text("Time to Watch"),
              content: new Text("Do you need to set a time to watch?"),
              actions: <Widget>[
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.pop(context);
                    _dateRangePicker(context);
                  },
                  child: Text("Yes"),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Not now"),
                )
              ],
            ));
  }
}
