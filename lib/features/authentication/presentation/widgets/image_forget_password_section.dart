import 'package:e_commerce_app/core/extensions/is_dark_mode.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class ImageForgetPasswordSection extends StatelessWidget {
  const ImageForgetPasswordSection({super.key});

  @override
  Widget build(BuildContext context) {
    return context.isDarkMode
        ? Assets.images.darkForgotPasswordBackgroundImg.image()
        : Assets.images.lightForgotPasswordBackgroundImg.image();
  }
}
