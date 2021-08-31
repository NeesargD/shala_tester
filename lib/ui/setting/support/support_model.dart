import 'package:flutter/material.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';
import 'package:shala_yoga/base/utils/constants/textstyle_constants.dart';

class SupportModel extends StatelessWidget {

  final String supportQuestion;


  SupportModel({required this.supportQuestion});

  @override
  Widget build(BuildContext context) {
    return  Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        trailing: SizedBox.shrink(),
        title: Row(
          children: [
            Icon(Icons.circle, color: ColorRes.primaryColor),
            SizedBox(width: 16),
            Flexible(
              child: GestureDetector(
                child: Text(supportQuestion, style:
                TextStyles.R1875,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,),
                onTap: (){
                },
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(start: 60, end: 20),
            child: Text(
                "Dear Yoga Creative, our FAQ section can hep you find the "
                    "answer you want faster",
                style: TextStyles.R16AD),
          ),
        ],
      ),
    );
  }
}
