import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final Color? colorText;
  const CustomTextButton({
    super.key,
    this.onPressed,
    required this.title,
    this.colorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(
          fontSize: FontSize.s16,
          fontWeight: FontWeight.bold,
          color: colorText ?? context.customColorScheme.text,
        ),
      ),
    );
  }
}
