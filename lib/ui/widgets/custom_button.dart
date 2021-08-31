import 'package:flutter/material.dart';
import 'package:shala_yoga/base/utils/common_methods.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonText;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final TextStyle textStyle;
  final double widthPercent;
  final double height;

  const CustomButton(
      {Key? key,
      required this.onTap,
      required this.buttonText,
      required this.backgroundColor,
      required this.foregroundColor,
      required this.borderColor,
      required this.textStyle,
      this.widthPercent = 0.80,
      this.height = 40,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        buttonText,
        style: textStyle,
      ),
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(Size(screenWidth
          (context: context, percent: widthPercent), height)),
        fixedSize: MaterialStateProperty.all<Size>(Size(screenWidth(context:
        context, percent: widthPercent),height)),
        foregroundColor: MaterialStateProperty.all<Color>(foregroundColor),
        backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
        elevation: MaterialStateProperty.all<double>(0),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(horizontal: 30),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
            side: BorderSide(color: borderColor),
          ),
        ),
      ),
    );
  }
}
