import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shala_yoga/base/utils/constants/image_constant.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;

  const CustomNetworkImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.fill,
      imageUrl: imageUrl,
      errorWidget: (context, url, error) {
        return SvgPicture.asset(
          ImageRes.icAppLogo,
        );
      },
    );
  }
}
