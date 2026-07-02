import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/widget/button/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class BottomPriceBodySection extends StatelessWidget {
  final int totalPrice;
  final Widget customChildWidget;
  final VoidCallback? onTap;
  const BottomPriceBodySection({
    super.key,
    required this.totalPrice,
    required this.customChildWidget,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
           mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.appLocalization.totalPrice,
              style: context.textTheme.titleMedium,
            ),
            Text(
              "EGP $totalPrice",
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.customColorScheme.button,
              ),
            ),
          ],
        ),
        SizedBox(width: AppWidth.w20),
        Expanded(
          child: CustomElevatedButton(
            onTap: onTap,
            height: AppHeight.h36,
            customChildWidget: customChildWidget,
          ),
        ),
      ],
    );
  }
}
