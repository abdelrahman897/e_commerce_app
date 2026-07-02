import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class CustomBounceableButton extends StatelessWidget {
  final VoidCallback? onTap;
  final double? width;
  final double height;
  final bool isSelected;
  final double? borderRadius;
  final Color? borderColor;
  final Color? backgroundColor;
  final Widget customChildWidget;
  const CustomBounceableButton({
    super.key,
    this.onTap,
    this.width,
    required this.height,
    this.backgroundColor,
    required this.customChildWidget,
    this.isSelected = false,
    this.borderRadius,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? AppRadius.r8),
          border: Border.all(
            color: borderColor ?? ColorManager.transparent,
            width: borderColor != null ? 2 : 1,
          ),
          color: backgroundColor ?? context.customColorScheme.primary,
        ),
        child: customChildWidget,
      ),
    );
  }
}
