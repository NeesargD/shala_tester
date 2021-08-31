import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';
import 'package:shala_yoga/base/utils/constants/textstyle_constants.dart';
import 'package:shala_yoga/ui/widgets/common_list_tile_widget.dart';
import 'package:shala_yoga/ui/widgets/custom_button.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text("My Account", style: TextStyles.L2075),
          backgroundColor: ColorRes.appBarColor,
        ),
        bottomSheet: Padding(
          padding: EdgeInsetsDirectional.only(start: 27,end: 27),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CommonListTileWidget(
                  titleText:"MY SUBSCRIPTION" , imagePath: ' ', onTap: (){},
                  itemSpace: 9),
              CommonListTileWidget(
                titleText:"RESET PASSWORD" , imagePath: ' ', onTap: (){},
                itemSpace: 9,),
              SizedBox(height: 15),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: 20, end: 20, top: 33),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Opacity(opacity: 0.50,
                    child: Text("Your Email",
                        style: TextStyles.R1675),
                  ),
                  TextField(
                    style: TextStyles.R1675,
                    decoration: InputDecoration(
                      focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: ColorRes.red)
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: ColorRes.primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 37),
                  Opacity( opacity: 0.50,
                    child: Text("Phone Number",
                        style: TextStyles.R1675),
                  ),
                  TextField(keyboardType: TextInputType.phone,
                    style: TextStyles.R1675,
                    decoration: InputDecoration(
                      focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: ColorRes.red)
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: ColorRes.primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 37),
                  Opacity(opacity: 0.50,
                    child: Text("Location",
                        style: TextStyles.R1675)
                  ),
                  TextField(
                    style: TextStyles.R1675,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: ColorRes.primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 37),
                  CustomButton(widthPercent: 1,onTap: (){},
                      buttonText: "SAVE CHANGES",
                      backgroundColor: ColorRes.primaryColor,
                      foregroundColor: Colors.transparent,
                      borderColor: Colors.transparent,
                      textStyle: TextStyles.SB18FF),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
