import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/widget/button/toggle_favourite_button.dart';
import 'package:e_commerce_app/core/widget/network_image/custom_cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductCardImage extends StatelessWidget {
  final String imagePath;
  final VoidCallback? onTap;
  const ProductCardImage({super.key, required this.imagePath, this.onTap});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
       return  Stack(
          children: [
            CustomCachedNetworkImage(
              imageItemPath: imagePath,
               imageWidth: constraints.maxWidth,
              imageHeight: constraints.maxHeight,
               borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppRadius.r15),
                topRight: Radius.circular(AppRadius.r15),
              ),
            ),
            Positioned(
              top: AppHeight.h10,
              right: AppWidth.w6,
              child: ToggleFavouriteButton(onTap: onTap),
            ),
          ],
        );
      },
    );
  }
}
