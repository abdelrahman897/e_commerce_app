import 'package:e_commerce_app/core/extensions/size_of_media_query.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/widget/button/custom_bounceable_button.dart';
import 'package:e_commerce_app/core/widget/button/toggle_favourite_button.dart';
import 'package:e_commerce_app/core/widget/network_image/custom_cached_network_image.dart';
import 'package:flutter/material.dart';

class CartProductImage extends StatelessWidget {
  final String imagePath;
  final VoidCallback? onTap;
  const CartProductImage({super.key, this.onTap, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppHeight.h250,
      child: Stack(
        children: [
          CustomCachedNetworkImage(
            imageItemPath: imagePath,
            borderRadius: BorderRadius.circular(AppRadius.r16),
            borderColor: context.customColorScheme.button,
            imageHeight: AppHeight.h250,
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
      ),
    );
  }
}
