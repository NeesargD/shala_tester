import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shala_yoga/base/utils/localization/app_localizations.dart';
import 'package:shala_yoga/base/utils/navigation/navigation_route_constants.dart';
import 'package:shala_yoga/base/utils/navigation/navigation_utils.dart';
import 'package:shala_yoga/base/utils/toast_utils.dart';
import 'package:shala_yoga/blocs/instructor_follow_bloc/instructor_follow_bloc.dart';
import 'package:shala_yoga/models/instructor_details_model.dart';
import 'package:shala_yoga/models/instructor_follow_model.dart';
import 'package:shala_yoga/ui/classes_widgets/classes_grid_widget.dart';
import 'package:shala_yoga/ui/program_widgets/program_grid_widget.dart';
import 'package:shala_yoga/ui/widgets/circular_image.dart';
import 'package:shala_yoga/ui/widgets/expand_shrink_text.dart';

import '../../base/utils/constants/color_constant.dart';
import '../../base/utils/constants/textstyle_constants.dart';
import '../../blocs/instructor_details_bloc/instructor_details_bloc.dart';
import '../widgets/custom_button.dart';
import '../widgets/failure_widget.dart';
import '../widgets/loading_widget.dart';

class InstructorDetailProfileScreen extends StatefulWidget {
  final int id;

  InstructorDetailProfileScreen({required this.id});

  @override
  _InstructorDetailProfileScreenState createState() => _InstructorDetailProfileScreenState();
}

class _InstructorDetailProfileScreenState extends State<InstructorDetailProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  bool textDescription = false;
  late InstructorFollowModel _instructorFollowModel;
  late InstructorDetailsModel _instructorDetailsModel;

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
        body: BlocListener<InstructorFollowBloc, InstructorFollowState>(
          listener: (context, stateFollow) {
            if (stateFollow is InstructorFollowSuccess) {
              EasyLoading.dismiss();
              _instructorFollowModel = stateFollow.instructorFollowModel;
              context.read<InstructorDetailsBloc>().add(GetInstructorDetailsScreen(id: widget.id));
            }
            if (stateFollow is InstructorFollowFailure) {
              EasyLoading.dismiss();
              ToastUtils.showFailed(message: stateFollow.message);
            }
          },
          child: BlocBuilder<InstructorDetailsBloc, InstructorDetailsState>(builder: (context, state) {
            if (state is InstructorDetailsFailure) {
              return FailureWidget(message: state.message);
            }
            if (state is InstructorDetailsSuccess) {
              _instructorDetailsModel = state.instructorDetailsModel;
              return Stack(
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
                            child: CircularImage(
                              imageUrl: state.instructorDetailsModel.content!.instructorDetails.profilePicture,
                              imageRadius: 65,
                            ),
                          ),
                          SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    state.instructorDetailsModel.content!.instructorDetails.firstname +
                                        ' ' +
                                        state.instructorDetailsModel.content!.instructorDetails.lastname,
                                    style: TextStyles.SB1878),
                                Text(
                                    state.instructorDetailsModel.content!.instructorDetails.state +
                                        ',' +
                                        state.instructorDetailsModel.content!.instructorDetails.country,
                                    style: TextStyles.R1375),
                                SizedBox(height: 11),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('${state.instructorDetailsModel.content!.instructorDetails.follower}',
                                              style: TextStyles.R1875),
                                          Text(AppLocalizations.of(context)!.translate("followers"),
                                              style: TextStyles.R1275),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('${state.instructorDetailsModel.content!.instructorDetails.classes}',
                                              style: TextStyles.R1875),
                                          Text(AppLocalizations.of(context)!.translate("classes"),
                                              style: TextStyles.R1275),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('${state.instructorDetailsModel.content!.instructorDetails.program}',
                                              style: TextStyles.R1875),
                                          Text(AppLocalizations.of(context)!.translate("programs"),
                                              style: TextStyles.R1275),
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
                        margin: EdgeInsetsDirectional.only(start: 25, end: 25, bottom: 0),
                        child: ExpandShrinkText(
                          state.instructorDetailsModel.content!.instructorDetails.description,
                          trimLines: 3,
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
                                Tab(text: AppLocalizations.of(context)!.translate('classes')),
                                Tab(text: AppLocalizations.of(context)!.translate("programs")),
                              ]),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            Container(
                              margin: EdgeInsetsDirectional.only(start: 20, end: 20, top: 10),
                              child: GridView.builder(
                                padding: EdgeInsets.zero,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.74,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 15,
                                    crossAxisCount: 2),
                                itemCount: state.instructorDetailsModel.content!.instructorsClasses.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      NavigationUtils.push(context, routeClassDetailsScreen, arguments: {
                                        'id': state.instructorDetailsModel.content!.instructorsClasses[index].id
                                      });
                                    },
                                    child: ClassesGridWidget(
                                        classesDetail: state.instructorDetailsModel.content!.instructorsClasses[index]),
                                  );
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsetsDirectional.only(start: 20, end: 20, top: 10),
                              child: GridView.builder(
                                padding: EdgeInsets.zero,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 3 / 4,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 15,
                                    crossAxisCount: 2),
                                itemCount: state.instructorDetailsModel.content!.instructorsPrograms.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      NavigationUtils.push(context, routeProgramDetailsScreen, arguments: {
                                        "id": state.instructorDetailsModel.content!.instructorsPrograms[index].id
                                      });
                                    },
                                    child: ProgramGridWidget(
                                        programDetails:
                                            state.instructorDetailsModel.content!.instructorsPrograms[index]),
                                  );
                                },
                              ),
                            ),
                          ],
                          controller: _tabController,
                        ),
                      ),
                      Container(
                        margin: EdgeInsetsDirectional.only(start: 35, end: 35, bottom: 10, top: 5),
                        child: CustomButton(
                            onTap: () {
                              context
                                  .read<InstructorFollowBloc>()
                                  .add(GetInstructorFollowScreen(instructorID: widget.id));
                            },
                            buttonText: _instructorDetailsModel.content!.instructorDetails.isFollow
                                ? AppLocalizations.of(context)!.translate("following")
                                : AppLocalizations.of(context)!.translate("follow"),
                            backgroundColor: _instructorDetailsModel.content!.instructorDetails.isFollow
                                ? ColorRes.primaryColor
                                : ColorRes.white,
                            foregroundColor: ColorRes.white,
                            borderColor: ColorRes.primaryColor,
                            textStyle: _instructorDetailsModel.content!.instructorDetails.isFollow
                                ? TextStyles.SB1878.copyWith(color: ColorRes.white)
                                : TextStyles.SB1878),
                      )
                    ],
                  ),
                ],
              );
            }
            return LoadingWidget();
          }),
        ),
      ),
    );
  }
}
