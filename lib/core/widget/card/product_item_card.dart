import 'package:e_commerce_app/core/extensions/padding_extension.dart';
import 'package:e_commerce_app/core/extensions/size_of_media_query.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/widget/button/custom_bounceable_button.dart';
import 'package:e_commerce_app/core/widget/card/sub_widget/product_item_image_card.dart';
import 'package:e_commerce_app/core/widget/card/sub_widget/product_item_info_card.dart';
import 'package:flutter/material.dart';

class ProductItemCard extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget topButtonWidget;
  final Widget bottomButtonWidget;
  final String productImageCoverUrl;
  final String titleProduct;
  final double ratingsAverage;
  final int price;
  const ProductItemCard({
    super.key,
    this.onTap,
    required this.topButtonWidget,
    required this.bottomButtonWidget,
    required this.price,
    required this.productImageCoverUrl,
    required this.titleProduct,
    required this.ratingsAverage,
  });

  @override
  Widget build(BuildContext context) {
    bool isPortrait = MediaQuery.orientationOf(context) == Orientation.portrait;
    return CustomBounceableButton(
      onTap: onTap,
      backgroundColor: context.customColorScheme.container,
      borderRadius: AppRadius.r16,
      borderColor: context.customColorScheme.button,
      height: isPortrait ? context.height * 0.15 : context.width * 0.22,
      customChildWidget: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: AppWidth.w8,
        children: [
          ProductItemImageCard(
            imageUrl: productImageCoverUrl,
            isPortrait: isPortrait,
          ),
          Expanded(
            child: ProductItemInfoCard(
              name: titleProduct,
              ratingsAverage: ratingsAverage,
              price: price,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              topButtonWidget,
              bottomButtonWidget,
            ],
          ).setHorizontalPaddingOnWidget(AppWidth.w8),
        ],
      ),
    );
  }
}
