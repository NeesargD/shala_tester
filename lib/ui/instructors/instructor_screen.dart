import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shala_yoga/base/utils/localization/app_localizations.dart';

import '../../base/utils/common_methods.dart';
import '../../base/utils/constants/color_constant.dart';
import '../../base/utils/constants/string_res.dart';
import '../../base/utils/constants/textstyle_constants.dart';
import '../../base/utils/navigation/navigation_route_constants.dart';
import '../../base/utils/navigation/navigation_utils.dart';
import '../../blocs/instructor_bloc/instructor_bloc.dart';
import '../widgets/circular_image.dart';
import '../widgets/failure_widget.dart';
import '../widgets/loading_widget.dart';

class InstructorScreen extends StatefulWidget {
  const InstructorScreen({Key? key}) : super(key: key);

  @override
  _InstructorScreenState createState() => _InstructorScreenState();
}

class _InstructorScreenState extends State<InstructorScreen> {
  @override
  void initState() {
    context.read<InstructorBloc>().add(GetInstructorScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // toolbarHeight: 80,
          centerTitle: true,
          elevation: 0,
          backgroundColor: ColorRes.appBarColor,
          title: Text(AppLocalizations.of(context)!.translate("instructors"), style: TextStyles.L2075),
        ),
        body: BlocBuilder<InstructorBloc, InstructorState>(
          builder: (context, state) {
            if (state is InstructorFailure) {
              return FailureWidget(message: state.message);
            }
            if (state is InstructorSuccess) {
              return Container(
                margin: EdgeInsetsDirectional.only(start: 20, top: 34, end: 20),
                child: ListView.separated(
                  itemCount: state.instructorModel.content!.instructors.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        NavigationUtils.push(context, routeInstructorDetails,
                            arguments: {'id': state.instructorModel.content!.instructors[index].id});
                      },
                      child: Container(
                        color: ColorRes.appBarColor,
                        padding: EdgeInsetsDirectional.only(start: 10, end: 10, top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircularImage(imageUrl: state.instructorModel.content!.instructors[index].profilePicture),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(start: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${state.instructorModel.content!.instructors[index].firstname}' +
                                        ' ${state.instructorModel.content!.instructors[index].lastname}',
                                    style: TextStyles.SB1578,
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(
                                    width: screenWidth(context: context, percent: 0.30),
                                    child: Text(state.instructorModel.content!.instructors[index].style.join(","),
                                        style: TextStyles.R1375),
                                  )
                                ],
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.mic,
                              color: ColorRes.lightGrey,
                              size: 20,
                            ),
                            if (state.instructorModel.content!.instructors[index].languages.isNotEmpty)
                              SizedBox(
                                height: 80,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.instructorModel.content!.instructors[index].languages.length,
                                  itemBuilder: (BuildContext context, int i) {
                                    return Padding(
                                      padding: const EdgeInsetsDirectional.only(end: 5),
                                      child: CircleAvatar(
                                        backgroundColor: ColorRes.lightGrey,
                                        radius: 10,
                                        child: Text(
                                            '${state.instructorModel.content!.instructors[index].languages[i].substring(0, 2)}',
                                            style: TextStyles.R10FF),
                                      ),
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 16);
                  },
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
