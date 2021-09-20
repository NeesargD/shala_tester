import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shala_yoga/base/utils/toast_utils.dart';
import 'package:shala_yoga/blocs/favourite_bloc/favourite_bloc.dart';
import '../../widgets/expand_shrink_text.dart';
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
      child: BlocListener<FavouriteBloc, FavouriteState>(
        listener: (context, state) {
          if (state is FavouriteLoading) {
            EasyLoading.show();
          }
          if (state is FavouriteSuccess) {
            EasyLoading.dismiss();
            ToastUtils.showSuccess(message: state.message);
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
              return Scaffold(
                backgroundColor: ColorRes.white,
                bottomNavigationBar: BottomAppBar(
                  elevation: 0,
                  child: Container(
                    decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [ColorRes.white, ColorRes.whiteGradient])),
                    height: MediaQuery.of(context).size.height * 0.18,
                    margin: EdgeInsetsDirectional.only(start: 17, end: 17, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomButton(
                            onTap: () {
                              if (appState.resLoginModel!.id != null) {
                                NavigationUtils.push(context, routeVideoPlayer, arguments: {"videoUrl": state.programDetailModel.content!.classes[0].videoUrl});
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
                            onTap: () {},
                            buttonText: AppLocalizations.of(context)!.translate("add_to_my_list"),
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: CustomNetworkImage(
                            imageUrl: state.programDetailModel.content!.programs.coverImage,
                            boxFit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.4,
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
                                padding: EdgeInsetsDirectional.only(start: 25, end: 23, top: 20),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(Icons.arrow_back, color: ColorRes.white, size: 26),
                                      ),
                                      Spacer(),
                                      Icon(Icons.access_time, color: ColorRes.white, size: 26),
                                      SizedBox(width: 20),
                                      IconButton(
                                          onPressed: () {
                                            context.read<FavouriteBloc>().add(AddToFavourite(
                                                  contentType: 'Program',
                                                  programId: state.programDetailModel.content!.programs.id,
                                                ));
                                          },
                                          icon:
                                              state.programDetailModel.content!.programs.isFavourite ? Icon(Icons.favorite, color: ColorRes.red) : Icon(Icons.favorite_border, color: ColorRes.white)),
                                    ],
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Icon(Icons.mic, color: ColorRes.white),
                                      CircleAvatar(
                                        backgroundColor: ColorRes.white,
                                        radius: 10,
                                        child: Text(AppLocalizations.of(context)!.translate("ar"), style: TextStyles.R1075),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          state.programDetailModel.content!.programs.title,
                                          style: TextStyles.SB2275,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              NavigationUtils.push(context, routeVideoPlayer, arguments: {"videoUrl": state.programDetailModel.content!.programs.teaserVideoUrl});
                                            },
                                            child: SvgPicture.asset(ImageRes.red_video_play),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(AppLocalizations.of(context)!.translate("watch_teaser"), style: TextStyles.L1400),
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
                                child: SvgPicture.asset(ImageRes.back_rounded),
                              ),
                            ],
                          ),
                        ),
                      ]),
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 25, end: 23, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                  child: Text(state.programDetailModel.content!.programs.style.join(','), overflow: TextOverflow.ellipsis, maxLines: 2, style: TextStyles.R1475),
                                ),
                                Spacer(),
                                SvgPicture.asset(ImageRes.levels),
                                const SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Text(state.programDetailModel.content!.programs.level.join(', '), overflow: TextOverflow.ellipsis, maxLines: 2, style: TextStyles.R1475),
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
                                        text: '${state.programDetailModel.content!.programs.count.toString()}\n',
                                        style: TextStyles.R1475,
                                        children: [TextSpan(text: AppLocalizations.of(context)!.translate('classes'), style: TextStyles.R1475)]),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 22),
                            ExpandShrinkText(
                              state.programDetailModel.content!.programs.description,
                              trimLines: 5,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 25, end: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context)!.translate('program_focus'), style: TextStyles.R1578),
                            Stack(
                              children: [
                                Divider(color: ColorRes.greyIcon.withOpacity(0.80), thickness: 2),
                                Divider(color: ColorRes.primaryColor, thickness: 2, endIndent: screenWidth(context: context, percent: 0.60)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(state.programDetailModel.content!.programs.focus.join(','), style: TextStyles.R1375),
                            const SizedBox(height: 23),
                            Text(AppLocalizations.of(context)!.translate('classes'), style: TextStyles.R1578),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Divider(color: ColorRes.greyIcon.withOpacity(0.80), thickness: 2),
                                Divider(color: ColorRes.primaryColor, thickness: 2, endIndent: screenWidth(context: context, percent: 0.60)),
                                PositionedDirectional(
                                    top: -20,
                                    end: 0,
                                    child: Row(
                                      children: [
                                        Container(
                                          color: ColorRes.white,
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.only(end: 1),
                                            child: CircularImage(
                                              imageUrl: state.programDetailModel.content!.programs.instructor.profilePicture,
                                              imageRadius: 21,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 15),
                                        Text(
                                          AppLocalizations.of(context)!.translate("multiple_instructors"),
                                          style: TextStyles.R1200,
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                            const SizedBox(height: 33),
                            Text(AppLocalizations.of(context)!.translate("week_1"), style: TextStyles.SB1555),
                            const SizedBox(height: 5),
                            ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              shrinkWrap: true,
                              itemCount: state.programDetailModel.content!.classes.length,
                              separatorBuilder: (context, index) => SizedBox(
                                height: 30,
                              ),
                              itemBuilder: (context, index) {
                                return Container(
                                  child: InkWell(
                                    onTap: () {
                                      NavigationUtils.push(context, routeClassDetailsScreen, arguments: {'id': state.programDetailModel.content!.classes[index].id});
                                    },
                                    child: ClassesCardWidget(
                                        image: state.programDetailModel.content!.classes[index].coverImage,
                                        day: "TUESDAY",
                                        title: state.programDetailModel.content!.classes[index].title,
                                        style: state.programDetailModel.content!.classes[index].style[0],
                                        isLock: state.programDetailModel.content!.classes[index].isLock,
                                        level: state.programDetailModel.content!.classes[index].level,
                                        duration: appState.parseDuration(state.programDetailModel.content!.classes[index].durations).inMinutes.toString(),
                                        language: state.programDetailModel.content!.classes[index].language),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
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
      ),
    );
  }
}
