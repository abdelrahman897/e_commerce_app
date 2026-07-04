import 'package:e_commerce_app/core/extensions/padding_extension.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/product_loading_item.dart';
import 'package:flutter/material.dart';

class ProductLoadingStateWidget extends StatelessWidget {
  const ProductLoadingStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 6,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppWidth.w8,
        mainAxisSpacing: AppHeight.h8,
        childAspectRatio: 7 / 9,
      ),
      itemBuilder: (context, index) {
        return ProductLoadingItem();
      },
    ).setHorizontalAndVerticalPadding(
      context,
      AppWidth.w16,
      AppHeight.h16,
      enableMediaQuery: false,
    );
  }
}
