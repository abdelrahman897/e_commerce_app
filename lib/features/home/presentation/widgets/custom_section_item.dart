import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/widget/button/custom_text_button.dart';
import 'package:flutter/material.dart';

class CustomSectionItem extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Widget body;
  final bool isTapped;
  const CustomSectionItem({
    super.key,
    required this.title,
    this.onPressed,
    required this.body,
    required this.isTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppHeight.h8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: context.textTheme.titleMedium),
            Visibility(
              visible: !(isTapped),
              child: CustomTextButton(
                title: context.appLocalization.viewAll,
                onPressed: onPressed,
                colorText: context.customColorScheme.button,
              ),
            ),
          ],
        ),
        body,
      ],
    );
  }
}
