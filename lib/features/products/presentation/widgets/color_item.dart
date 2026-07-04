import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class ColorItem extends StatelessWidget {
  final Color color;
  final bool isSelected;
  const ColorItem({super.key, required this.color, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: AppRadius.r20,
      backgroundColor: color,
      child: Icon(
        Icons.check,
        color: isSelected ? ColorManager.white : Colors.transparent,
      ),
    );
  }
}
