import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_item.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MostSellingLoadingWidget extends StatelessWidget {
  static const int _skeletonCount = 4;

  static final List<ProductItem> _skeletonItems = List.generate(
    _skeletonCount,
    (_) => ProductItem.skeleton(),
  );
  const MostSellingLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SizedBox(
        height: AppHeight.h320,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: _skeletonCount,
          separatorBuilder: (context, index) => SizedBox(width: AppWidth.w12),
          itemBuilder: (context, index) =>
              ProductCard(product: _skeletonItems[index]),
        ),
      ),
    );
  }
}
