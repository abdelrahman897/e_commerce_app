import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/routes_manager/routes.dart';
import 'package:e_commerce_app/core/widget/state/loading_more_state_widget.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_item.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';

class MostSellingBodySection extends StatelessWidget {
  final List<ProductItem> products;
  final bool isMaxPage;
  final bool isLoadingMore;
  const MostSellingBodySection({
    super.key,
    required this.products,
    required this.isMaxPage,
    required this.isLoadingMore,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppHeight.h320,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index >= products.length) {
            return const LoadingMoreStateWidget();
          }
          final product = products[index];
          return Padding(
            padding:  EdgeInsets.only(bottom: AppHeight.h8),
            child: ProductCard(
              product: product,
              onTap: () => Navigator.pushNamed(
                context,
                Routes.productDetailsRoute,
                arguments: product,
              ),
            ),
          );
        },
        itemCount: isLoadingMore ? products.length + 1 : products.length,
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(width: AppWidth.w12),
      ),
    );
  }
}
