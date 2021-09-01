import 'package:flutter/material.dart';
import 'package:shala_yoga/base/utils/constants/string_res.dart';
import 'package:shala_yoga/ui/classes_widgets/classes_card_widget.dart';
import 'package:shala_yoga/ui/program_widgets/program_grid_recommended.dart';
import '../../../base/extensions/scaffold_extension.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';
import 'package:shala_yoga/base/utils/constants/textstyle_constants.dart';

class ProgramsScreen extends StatefulWidget {
  @override
  _ProgramsScreenState createState() => _ProgramsScreenState();
}

class _ProgramsScreenState extends State<ProgramsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 80,
        centerTitle: true,
        elevation: 0,
        backgroundColor: ColorRes.appBarColor,
        title: Text(StringRes.programs, style: TextStyles.L2075),
      ),
      body: ListView.separated(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        shrinkWrap: true,
        itemCount: 5,
        separatorBuilder: (context, index) => SizedBox(
          height: 15,
        ),
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsetsDirectional.only(start: 20, end: 20),
            child: RecommendedProgramList(
                coverImage: 'assets/shala_tumbnail.jpg',
                languages: 'AR',
                title: 'xyz',
                style: 'Fitness',
                level: 'Advanced',
                width: 0.9,
                countClass: 5),
          );
        },
      ),
    );
  }
}
