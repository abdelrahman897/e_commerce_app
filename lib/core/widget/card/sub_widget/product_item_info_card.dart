import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class ProductItemInfoCard extends StatelessWidget {
  final String name;
  final double ratingsAverage;
  final int price;
  const ProductItemInfoCard({
    super.key,
    required this.name,
    required this.ratingsAverage,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, maxLines: 1, style: context.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.bold,
        )),
        Row(
          spacing: AppWidth.w4,
          children: [
            Assets.icons.starIcn.svg(),
            Text("$ratingsAverage", style: context.textTheme.labelMedium),
          ],
        ),
        Text(
          'EGP $price',
          style: context.textTheme.labelMedium,
        ),
      ],
    );
  }
}
