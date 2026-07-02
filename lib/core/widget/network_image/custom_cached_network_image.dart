import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/widget/network_image/custom_image_builder.dart';
import 'package:e_commerce_app/core/widget/network_image/network_image_error.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageItemPath;
  final double? imageHeight;
  final double? imageWidth;
  final BorderRadiusGeometry? borderRadius;
  final double? radius;
  final Color? borderColor;

  const CustomCachedNetworkImage({
    super.key,
    required this.imageItemPath,
    this.imageHeight,
    this.imageWidth,
    this.radius,
    this.borderColor,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius:
            borderRadius ?? BorderRadius.circular(radius ?? AppRadius.r16),
        child: CachedNetworkImage(
          height: imageHeight ?? AppHeight.h100,
          width: imageWidth ?? AppWidth.w100,
          fit: BoxFit.cover,
          imageUrl: imageItemPath,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, imageError) => const NetworkImageError(),
          imageBuilder: (context, imageProvider) {
            return CustomImageBuilder(
              borderColor: borderColor,
              borderRadius: radius ?? AppRadius.r16,
              imageProvider: imageProvider,
            );
          },
        ),
      ),
    );
  }
}
