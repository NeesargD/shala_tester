import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../base/utils/common_methods.dart';
import '../../../base/utils/constants/color_constant.dart';
import '../../../base/utils/constants/image_constant.dart';
import '../../../base/utils/constants/string_res.dart';
import '../../../base/utils/constants/textstyle_constants.dart';
import '../../../base/utils/localization/app_localizations.dart';
import '../../../base/utils/navigation/navigation_route_constants.dart';
import '../../../base/utils/navigation/navigation_utils.dart';
import '../../../blocs/programs/program_detail_bloc/program_detail_bloc.dart';
import '../../classes_widgets/classes_card_widget.dart';
import '../../widgets/circular_image.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_network_image.dart';
import '../../widgets/failure_widget.dart';
import '../../widgets/loading_widget.dart';

class ProgramDetailScreen extends StatefulWidget {
  const ProgramDetailScreen({Key? key}) : super(key: key);

  @override
  _ProgramDetailScreenState createState() => _ProgramDetailScreenState();
}

class _ProgramDetailScreenState extends State<ProgramDetailScreen> {

  bool textDescription = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            return Scaffold(
              backgroundColor: ColorRes.white,
              bottomNavigationBar: BottomAppBar(
                elevation: 0,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [ColorRes.white, ColorRes.whiteGradient])),
                  height: MediaQuery.of(context).size.height * 0.18,
                  margin:
                      EdgeInsetsDirectional.only(start: 17, end: 17, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomButton(
                          onTap: () {},
                          buttonText: 'START WATCHING',
                          backgroundColor: ColorRes.primaryColor,
                          foregroundColor: ColorRes.whiteGradient,
                          borderColor: ColorRes.primaryColor,
                          textStyle: TextStyles.SB18FF),
                      SizedBox(height: 15),
                      CustomButton(
                          onTap: () {},
                          buttonText: 'ADD TO MY LIST',
                          backgroundColor: ColorRes.greyText,
                          foregroundColor: ColorRes.whiteGradient,
                          borderColor: ColorRes.greyText,
                          textStyle: TextStyles.SB18FF),
                    ],
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: CustomNetworkImage(
                          imageUrl: state
                              .programDetailModel.content!.programs.coverImage,
                          boxFit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            gradient: LinearGradient(
                              colors: [
                                ColorRes.white,
                                ColorRes.white.withOpacity(0.4),
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
                                  start: 25, end: 23, top: 40),
                              child: Column(children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(Icons.arrow_back,
                                          color: ColorRes.white, size: 26),
                                    ),
                                    Spacer(),
                                    Icon(Icons.access_time,
                                        color: ColorRes.white, size: 26),
                                    SizedBox(width: 20),
                                    Icon(
                                      Icons.favorite_border,
                                      color: ColorRes.white,
                                      size: 26,
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Icon(Icons.mic, color: ColorRes.white),
                                    CircleAvatar(
                                      backgroundColor: ColorRes.white,
                                      radius: 10,
                                      child:
                                          Text('AR', style: TextStyles.R1075),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            EdgeInsetsDirectional.only(end: 80),
                                        child: Text(
                                          state.programDetailModel.content!
                                              .programs.title,
                                          style: TextStyles.SB2275,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            ImageRes.red_video_play),
                                        Text("Watch teaser",
                                            style: TextStyles.L1400),
                                        SizedBox(height: 20)
                                      ],
                                    ),
                                  ],
                                ),
                              ]),
                            ),
                            PositionedDirectional(
                              end: -17,
                              bottom: -150,
                              child: SvgPicture.asset(ImageRes.back_rounded),
                            ),
                          ],
                        ),
                      ),
                    ]),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          start: 25, end: 23, top: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(ImageRes.yogaStyle),
                              const SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                flex: 2,
                                child: Text(
                                    state.programDetailModel.content!.programs
                                        .style
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
                                    state.programDetailModel.content!.programs
                                        .level
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
                                            text: AppLocalizations.of(context)!
                                                .translate('classes'),
                                            style: TextStyles.R1475)
                                      ]),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 22),
                          Container(
                            child: Column(
                              children: [
                                Text(state.programDetailModel.content!.programs.description,
                                  maxLines: textDescription ? state
                                      .programDetailModel.content!.programs.description
                                      .length
                                      : 2,
                                  style: TextStyles.R1375,
                                  textAlign: TextAlign.justify,
                                ),
                                InkWell(
                                  onTap: (){ setState(() {
                                    textDescription = !textDescription;
                                  }); },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      textDescription ? Text("Show Less",style:
                                      TextStyles.R1578) :  Text("Show More",style:
                                      TextStyles.R1578),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 25, end: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Program focus", style: TextStyles.R1578),
                          Stack(
                            children: [
                              Divider(
                                  color: ColorRes.greyIcon.withOpacity(0.80),
                                  thickness: 2),
                              Divider(
                                  color: ColorRes.primaryColor,
                                  thickness: 2,
                                  endIndent: screenWidth(
                                      context: context, percent: 0.60)),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                              state.programDetailModel.content!.programs.focus
                                  .join(','),
                              style: TextStyles.R1375),
                          SizedBox(height: 23),
                          Text(
                              AppLocalizations.of(context)!
                                  .translate('classes'),
                              style: TextStyles.R1578),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Divider(
                                  color: ColorRes.greyIcon.withOpacity(0.80),
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
                                          padding: EdgeInsetsDirectional.only
                                            (end: 1),
                                          child: CircularImage(
                                            imageUrl: state
                                                .programDetailModel
                                                .content!
                                                .programs
                                                .instructor
                                                .profilePicture,
                                            imageRadius: 21,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 15),
                                      Text(
                                        "Multiple "
                                            "Instructors",
                                        style: TextStyles.R1200,
                                      ),
                                    ],
                                  )),
                              ],
                          ),
                          SizedBox(height: 33),
                          Text("WEEK 1", style: TextStyles.SB1555),
                          SizedBox(height: 5),
                          ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            shrinkWrap: true,
                            itemCount: state
                                .programDetailModel.content!.classes.length,
                            separatorBuilder: (context, index) => SizedBox(
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
                                      image: state.programDetailModel.content!
                                          .classes[index].coverImage,
                                      day: "TUESDAY",
                                      title: state.programDetailModel.content!
                                          .classes[index].title,
                                      style: state.programDetailModel.content!
                                          .classes[index].style[0],
                                      isLock: state.programDetailModel.content!
                                          .classes[index].isLock,
                                      level: state.programDetailModel.content!
                                          .classes[index].level,
                                      duration: appState
                                          .parseDuration(state
                                              .programDetailModel
                                              .content!
                                              .classes[index]
                                              .durations)
                                          .inMinutes
                                          .toString(),
                                      language: state.programDetailModel
                                          .content!.classes[index].language),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
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
}
