import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shala_yoga/base/utils/common_methods.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';
import 'package:shala_yoga/base/utils/constants/textstyle_constants.dart';
import 'package:shala_yoga/base/utils/localization/app_localizations.dart';
import 'package:shala_yoga/base/utils/navigation/navigation_route_constants.dart';
import 'package:shala_yoga/base/utils/navigation/navigation_utils.dart';
import 'package:shala_yoga/blocs/home/home_bloc/home_bloc.dart';
import 'package:shala_yoga/ui/classes_widgets/classes_recommendation_widgets.dart';
import 'package:shala_yoga/ui/classes_widgets/classes_recommended_with_circleAvatar.dart';
import 'package:shala_yoga/ui/program_widgets/program_grid_recommended.dart';
import 'package:shala_yoga/ui/widgets/bottom_sheet.dart';
import 'package:shala_yoga/ui/widgets/failure_widget.dart';
import 'package:shala_yoga/ui/widgets/loading_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndexSlider = 0;
  final CarouselController _controller = CarouselController();
  int isRecomeded = 1;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetAllHomes());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorRes.appBarColor,
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeFailure) {
              return FailureWidget(message: state.message);
            }
            if (state is HomeSuccess) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: screenHeight(context: context, percent: 0.30),
                          color: ColorRes.primaryColor,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.only(start: 18, end: 10, top: 40),
                                child: Row(
                                  children: [
                                    Opacity(
                                        opacity: 0.30,
                                        child: Text(AppLocalizations.of(context)!.translate("namaste"),
                                            style: TextStyles.L30FF)),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          NavigationUtils.push(context, routeFilterScreen);
                                        },
                                        icon: Icon(
                                          Icons.search,
                                          color: ColorRes.white,
                                        )),
                                    GestureDetector(
                                      child: Icon(Icons.more_vert, color: ColorRes.white),
                                      onTap: () {
                                        showModalBottomSheet(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                                          ),
                                          context: context,
                                          builder: (context) => BottomSheetWidget(),
                                        );
                                      },
                                    ),
                                    const SizedBox(width: 18)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.only(start: 18, top: 90, end: 18),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                    width: screenWidth(context: context),
                                    height: screenHeight(context: context, percent: 0.30),
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                          width: screenWidth(context: context),
                                          child: CarouselSlider(
                                            items: state.homeModel.content!.banner!
                                                .map((item) => InkWell(
                                                      onTap: () {
                                                        if (item.bannertype == 'classes') {
                                                          NavigationUtils.push(context, routeClassDetailsScreen,
                                                              arguments: {'id': item.classesId});
                                                        } else if (item.bannertype == 'programs') {
                                                          NavigationUtils.push(context, routeProgramDetailsScreen,
                                                              arguments: {'id': item.programId});
                                                        } else if (item.bannertype == 'instructor') {
                                                          NavigationUtils.push(context, routeInstructorDetails,
                                                              arguments: {'id': item.instructorId});
                                                        } else {
                                                         launchURL(item.externallink!);
                                                        }
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.all(5.0),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(10),
                                                            child: Image.network(item.bannerimage!,
                                                                fit: BoxFit.cover,
                                                                width: MediaQuery.of(context).size.width)),
                                                      ),
                                                    ))
                                                .toList(),
                                            carouselController: _controller,
                                            options: CarouselOptions(
                                                autoPlay: false,
                                                aspectRatio: 1,
                                                viewportFraction: 1,
                                                onPageChanged: (index, reason) {
                                                  setState(() {
                                                    _currentIndexSlider = index;
                                                  });
                                                }),
                                          ),
                                        ),
                                        PositionedDirectional(
                                          bottom: 15,
                                          start: 10,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: state.homeModel.content!.banner!.asMap().entries.map((entry) {
                                              return GestureDetector(
                                                onTap: () => _controller.animateToPage(entry.key),
                                                child: Container(
                                                  width: 10.0,
                                                  height: 10.0,
                                                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: _currentIndexSlider == entry.key
                                                          ? ColorRes.primaryColor
                                                          : ColorRes.white),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Text(AppLocalizations.of(context)!.translate("continue_watching"),
                                      style: TextStyles.SB1875),
                                  const SizedBox(height: 16),
                                  Container(
                                    height: 189,
                                    child: ListView.separated(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 5,
                                      itemBuilder: (c, i) {
                                        return RecommendedProgramList(
                                            coverImage: 'assets/shala_tumbnail.jpg',
                                            languages: ['AR'],
                                            title: 'xyz',
                                            style: ['Fitness'],
                                            level: ['Advanced'],
                                            width: 0.75,
                                            countClass: 5);
                                      },
                                      separatorBuilder: (c, i) {
                                        return SizedBox(
                                          width: 15,
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 52),
                                  Text(AppLocalizations.of(context)!.translate("recommended_for_you"),
                                      style: TextStyles.SB1875),
                                  const SizedBox(height: 14),
                                  Container(
                                    height: 189,
                                    child: ListView.separated(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 5,
                                      itemBuilder: (c, i) {
                                        return i == isRecomeded
                                            ? RecommendedClassList(
                                                coverImage: 'assets/shala_tumbnail.jpg',
                                                title: 'ABC',
                                                languages: "AR",
                                                style: "Fitness",
                                                image: "assets/shala_tumbnail.jpg",
                                                level: "Advance",
                                                width: 0.75,
                                                duration: "0")
                                            : RecommendedProgramList(
                                                coverImage: 'assets/shala_tumbnail.jpg',
                                                languages: ['AR'],
                                                title: 'xyz',
                                                style: ['Fitness'],
                                                level: ['Advanced'],
                                                width: 0.75,
                                                countClass: 5);
                                      },
                                      separatorBuilder: (c, i) {
                                        return SizedBox(
                                          width: 15,
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 37),
                                  Text(AppLocalizations.of(context)!.translate("our_recommendation_for_you"),
                                      style: TextStyles.R1575),
                                  Row(
                                    children: [
                                      Text(AppLocalizations.of(context)!.translate("stretching"),
                                          style: TextStyles.SB1878),
                                      Spacer(),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            border: Border.all(color: ColorRes.greyText, width: 1)),
                                        padding: EdgeInsetsDirectional.all(5),
                                        child: Row(
                                          children: [
                                            Icon(Icons.autorenew_rounded, size: 15, color: ColorRes.greyText),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(AppLocalizations.of(context)!.translate("change"),
                                                style: TextStyles.R1275),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  SizedBox(
                                    height: 221,
                                    child: ListView.separated(
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      separatorBuilder: (context, index) => SizedBox(
                                        width: 15,
                                      ),
                                      itemCount: 5,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          width: screenWidth(context: context, percent: 0.40),
                                          child: ClassesRecommendedWidget(
                                              title: "Easy Yoga For Complete Begin For Complete",
                                              language: "AR",
                                              isLock: index == 1 ? true : false,
                                              style: "Fitness",
                                              coverImage: "assets/shala_tumbnail.jpg",
                                              level: "All Level",
                                              durations: "20"),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 35),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: state.homeModel.content!.dynamicContent!.length,
                                    itemBuilder: (context, index) {
                                      if (state.homeModel.content!.dynamicContent![index].uitype == 'classes grid') {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(state.homeModel.content!.dynamicContent![index].title!,
                                                style: TextStyles.SB1875),
                                            const SizedBox(height: 15),
                                            SizedBox(
                                              height: 221,
                                              child: ListView.separated(
                                                padding: EdgeInsets.zero,
                                                scrollDirection: Axis.horizontal,
                                                shrinkWrap: true,
                                                separatorBuilder: (context, index) => SizedBox(
                                                  width: 15,
                                                ),
                                                itemCount: state
                                                    .homeModel.content!.dynamicContent![index].classesContent!.length,
                                                itemBuilder: (context, i) {
                                                  return InkWell(
                                                    onTap: () {
                                                      NavigationUtils.push(context, routeClassDetailsScreen,
                                                          arguments: {
                                                            'id': state.homeModel.content!.dynamicContent![index]
                                                                .classesContent![1].id
                                                          });
                                                    },
                                                    child: Container(
                                                      width: screenWidth(context: context, percent: 0.40),
                                                      child: ClassesRecommendedWidget(
                                                          title: state.homeModel.content!.dynamicContent![index]
                                                              .classesContent![i].title!,
                                                          language: state.homeModel.content!.dynamicContent![index]
                                                              .classesContent![i].language!,
                                                          isLock: state.homeModel.content!.dynamicContent![index]
                                                              .classesContent![i].isLock!,
                                                          style: state.homeModel.content!.dynamicContent![index]
                                                              .classesContent![i].style![0],
                                                          coverImage: state.homeModel.content!.dynamicContent![index]
                                                              .classesContent![i].coverImage!,
                                                          level: state.homeModel.content!.dynamicContent![index]
                                                              .classesContent![i].level!,
                                                          durations: state.homeModel.content!.dynamicContent![index]
                                                              .classesContent![i].durations!),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        );
                                      } else if (state.homeModel.content!.dynamicContent![index].uitype ==
                                          'classes with instructor') {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(state.homeModel.content!.dynamicContent![index].title!,
                                                style: TextStyles.SB1875),
                                            const SizedBox(height: 22),
                                            Container(
                                              height: 189,
                                              child: ListView.separated(
                                                padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.horizontal,
                                                itemCount: state
                                                    .homeModel.content!.dynamicContent![index].classesContent!.length,
                                                itemBuilder: (c, i) {
                                                  return InkWell(
                                                    onTap: () {
                                                      NavigationUtils.push(context, routeClassDetailsScreen,
                                                          arguments: {
                                                            'id': state.homeModel.content!.dynamicContent![index]
                                                                .classesContent![1].id
                                                          });
                                                    },
                                                    child: RecommendedClassList(
                                                        coverImage: state.homeModel.content!.dynamicContent![index]
                                                            .classesContent![i].coverImage!,
                                                        title: state.homeModel.content!.dynamicContent![index]
                                                            .classesContent![i].title!,
                                                        languages: state.homeModel.content!.dynamicContent![index]
                                                            .classesContent![i].language!,
                                                        style: state.homeModel.content!.dynamicContent![index]
                                                            .classesContent![i].style![0],
                                                        image: state.homeModel.content!.dynamicContent![index]
                                                            .classesContent![0].instructor!.profilePicture!,
                                                        level: state.homeModel.content!.dynamicContent![index]
                                                            .classesContent![i].level!,
                                                        duration: state.homeModel.content!.dynamicContent![index]
                                                            .classesContent![i].durations!),
                                                  );
                                                },
                                                separatorBuilder: (c, i) {
                                                  return SizedBox(
                                                    width: 15,
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        );
                                      } else if (state.homeModel.content!.dynamicContent![index].uitype ==
                                          'Program UI') {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(state.homeModel.content!.dynamicContent![index].title!,
                                                style: TextStyles.SB1875),
                                            const SizedBox(height: 22),
                                            Container(
                                              height: 189,
                                              child: ListView.separated(
                                                padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.horizontal,
                                                itemCount: state
                                                    .homeModel.content!.dynamicContent![index].programsContent!.length,
                                                itemBuilder: (c, i) {
                                                  return InkWell(
                                                    onTap: () {
                                                      NavigationUtils.push(context, routeProgramDetailsScreen,
                                                          arguments: {
                                                            'id': state.homeModel.content!.dynamicContent![index]
                                                                .programsContent![1].id
                                                          });
                                                    },
                                                    child: RecommendedProgramList(
                                                        coverImage: state.homeModel.content!.dynamicContent![index]
                                                            .programsContent![i].coverImage!,
                                                        languages: state.homeModel.content!.dynamicContent![index]
                                                            .programsContent![i].languages!,
                                                        title: state.homeModel.content!.dynamicContent![index]
                                                            .programsContent![i].title!,
                                                        style: state.homeModel.content!.dynamicContent![index]
                                                            .programsContent![i].style!,
                                                        level: state.homeModel.content!.dynamicContent![index]
                                                            .programsContent![i].level!,
                                                        width: 0.75,
                                                        countClass: state.homeModel.content!.dynamicContent![index]
                                                            .programsContent![i].count!),
                                                  );
                                                },
                                                separatorBuilder: (c, i) {
                                                  return SizedBox(
                                                    width: 15,
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                      return SizedBox.shrink();
                                    },
                                    separatorBuilder: (BuildContext context, int index) {
                                      return const SizedBox(height: 38);
                                    },
                                  ),

                                  // const SizedBox(height: 45),
                                  // ClassesCardWidget(
                                  //     image: "assets/shala_tumbnail.jpg",
                                  //     day: "TUESDAY",
                                  //     title: "Easy Yoga For "
                                  //         "Complete Begin For Complete",
                                  //     style: "Fitness",
                                  //     level: "All Level",
                                  //     duration: "30",
                                  //     language: "AR"),
                                  const SizedBox(
                                    height: 38,
                                  ),
                                  Text(AppLocalizations.of(context)!.translate("featured_instruction"),
                                      style: TextStyles.SB1875),
                                  const SizedBox(height: 15),
                                  SizedBox(
                                    height: 110,
                                    child: ListView.separated(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          return SizedBox(
                                            width: 100,
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(30),
                                                  child: CircleAvatar(
                                                    radius: 30,
                                                    child: Image.network(
                                                      state
                                                          .homeModel.content!.featureInstructor![index].profilePicture!,
                                                      fit: BoxFit.fill,
                                                      height: 60,
                                                      width: 60,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  state.homeModel.content!.featureInstructor![index].firstname!,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyles.R1575,
                                                ),
                                                Text(
                                                  state.homeModel.content!.featureInstructor![index].languages!
                                                      .join("/"),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyles.R14A2,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return SizedBox(
                                            width: 10,
                                          );
                                        },
                                        itemCount: state.homeModel.content!.featureInstructor!.length),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
            return LoadingWidget();
          },
        ),
      ),
    );
  }
}
