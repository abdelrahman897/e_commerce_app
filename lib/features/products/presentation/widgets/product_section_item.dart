import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class ProductSectionItem extends StatelessWidget {
  final String title;
  final Widget body;
  final int? price;

  const ProductSectionItem({
    super.key,
    required this.title,
    required this.body,
    this.price,
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
            Expanded(
              child: Text(
                title,
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.customColorScheme.button,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            if (price != null) ...[
              SizedBox(width: AppWidth.w8),
              Text(
                "EGP $price",
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.customColorScheme.button,
                ),
              ),
            ],
          ],
        ),
        body,
      ],
    );
  }
}
