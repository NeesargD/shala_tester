import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shala_yoga/base/utils/constants/image_constant.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit boxFit;

  const CustomNetworkImage({Key? key, required this.imageUrl, this.boxFit = BoxFit.fill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: boxFit,
      imageUrl: imageUrl,
      errorWidget: (context, url, error) {
        return SvgPicture.asset(
          ImageRes.icAppLogo,
        );
      },
    );
  }
}
