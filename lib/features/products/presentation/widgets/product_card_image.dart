import 'package:e_commerce_app/core/extensions/size_of_media_query.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/widget/button/custom_bounceable_button.dart';
import 'package:e_commerce_app/core/widget/button/toggle_favourite_button.dart';
import 'package:e_commerce_app/core/widget/network_image/custom_cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductCardImage extends StatelessWidget {
  final String imagePath;
  final VoidCallback? onTap;
  const ProductCardImage({super.key, required this.imagePath, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomCachedNetworkImage(
          imageItemPath: imagePath,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppRadius.r24),
            topRight: Radius.circular(AppRadius.r24),
          ),
        ),
        Positioned(
          top: context.height * 0.01,
          right: context.width * 0.02,
          child: CustomBounceableButton(
            height: context.height * 0.036,
            width: context.width * 0.08,
            customChildWidget: ToggleFavouriteButton(onTap: onTap),
          ),
        ),
      ],
    );
  }
}
