import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/font_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/widget/button/custom_bounceable_button.dart';
import 'package:flutter/material.dart';

class SelectItemRow extends StatelessWidget {
  const SelectItemRow({
    super.key,
    required this.label,
    required this.isFirstSelected,
    required this.onTapFirst,
    required this.onTapSecond,
    required this.customFirstChild,
    required this.customSecondChild,
  });

  final String label;
  final bool isFirstSelected;
  final VoidCallback onTapFirst;
  final VoidCallback onTapSecond;
  final Widget customFirstChild;
  final Widget customSecondChild;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: context.customColorScheme.text,
            fontSize: FontSize.s18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        CustomBounceableButton(
          width: AppWidth.w83,
          height: AppHeight.h32,
          isSelected: isFirstSelected,
          onTap: onTapFirst,
          backgroundColor: isFirstSelected
              ? context.customColorScheme.button
              : context.customColorScheme.primary,
          customChildWidget: customFirstChild,
        ),
        SizedBox(width: AppWidth.w8),
        CustomBounceableButton(
          width: AppWidth.w83,
          height: AppHeight.h32,
          isSelected: !isFirstSelected,
          onTap: onTapSecond,
          backgroundColor: !isFirstSelected
              ? context.customColorScheme.button
              : context.customColorScheme.primary,
          customChildWidget: customSecondChild,
        ),
      ],
    );
  }
}
