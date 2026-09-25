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
    final dpr = MediaQuery.devicePixelRatioOf(context);
    final double displayWidth = imageWidth ?? AppWidth.w100;
    final double displayHeight = imageHeight ?? AppHeight.h100;
    final double decodeWidth = displayWidth.isFinite
      ? displayWidth
      : MediaQuery.sizeOf(context).width;
  final int cacheWidth = (decodeWidth * dpr).round();

    return ClipRRect(
      borderRadius:
          borderRadius ?? BorderRadius.circular(radius ?? AppRadius.r16),
      child: CachedNetworkImage(
        height: displayHeight ,
        width: displayWidth ,
        imageUrl: imageItemPath,
        memCacheWidth: cacheWidth,
        maxWidthDiskCache: 1080,
        placeholder: (_, _) => const Center(child: CircularProgressIndicator()),
        errorWidget: (_, _, _) => const NetworkImageError(),
        imageBuilder: (context, imageProvider) {
          return CustomImageBuilder(
            borderColor: borderColor,
            imageProvider: imageProvider,
          );
        },
      ),
    );
  }
}
