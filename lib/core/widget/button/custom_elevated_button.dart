import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? borderSideColor;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Widget customChildWidget;

  const CustomElevatedButton({
    super.key,
    this.onTap,
    required this.customChildWidget,
    this.height,
    this.borderRadius,
    this.borderSideColor,
    this.backgroundColor,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width ?? double.infinity, height ?? 48),
        backgroundColor: backgroundColor ?? context.customColorScheme.button,
        overlayColor: ColorManager.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: borderSideColor ?? ColorManager.transparent,
          ),
          borderRadius: BorderRadiusGeometry.circular(
            borderRadius ?? AppRadius.r16,
          ),
        ),
      ),
      child: customChildWidget,
    );
  }
}
