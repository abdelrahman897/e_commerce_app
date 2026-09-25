import 'package:e_commerce_app/core/extensions/padding_extension.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/widget/card/product_item_card.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WishlistLoadingStateWidget extends StatelessWidget {
  const WishlistLoadingStateWidget({super.key});

  static const int _skeletonItemCount = 6;

  static const List<String> _skeletonTitles = [
    'Product Title One',
    'A Longer Product Title Here',
    'Product Title',
  ];

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Skeletonizer(
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _skeletonItemCount,
          separatorBuilder: (context, index) => SizedBox(height: AppHeight.h8),
          itemBuilder: (context, index) {
            return ProductItemCard(
              topButtonWidget: const SizedBox.shrink(),
              bottomButtonWidget: const SizedBox.shrink(),
              price: 199,
              productImageCoverUrl: '',
              titleProduct: _skeletonTitles[index % _skeletonTitles.length],
              ratingsAverage: 4.5,
            );
          },
        ),
      ),
    ).setHorizontalAndVerticalPadding(
      context,
      AppWidth.w16,
      AppHeight.h16,
      enableMediaQuery: false,
    );
  }
}
