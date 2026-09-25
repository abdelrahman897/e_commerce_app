import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

class CustomImageBuilder extends StatelessWidget {
  final Color? borderColor;
  final ImageProvider<Object> imageProvider;
  const CustomImageBuilder({
    super.key,
    this.borderColor,
    required this.imageProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor ?? ColorManager.transparent),
        image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
      ),
    );
  }
}
