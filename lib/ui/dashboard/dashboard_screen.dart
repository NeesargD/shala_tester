import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shala_yoga/base/utils/localization/app_localizations.dart';
import 'package:shala_yoga/blocs/home/home_bloc/home_bloc.dart';
import 'package:shala_yoga/blocs/programs/programs_bloc/programs_bloc.dart';
import '../../base/utils/constants/color_constant.dart';
import '../../base/utils/constants/image_constant.dart';
import '../../blocs/classes/classes_bloc/classes_bloc.dart';
import '../../blocs/instructor_bloc/instructor_bloc.dart';
import '../../blocs/recommended_bloc/recommendation_bloc.dart';
import 'home/home.dart';
import 'programs/programs_screen.dart';
import 'recommendation/recommendation_screen.dart';
import '../instructors/instructor_screen.dart';

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
            body: IndexedStack(
              index: value,
              children: [
                BlocProvider(
                  create: (context) => HomeBloc(),
                  child: HomeScreen(),
                ),
                BlocProvider(
                  create: (context) => ClassesBloc(),
                  child: ClassesScreen(),
                ),
                BlocProvider(
                  create: (context) => ProgramsBloc(),
                  child: ProgramsScreen(),
                ),
                BlocProvider(
                  create: (context) => InstructorBloc(),
                  child: InstructorScreen(),
                ),
                Center(
                  child: Text('Under Development'),
                ),
                BlocProvider(
                  create: (context) => RecommendationBloc(),
                  child: RecommendationScreen(),
                ),
              ],
            ),
            bottomNavigationBar: BottomAppBar(
              child: Container(
                padding: EdgeInsetsDirectional.only(top: 10, bottom: 10),
                height: kToolbarHeight + 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    bottomAppBarView(
                        onTap: () {
                          _onTap(0);
                        },
                        bottomName: AppLocalizations.of(context)!.translate("home"),
                        imageName: ImageRes.home,
                        index: 0),
                    bottomAppBarView(
                        onTap: () {
                          _onTap(1);
                        },
                        bottomName: AppLocalizations.of(context)!.translate("classes"),
                        imageName: ImageRes.play,
                        index: 1),
                    bottomAppBarView(
                        onTap: () {
                          _onTap(2);
                        },
                        bottomName: AppLocalizations.of(context)!.translate("programs"),
                        imageName: ImageRes.programs,
                        index: 2),
                    bottomAppBarView(
                        onTap: () {
                          _onTap(3);
                        },
                        bottomName: AppLocalizations.of(context)!.translate("instructors"),
                        imageName: ImageRes.yogaPosture,
                        index: 3),
                    bottomAppBarView(
                        onTap: () {
                          _onTap(4);
                        },
                        bottomName: AppLocalizations.of(context)!.translate("my_practice"),
                        imageName: ImageRes.myPractice,
                        index: 4),
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

  Widget bottomAppBarView(
      {VoidCallback? onTap, int index = 0, String? imageName, String? bottomName}) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            SvgPicture.asset(
              imageName!,
              color: _currentIndex.value == index ? ColorRes.primaryColor : ColorRes.greyIcon,
              height: 20,
              width: 20,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 6),
            Text(
              bottomName!,
              style: TextStyle(
                  fontSize: 10,
                  color: _currentIndex.value == index ? ColorRes.primaryColor : ColorRes.greyText),
            ),
          ],
        ),
      ),
    );
  }
}
