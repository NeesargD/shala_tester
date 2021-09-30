import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../base/utils/common_methods.dart';
import '../../base/utils/navigation/navigation_route_constants.dart';
import '../../base/utils/navigation/navigation_utils.dart';
import '../classes_widgets/classes_grid_widget.dart';
import '../program_widgets/program_grid_widget.dart';
import '../widgets/failure_widget.dart';
import '../widgets/loading_widget.dart';
import '../../blocs/filter/post_filter/post_filter_bloc.dart';
import '../../base/utils/constants/color_constant.dart';
import '../../base/utils/constants/textstyle_constants.dart';
import '../../base/utils/localization/app_localizations.dart';

class SearchResult extends StatefulWidget {
  final int startDuration;
  final int endDuration;
  final List<String> focus;
  final List<String> language;
  final List<String> style;
  final List<String> level;
  final List<String> instructor;

  SearchResult(
      {required this.startDuration,
      required this.endDuration,
      required this.focus,
      required this.language,
      required this.style,
      required this.level,
      required this.instructor});

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  int? counter;

  @override
  void initState() {
    tabController = new TabController(length: 2, vsync: this);

    context.read<PostFilterBloc>()
      ..add(PostAllFilter(
          startDuration: widget.startDuration,
          endDuration: widget.endDuration,
          language: widget.language,
          level: widget.level,
          style: widget.style,
          focus: widget.focus,
          instructor: widget.instructor));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorRes.appBarColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.clear,
            color: ColorRes.greyText,
          ),
        ),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.translate('search_result'),
          style: TextStyles.L2075,
        ),
        actions: [
          IconButton(
              onPressed: () {
                NavigationUtils.pop(context);
              },
              icon: Icon(
                Icons.search,
                color: ColorRes.greyText,
              )),
        ],
      ),
      body: BlocBuilder<PostFilterBloc, PostFilterState>(
        builder: (context, state) {
          if (state is PostFilterFailure) {
            return FailureWidget(message: state.message);
          }
          if (state is PostFilterSuccess) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 40,
                      width: screenWidth(context: context, percent: 0.6),
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsetsDirectional.only(
                                  start: 5, top: 10, bottom: 2),
                              padding: EdgeInsetsDirectional.only(
                                  top: 5, bottom: 5, start: 15, end: 15),
                              decoration: BoxDecoration(
                                color: ColorRes.primaryColor,
                                borderRadius: BorderRadius.circular(23.5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("FILTER", style: TextStyles.R14FF),
                                  SizedBox(width: 5),
                                  GestureDetector(
                                    onTap: () {
                                      NavigationUtils.pop(context);
                                    },
                                    child: Icon(Icons.clear,
                                        color: ColorRes.white, size: 15),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(width: 5);
                          },
                          itemCount: 9),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(top: 5),
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.more_horiz_rounded,
                              color: ColorRes.greyText)),
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(top: 10),
                      padding: EdgeInsetsDirectional.only(
                          start: 10, end: 10, top: 2, bottom: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: ColorRes.greyText),
                      ),
                      child: Text(
                          AppLocalizations.of(context)!.translate("clear_all"),
                          style: TextStyles.R1475),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 10, end: 120),
                  child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelStyle: TextStyles.SB1578,
                      labelColor: ColorRes.primaryColor,
                      indicatorColor: ColorRes.primaryColor,
                      controller: tabController,
                      unselectedLabelStyle: TextStyles.SB15AF,
                      unselectedLabelColor: ColorRes.unselectedTextGrey,
                      tabs: [
                        Tab(
                            text: AppLocalizations.of(context)!
                                .translate("programs")),
                        Tab(
                            text: AppLocalizations.of(context)!
                                .translate('classes')),
                      ]),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Container(
                          margin: EdgeInsetsDirectional.only(
                              start: 20, end: 20, top: 10),
                          child: state.postFilterModel.content!.programs.isEmpty
                              ? Center(child: Text("NO PROGRAMS AVAILABLE"))
                              : GridView.builder(
                                  padding: EdgeInsets.zero,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 0.74,
                                          mainAxisSpacing: 15,
                                          crossAxisSpacing: 15,
                                          crossAxisCount: 2),
                                  itemCount: state
                                      .postFilterModel.content!.programs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(onTap :() {
                                      NavigationUtils.push(
                                          context, routeProgramDetailsScreen,
                                          arguments: {
                                            'id': state.postFilterModel
                                                .content!.programs[index].id
                                          });
                                    },child: ProgramGridWidget(
                                        programDetails: state.postFilterModel
                                            .content!.programs[index],
                                      ),
                                    );
                                  },
                                )),
                      Container(
                        margin: EdgeInsetsDirectional.only(
                            start: 20, end: 20, top: 10),
                        child: state.postFilterModel.content!.classes.isEmpty
                            ? Center(child: Text("NO CLASSES AVAILABLE"))
                            : GridView.builder(
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 3 / 4,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        crossAxisCount: 2),
                                itemCount: state
                                    .postFilterModel.content!.classes.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                      onTap: () {
                                        NavigationUtils.push(
                                            context, routeClassDetailsScreen,
                                            arguments: {
                                              'id': state.postFilterModel
                                                  .content!.classes[index].id
                                            });
                                      },
                                      child: ClassesGridWidget(
                                        classesDetail: state.postFilterModel
                                            .content!.classes[index],
                                      ));
                                },
                              ),
                      ),
                    ],
                    controller: tabController,
                  ),
                ),
              ],
            );
          }
          return LoadingWidget();
        },
      ),
    );
  }
}
