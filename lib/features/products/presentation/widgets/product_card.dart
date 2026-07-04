import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/widget/button/custom_bounceable_button.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_item.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final VoidCallback? onTap;
  final ProductItem product;
  const ProductCard({super.key, this.onTap, required this.product});

  @override
  Widget build(BuildContext context) {
    return CustomBounceableButton(
      height: AppHeight.h200,
      width: AppWidth.w170,
      borderRadius: AppRadius.r14,      
       borderColor: context.customColorScheme.button,
      backgroundColor: context.customColorScheme.container,
      onTap: onTap,
      customChildWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Expanded(
          //   flex: 45,
          //   child: ProductCardImage(
          //     imagePath: product.imageCoverUrl,
          //     onTap: () => context.read<WishlistBloc>().add(
          //       AddProductToWishlistEvent(
          //         wishlistParams: WishlistParams(productId: product.id),
          //       ),
          //     ),
          //   ),
          // ),
          // Expanded(
          //   flex: 55,
          //   child: ProductInfoSection(
          //     onPressed: () {
          //       context.read<CartBloc>().add(
          //         AddProductToCartEvent(
          //           cartParams: CartParams(cartProductId: product.id),
          //         ),
          //       );
          //     },
          //     title: product.title,
          //     description: product.description,
          //     price: product.priceAfterDiscount?.toDouble(),
          //     priceBeforeDiscount: product.price.toDouble(),
          //     rating: product.ratingsAverage,
          //   ),
          // ),
        ],
      ),
    );
  }
}
