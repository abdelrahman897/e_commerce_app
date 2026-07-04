import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class SizeItem extends StatelessWidget {
  final VoidCallback? onTap;
  final int sizeNumber;
  final bool isSelected;
  const SizeItem({
    super.key,
    this.onTap,
    required this.sizeNumber,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        height: AppHeight.h36,
        width: AppWidth.w36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.green: context.customColorScheme.container,
          borderRadius: BorderRadius.circular(AppRadius.r100),
          border: Border.all(color: context.customColorScheme.button, width: 1),
        ),
        child: Text(
          "$sizeNumber",
          style: context.textTheme.titleMedium?.copyWith(
            color: isSelected
                ? context.customColorScheme.primary
                : context.customColorScheme.button,
          ),
        ),
      ),
    );
  }
}
