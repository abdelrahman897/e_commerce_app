import 'package:e_commerce_app/core/extensions/padding_extension.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/widget/card/product_item_card.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WishlistLoadingStateWidget extends StatelessWidget {
  const WishlistLoadingStateWidget({super.key});

  static const int _skeletonItemCount = 8;

  static const List<_SkeletonProductData> _skeletonItems = [
    _SkeletonProductData(
      title: 'Product Title One',
      price: 199,
      rating: 4.5,
      category: 'Category',
    ),
    _SkeletonProductData(
      title: 'Product Title Two',
      price: 299,
      rating: 3.8,
      category: 'Category',
    ),
    _SkeletonProductData(
      title: 'Product Title Three',
      price: 149,
      rating: 4.2,
      category: 'Category',
    ),
    _SkeletonProductData(
      title: 'Product Title Four',
      price: 399,
      rating: 4.7,
      category: 'Category',
    ),
    _SkeletonProductData(
      title: 'Product Title Five',
      price: 249,
      rating: 3.5,
      category: 'Category',
    ),
    _SkeletonProductData(
      title: 'Product Title Six',
      price: 179,
      rating: 4.1,
      category: 'Category',
    ),
    _SkeletonProductData(
      title: 'Product Title Seven',
      price: 329,
      rating: 4.9,
      category: 'Category',
    ),
    _SkeletonProductData(
      title: 'Product Title Eight',
      price: 219,
      rating: 3.9,
      category: 'Category',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        itemCount: _skeletonItemCount,
        separatorBuilder: (context, index) => SizedBox(height: AppHeight.h8),
        itemBuilder: (context, index) {
          final item = _skeletonItems[index];
          return ProductItemCard(
            topButtonWidget: const SizedBox.shrink(),
            bottomButtonWidget: const SizedBox.shrink(),
            price: item.price,
            productImageCoverUrl: '',
            titleProduct: item.title,
            ratingsAverage: item.rating,
          );
        },
      ),
    ).setHorizontalAndVerticalPadding(
      context,
      AppWidth.w16,
      AppHeight.h16,
      enableMediaQuery: false,
    );
  }
}

class _SkeletonProductData {
  final String title;
  final int price;
  final double rating;
  final String category;

  const _SkeletonProductData({
    required this.title,
    required this.price,
    required this.rating,
    required this.category,
  });
}
