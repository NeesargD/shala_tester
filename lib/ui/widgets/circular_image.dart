import 'package:flutter/material.dart';
import 'package:shala_yoga/ui/widgets/custom_network_image.dart';

class CircularImage extends StatelessWidget {
  final double imageRadius;
  final String imageUrl;

  const CircularImage({Key? key, this.imageRadius = 25, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(imageRadius),
        child: CustomNetworkImage(
          imageUrl: imageUrl,
        ),
      ),
      radius: imageRadius,
    );
  }
}
