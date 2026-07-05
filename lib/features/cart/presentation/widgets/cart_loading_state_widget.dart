import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/widget/card/product_item_card.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_item_data.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartLoadingStateWidget extends StatelessWidget {
  static const int _skeletonCount = 4;
  static final List<CartItemData> _skeletonItems = List.generate(
    _skeletonCount,
    (_) => CartItemData.skeleton(),
  );
  const CartLoadingStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        itemBuilder: (context, index) {
          final cartProduct = _skeletonItems[index];
          return ProductItemCard(
            topButtonWidget: SizedBox(),
            bottomButtonWidget: SizedBox(),
            price: cartProduct.price,
            productImageCoverUrl: cartProduct.cartProduct.imageCoverUrl,
            titleProduct: cartProduct.cartProduct.title,
            ratingsAverage: cartProduct.cartProduct.ratingsAverage,
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(height: AppHeight.h12),
        itemCount: _skeletonCount,
      ),
    );
  }
}
