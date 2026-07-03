import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class CustomDividerLineSection extends StatelessWidget {
  final String text;
  const CustomDividerLineSection({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(flex: 1, child: Divider(endIndent: AppWidth.w16)),
        Text(text, style: context.textTheme.bodySmall),
        Expanded(flex: 1, child: Divider(indent: AppWidth.w16)),
      ],
    );
  }
}
