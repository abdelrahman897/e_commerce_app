import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/widget/button/custom_bounceable_button.dart';
import 'package:flutter/material.dart';

class AddProductToCartButton extends StatelessWidget {
  final VoidCallback? onAddProductTap;
  const AddProductToCartButton({super.key, this.onAddProductTap});

  @override
  Widget build(BuildContext context) {
    return CustomBounceableButton(
      height: AppHeight.h36,
      width: AppWidth.w100,
      backgroundColor: context.customColorScheme.button,
      borderRadius: AppRadius.r18,
      onTap: onAddProductTap,
      customChildWidget: Center(
        child: Text(
          context.appLocalization.addToCart,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.customColorScheme.primary,
          ),
        ),
      ),
    );
  }
}
