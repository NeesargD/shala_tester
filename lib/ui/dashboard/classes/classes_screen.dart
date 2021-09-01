import 'package:flutter/material.dart';
import 'package:shala_yoga/base/utils/constants/string_res.dart';
import 'package:shala_yoga/ui/classes_widgets/classes_card_widget.dart';
import '../../../base/extensions/scaffold_extension.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';
import 'package:shala_yoga/base/utils/constants/textstyle_constants.dart';

class ClassesScreen extends StatefulWidget {
  @override
  _ClassesScreenState createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 80,
        centerTitle: true,
        elevation: 0,
        backgroundColor: ColorRes.appBarColor,
        title: Text(StringRes.classes, style: TextStyles.L2075),
      ),
      body: ListView.separated(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        shrinkWrap: true,
        itemCount: 5,
        separatorBuilder: (context, index) => SizedBox(
          height: 10,
        ),
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsetsDirectional.only(start: 20, end: 20),
            child: ClassesCardWidget(
                image: "assets/shala_tumbnail.jpg",
                day: "TUESDAY",
                title: "Easy Yoga For "
                    "Complete Begin For Complete",
                style: "Fitness",
                isLock: index == 1 ? true : false,
                level: "All Level",
                duration: "30",
                language: "AR"),
          );
        },
      ),
    );
  }
}
