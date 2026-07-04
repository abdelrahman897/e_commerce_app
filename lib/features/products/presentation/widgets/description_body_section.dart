import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class DescriptionBodySection extends StatelessWidget {
  final String productDescription;
  const DescriptionBodySection({super.key, required this.productDescription});

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      productDescription,
      style: context.textTheme.bodyLarge,
      trimExpandedText: context.appLocalization.readLess,
      trimCollapsedText: context.appLocalization.readMore,
      trimLines: 3,
      trimMode: TrimMode.Line,
      colorClickableText: context.customColorScheme.button,
    );
  }
}
