import 'package:e_commerce_app/core/extensions/size_of_media_query.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/widget/network_image/custom_cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductItemImageCard extends StatelessWidget {
  final bool isPortrait;
  final String imageUrl;
  const ProductItemImageCard({
    super.key,
    required this.isPortrait,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCachedNetworkImage(
      borderRadius: BorderRadius.circular(AppRadius.r16),
      imageHeight: isPortrait ? context.height * 0.142 : context.height * 0.23,
      imageWidth: isPortrait ? context.width * 0.29 : AppWidth.w165,
      imageItemPath: imageUrl,
    );
  }
}
