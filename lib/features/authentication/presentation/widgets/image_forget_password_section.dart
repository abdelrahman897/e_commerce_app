import 'package:e_commerce_app/core/extensions/is_dark_mode.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class ImageForgetPasswordSection extends StatelessWidget {
  const ImageForgetPasswordSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final dpr = MediaQuery.devicePixelRatioOf(context);

    final asset = context.isDarkMode
        ? Assets.images.darkForgotPasswordBackgroundImg
        : Assets.images.lightForgotPasswordBackgroundImg;

    return asset.image(cacheWidth: (width * dpr).round());
  }
}
