import 'package:flutter/material.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';
import 'package:shala_yoga/base/utils/constants/textstyle_constants.dart';

class SupportModel extends StatelessWidget {
  final String question;
  final String answer;

  SupportModel({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        trailing: SizedBox.shrink(),
        title: Row(
          children: [
           CircleAvatar(
             radius: 12,
             backgroundColor: ColorRes.primaryColor,
             child: Text("?",style: TextStyle(color: ColorRes.white),),
           ),
            SizedBox(width: 16),
            Flexible(
              child: Text(
                question,
                style: TextStyles.R1875,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(start: 60, end: 20),
            child: Text(
                answer,
                style: TextStyles.R16AD),
          ),
        ],
      ),
    );
  }
}
