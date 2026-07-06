import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:flutter/material.dart';

class TextCheckoutItem extends StatelessWidget {
  final String title;
  final int value;
  const TextCheckoutItem({super.key, required this.title, required this.value});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: context.textTheme.titleMedium),
        Spacer(),
        Text('${AppConstants.egyptcurrency} $value', style: context.textTheme.titleMedium),
      ],
    );
  }
}
