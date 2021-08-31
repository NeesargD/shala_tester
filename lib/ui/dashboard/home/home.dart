import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shala_yoga/base/utils/common_methods.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';
import 'package:shala_yoga/base/utils/constants/textstyle_constants.dart';
import 'package:shala_yoga/base/utils/navigation/navigation_route_constants.dart';
import 'package:shala_yoga/base/utils/navigation/navigation_utils.dart';
import 'package:shala_yoga/ui/classes_widgets/classes_card_widget.dart';
import 'package:shala_yoga/ui/classes_widgets/classes_recommended_with_circleAvatar.dart';
import 'package:shala_yoga/ui/classes_widgets/classes_grid_widget.dart';
import 'package:shala_yoga/ui/classes_widgets/classes_recommendation_widgets.dart';
import 'package:shala_yoga/ui/program_widgets/program_grid_recommended.dart';
import 'package:shala_yoga/ui/widgets/bottom_sheet.dart';
import 'package:shala_yoga/ui/widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(backgroundColor: ColorRes.appBarColor,
          body: SingleChildScrollView(
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
                            padding: EdgeInsetsDirectional.only(start: 18,end: 10,
                                top: 40),
                            child: Row(
                              children: [
                                  Opacity(opacity: 0.30,
                                  child: Text("Namaste", style: TextStyles.L30FF)),
                                Spacer(),
                                IconButton(onPressed: (){
                                  NavigationUtils.push(context, routeFilterScreen);
                                }, icon: Icon(Icons
                                    .search, color: ColorRes.white,)),
                                GestureDetector(
                                  child: Icon(Icons.more_vert ,color: ColorRes.white),
                                  onTap: (){
                                    showModalBottomSheet( shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topRight:  Radius
                                          .circular(10), topLeft: Radius.circular(10)),
                                    )
                                      ,context: context,
                                      builder: (context) => BottomSheetWidget(),);
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
                      margin: EdgeInsetsDirectional.only(start: 18, top: 90),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: ColorRes.appBarColor,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                width: screenWidth(context: context, percent: 0.90),
                                height: screenHeight(context: context, percent: 0.30),
                              ),
                              const SizedBox(height: 24),
                              Text("CONTINUE WATCHING",style: TextStyles.SB1875),
                              const SizedBox(height: 16),
                              ProgramGridRecommended(coverImage: 'assets/yoga.jpg',
                                languages: 'AR', title:
                               'xyz', style: 'Fitness', level: 'Advanced', countClass:5),
                             const SizedBox(height: 52),
                              Text("RECOMMENDED FOR YOU",style: TextStyles.SB1875),
                               const SizedBox(height: 14),
                               ClassesRecommended(coverImage: 'assets/shala_tumbn'
                                   'ail'
                                   '.jpg',
                                   title: 'ABC'
                                   , languages: "AR", style: "Fitness", image:
                                   "assets/yogacart.jpg", level: "Advance",
                                   duration: "0"),
                              const SizedBox(height: 37),
                              Text("Our recommendation for you",style: TextStyles
                                  .R1575),
                              Row(
                                children: [
                                  Text("STRETCHING",style: TextStyles
                                      .SB1878),
                                  Spacer(),
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(end: 15),
                                    child: TextButton.icon(onPressed: (){}, label: Text
                                      ("Change", style: TextStyles.R1275),
                                      style: ButtonStyle(
                                          minimumSize: MaterialStateProperty
                                              .all<Size>(Size(screenWidth
                                            (context: context, percent: 0.20), 28)),
                                          fixedSize: MaterialStateProperty
                                              .all<Size>(Size(screenWidth
                                            (context: context, percent: 0.20), 28)),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50.0),
                                          side: BorderSide(color:
                                          ColorRes.greyText,width: 1),
                                        ),)), icon: Icon(Icons.autorenew_rounded,
                                          size: 12, color: ColorRes.greyText),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                height: screenHeight(context: context, percent:
                                0.22),
                                width: screenWidth(context: context, percent: 0.40),
                                child: ClassesRecommendedWidget(
                                    title: "Easy Yoga For Complete Begin For Complete",
                                    language: "AR", style: "Fitness", coverImage:
                                "assets/yoga.jpg", level: "All Level",
                                    durations: "20"
                                ),
                              ),
                              const SizedBox(height: 35),
                              Text("POPULAR IN YOGA",style: TextStyles
                                  .SB1875),
                              const SizedBox(height: 22),
                              ClassesRecommended(coverImage: 'assets/yoga.jpg',
                                  title:"Easy Yoga For Complete Begin For Complete",
                                  languages: "AR",
                                  style: "Fitness", image:
                                  'assets/yogacart.jpg', level:"All Level",
                                  duration:
                                 "20"),
                              const SizedBox(height: 38),
                              Text("THIS WEEK SELECTION",style: TextStyles
                                  .SB1875),
                              const SizedBox(height: 15),
                              Container(
                                height: screenHeight(context: context, percent:
                                0.22),
                                width: screenWidth(context: context, percent: 0.40),
                                child: ClassesRecommendedWidget(
                                    title: "Easy Yoga For Complete Begin For Complete",
                                    language: "AR", style: "Fitness", coverImage:
                                "assets/yoga.jpg", level: "All Level",
                                    durations: "20"
                                ),
                                ),
                              const SizedBox(height: 45),
                              ClassesCardWidget(image: "assets/yoga.jpg",
                                  day: "TUESDAY", title: "Easy Yoga For "
                                      "Complete Begin For Complete", style:
                                  "Fitness",
                                  level: "All Level", duration: "30",
                                  language: "AR"),
                              const SizedBox(height: 45),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}
