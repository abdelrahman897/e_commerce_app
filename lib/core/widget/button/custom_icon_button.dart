import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData iconData;
  final Color? outLineColor;
  final Color? iconColor;
  final double? iconSize;

  const CustomIconButton({
    super.key,
    this.onPressed,
    required this.iconData,
    this.outLineColor,
    this.iconColor,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      color: outLineColor ?? ColorManager.white,
      icon: Icon(iconData, color: iconColor ?? ColorManager.white , size: iconSize ?? AppRadius.r24,),
    );
  }
}
