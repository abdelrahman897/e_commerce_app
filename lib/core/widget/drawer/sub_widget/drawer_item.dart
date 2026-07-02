import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String titleItem;
  final Widget icon;
  final Widget dropdownWidget;
  const DrawerItem({
    super.key,
    required this.titleItem,
    required this.icon,
    required this.dropdownWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppWidth.w8,
      children: [
        Row(
          spacing: AppWidth.w4,
          children: [
            icon,
            Text(
              titleItem,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.customColorScheme.button,
              ),
            ),
          ],
        ),
        dropdownWidget,
      ],
    );
  }
}
