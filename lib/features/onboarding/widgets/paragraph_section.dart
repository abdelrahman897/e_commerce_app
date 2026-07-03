import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class ParagraphSection extends StatelessWidget {
  final String title;
  final String body;
  const ParagraphSection({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: context.textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppHeight.h8),
        Text(
          body,
          style: context.textTheme.bodyLarge,
          textAlign: TextAlign.center,
          maxLines: 4,
        ),
      ],
    );
  }
}
