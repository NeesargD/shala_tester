import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';
import 'package:shala_yoga/base/utils/constants/image_constant.dart';
import 'package:shala_yoga/base/utils/constants/string_res.dart';
import 'package:shala_yoga/blocs/instructor_bloc/instructor_bloc.dart';
import 'package:shala_yoga/blocs/instructor_details_bloc/instructor_details_bloc.dart';
import 'package:shala_yoga/blocs/recommended_bloc/recommendation_bloc.dart';
import 'package:shala_yoga/ui/dashboard/home/home.dart';
import 'package:shala_yoga/ui/dashboard/programs/programs_screen.dart';
import 'package:shala_yoga/ui/dashboard/recommendation/recommendation_screen.dart';
import 'package:shala_yoga/ui/instructors/instructor_details_screen.dart';
import 'package:shala_yoga/ui/instructors/instructor_screen.dart';
import 'package:shala_yoga/ui/setting/setting_screen.dart';
import 'package:shala_yoga/ui/widgets/bottom_sheet.dart';

import 'classes/classes_screen.dart';

class DashboardScreen extends StatefulWidget {
  final int index;

  const DashboardScreen({Key? key, this.index = 0}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late ValueNotifier<int> _currentIndex;

  void _onTap(int index) {
    _currentIndex.value = index;
  }

  @override
  void initState() {
    _currentIndex = ValueNotifier(widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder<int>(
        builder: (context, value, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                IndexedStack(
                  index: value,
                  children: [
                    HomeScreen(),
                    ClassesScreen(),
                    ProgramsScreen(),
                    BlocProvider(
                      create: (context) => InstructorBloc(),
                      child: InstructorScreen(),
                    ),
                    Center(
                      child: Text('Under Development'),
                    ),
                    BlocProvider(
                      create: (context) =>
                          RecommendationBloc(),
                      child: RecommendationScreen(),
                    ),
                  ],
                ),
              ],
            ),
            bottomNavigationBar: BottomAppBar(
              child: Container(
                margin: EdgeInsetsDirectional.only(top: 18),
                height: kToolbarHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          _onTap(0);
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              ImageRes.home,
                              color: _currentIndex.value == 0
                                  ? ColorRes.primaryColor
                                  : ColorRes.greyIcon,
                              height: 20,
                              width: 20,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: 6),
                            Text(
                              "Home",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: _currentIndex.value == 0
                                      ? ColorRes.primaryColor
                                      : ColorRes.greyText),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          _onTap(1);
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              ImageRes.play,
                              color: _currentIndex.value == 1
                                  ? ColorRes.primaryColor
                                  : ColorRes.greyIcon,
                              height: 20,
                              width: 20,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: 6),
                            Text(
                              "CLASSES",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: _currentIndex.value == 1
                                      ? ColorRes.primaryColor
                                      : ColorRes.greyText),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          _onTap(2);
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              ImageRes.programs,
                              color: _currentIndex.value == 2
                                  ? ColorRes.primaryColor
                                  : ColorRes.greyIcon,
                              height: 20,
                              width: 20,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: 6),
                            Text(
                              "PROGRAMS",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: _currentIndex.value == 2
                                      ? ColorRes.primaryColor
                                      : ColorRes.greyText),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          _onTap(3);
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              ImageRes.yogaPosture,
                              color: _currentIndex.value == 3
                                  ? ColorRes.primaryColor
                                  : ColorRes.greyIcon,
                              height: 20,
                              width: 20,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: 6),
                            Text(
                              "INSTRUCTORS",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: _currentIndex.value == 3
                                      ? ColorRes.primaryColor
                                      : ColorRes.greyText),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          _onTap(4);
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              ImageRes.myPractice,
                              color: _currentIndex.value == 4
                                  ? ColorRes.primaryColor
                                  : ColorRes.greyIcon,
                              height: 20,
                              width: 20,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: 6),
                            Text(
                              "MY PRACTICE",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: _currentIndex.value == 4
                                      ? ColorRes.primaryColor
                                      : ColorRes.greyText),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        valueListenable: _currentIndex,
      ),
    );
  }
}
