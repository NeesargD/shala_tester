import 'package:flutter/material.dart';

class InstructorCircleAvatar extends StatelessWidget {

  final double radius;
  final double borderRadius;
  final String imageSource;


  InstructorCircleAvatar({this.radius = 25, this.borderRadius =25,required this
      .imageSource});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
          radius: radius,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.network(imageSource),
      ),
    );
  }
}
