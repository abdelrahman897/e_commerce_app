import 'package:e_commerce_app/core/extensions/padding_extension.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/routes_manager/routes.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_item.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ProductSuccessStateWidget extends StatelessWidget {
  final List<ProductItem> products;
  final bool isLoadingMore;

  const ProductSuccessStateWidget({
    super.key,
    required this.products,
    required this.isLoadingMore,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(child: Text('No products found'));
    }
    return GridView.builder(
      itemCount: products.length + (isLoadingMore ? 1 : 0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppWidth.w8,
        mainAxisSpacing: AppHeight.h8,
        childAspectRatio: 7 / 9,
      ),
      itemBuilder: (context, index) {
        if (index == products.length) {
          return const Center(child: CircularProgressIndicator());
        }
        final product = products[index];
        return ProductCard(
          product: product,
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.productDetailsRoute,
              arguments: product,
            );
          },
        );
      },
    ).setHorizontalAndVerticalPadding(
      context,
      AppWidth.w16,
      AppHeight.h16,
      enableMediaQuery: false,
    );
  }
}
