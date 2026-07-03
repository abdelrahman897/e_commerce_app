import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class HeaderAuthenticationSection extends StatelessWidget {
  final String title;
  final String subtitle;
  const HeaderAuthenticationSection({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppHeight.h6,
      children: [
        Text(title, style: context.textTheme.titleLarge),
        Text(
          subtitle,
          style: context.textTheme.titleSmall?.copyWith(
            color: ColorManager.grey,
          ),
        ),
      ],
    );
  }
}
