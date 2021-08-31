import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';
import 'package:shala_yoga/base/utils/constants/textstyle_constants.dart';
import 'package:shala_yoga/ui/widgets/custom_button.dart';
import 'package:shala_yoga/ui/widgets/filter_selecter.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  RangeValues value = const RangeValues(0, 90);

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
          'Filter',
          style: TextStyles.L2075,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsetsDirectional.only(start: 19, end: 14, top: 17),
          color: ColorRes.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: ColorRes.greyIcon),
                    borderRadius: BorderRadius.circular(27),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.only(start: 25),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Start typing!",
                      hintStyle: TextStyles.R1575,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text("DURATION", style: TextStyles.SB1575),
              RangeSlider(
                min: 0,
                max: 90,
                values: value,
                inactiveColor: ColorRes.greyText,
                activeColor: ColorRes.primaryColor,
                onChanged: (values) {
                  setState(() {
                    value = values;
                  });
                },
              ),
              SizedBox(height: 42),
              Text("LANGUAGES", style: TextStyles.SB1575),
              SizedBox(height: 7),
              Row(
                children: [
                  FilterSelected(filterSelector: "Arabic"),
                  SizedBox(width: 9),
                  FilterSelected(filterSelector: "English"),
                ],
              ),
              SizedBox(height: 35),
              Text("LANGUAGES", style: TextStyles.SB1575),
              SizedBox(height: 7),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterSelected(filterSelector: "Beginner"),
                    SizedBox(width: 9),
                    FilterSelected(filterSelector: "Intermediate"),
                    SizedBox(width: 9),
                    FilterSelected(filterSelector: "Advanced"),
                  ],
                ),
              ),
              SizedBox(height: 35),
              Text("LEVEL", style: TextStyles.SB1575),
              SizedBox(height: 7),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterSelected(filterSelector: "Beginner"),
                    SizedBox(width: 9),
                    FilterSelected(filterSelector: "Meditation & Breathing"),
                    SizedBox(width: 9),
                    FilterSelected(filterSelector: "Advanced"),
                  ],
                ),
              ),
              SizedBox(height: 35),
              Text("STYLE", style: TextStyles.SB1575),
              SizedBox(height: 7),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterSelected(filterSelector: "Beginner"),
                    SizedBox(width: 9),
                    FilterSelected(filterSelector: "Meditation & Breathing"),
                    SizedBox(width: 9),
                    FilterSelected(filterSelector: "Advanced"),
                  ],
                ),
              ),
              SizedBox(height: 35),
              Text("FOCUS", style: TextStyles.SB1575),
              SizedBox(height: 7),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterSelected(filterSelector: "Beginner"),
                    SizedBox(width: 9),
                    FilterSelected(filterSelector: "Meditation & Breathing"),
                    SizedBox(width: 9),
                    FilterSelected(filterSelector: "Advanced"),
                  ],
                ),
              ),
              SizedBox(height: 35),
              Text("INSTRUCTORS", style: TextStyles.SB1575),
              SizedBox(height: 7),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterSelected(filterSelector: "Beginner"),
                    SizedBox(width: 9),
                    FilterSelected(filterSelector: "Meditation & Breathing"),
                    SizedBox(width: 9),
                    FilterSelected(filterSelector: "Beginner"),
                    SizedBox(width: 9),
                    FilterSelected(filterSelector: "Beginner"),
                    SizedBox(width: 9),
                    FilterSelected(filterSelector: "Beginner"),
                  ],
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child:  Padding(
          padding: EdgeInsetsDirectional.only(top: 30, bottom: 30, start: 25,
              end: 25),
          child: Row(
            children: [
              SizedBox(width: 5),
              Expanded(flex: 1,
                child: CustomButton(
                    onTap: () {},
                    buttonText: "RESET",
                    backgroundColor: ColorRes.white,
                    foregroundColor: ColorRes.white,
                    height: 52,
                    widthPercent: 0.4,
                    borderColor: ColorRes.primaryColor,
                    textStyle: TextStyles.R1778),
              ),
              SizedBox(width: 10),
              Expanded(flex: 1,
                child: CustomButton(
                    onTap: () {},
                    buttonText: "DONE",
                    backgroundColor: ColorRes.primaryColor,
                    foregroundColor: ColorRes.white,
                    height: 52,
                    widthPercent: 0.4,
                    borderColor: ColorRes.primaryColor,
                    textStyle: TextStyles.R17FF),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
