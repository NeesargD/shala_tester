import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shala_yoga/base/utils/common_methods.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';
import 'package:shala_yoga/base/utils/constants/string_res.dart';
import 'package:shala_yoga/base/utils/constants/textstyle_constants.dart';
import 'package:shala_yoga/base/utils/navigation/navigation_route_constants.dart';
import 'package:shala_yoga/base/utils/navigation/navigation_utils.dart';
import 'package:shala_yoga/ui/widgets/bottom_sheet.dart';
import 'package:shala_yoga/ui/widgets/common_list_tile_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
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
                        SizedBox(width: 18)
                      ],
                    ),
                  )
                ],
              ),
            ),
            Stack(
              children: [
                Positioned(
                  left: 18,
               top: 90,
               child: Column(
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
                   SizedBox(height: 24),
                   Text("CONTINUE WATCHING",style: TextStyles.SB1875),

                 ],
               )
                ),
              ],
            ),
          ],
        ),
    );
  }
}
