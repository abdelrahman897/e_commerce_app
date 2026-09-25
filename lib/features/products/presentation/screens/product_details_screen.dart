import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/padding_extension.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/services/snackbar_service.dart';
import 'package:e_commerce_app/core/widget/app_bar/product_app_bar.dart';
import 'package:e_commerce_app/core/widget/bottom/bottom_price_body_section.dart';
import 'package:e_commerce_app/core/widget/button/product_counter_button.dart';
import 'package:e_commerce_app/features/cart/presentation/manager/cart_bloc.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_item.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/color_body_section.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/description_body_section.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/product_section_item.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/product_slider.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/rating_body_section.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/size_body_section.dart';
import 'package:e_commerce_app/features/wishlist/presentation/manager/wishlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductItem product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ValueNotifier<int> _quantity = ValueNotifier<int>(1);
  int _selectedColorIndex = -1;
  int _selectedSizeIndex = -1;

  static const List<int> _sizes = <int>[39, 40, 41, 42, 43];
  static const List<Color> _colors = <Color>[
    Colors.red,
    Colors.blueAccent,
    Colors.green,
    Colors.yellow,
  ];

  int _calculateTotalPrice(int quantity, int price) {
    return quantity * price;
  }

  void _onAddToCart() {
    if (_selectedSizeIndex == -1) {
      SnackBarService.showErrorMessage('Please select a size');
      return;
    }
    if (_selectedColorIndex == -1) {
      SnackBarService.showErrorMessage('Please select a color');
      return;
    }
    context.read<CartBloc>().add(
      AddProductToCartEvent(
        cartParams: CartParams(cartProductId: widget.product.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      appBar: ProductAppBar(title: context.appLocalization.productDetails),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: AppWidth.w16,
          right: AppWidth.w16,
          bottom: AppHeight.h50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductSlider(
              items: product.imagesUrl,
              onTap: () => context.read<WishlistBloc>().add(
                AddProductToWishlistEvent(
                  wishlistParams: WishlistParams(productId: product.id),
                ),
              ),
            ),
            SizedBox(height: AppHeight.h24),
            ProductSectionItem(
              title: product.title,
              price: product.priceAfterDiscount ?? product.price,
              body: RatingBodySection(
                productRatingAverage: product.ratingsAverage,
                productRatingsQuantity: product.ratingsQuantity,
                numberOfProductSold: product.sold,
                customChildWidget: ProductCounterButton(
                  initialValue: 1,
                  onIncrement: (value) => _quantity.value = value,
                  onDecrement: (value) => _quantity.value = value,
                ),
              ),
            ),
            SizedBox(height: AppHeight.h16),
            ProductSectionItem(
              title: context.appLocalization.description,
              body: DescriptionBodySection(
                productDescription: product.description,
              ),
            ),
            SizedBox(height: AppHeight.h16),
            ProductSectionItem(
              title: context.appLocalization.size,
              body: SizeBodySection(
                sizes: _sizes,
                onSelected: (value) {
                  _selectedSizeIndex = value;
                },
              ),
            ),
            SizedBox(height: AppHeight.h20),
            ProductSectionItem(
              title: context.appLocalization.color,
              body: ColorBodySection(
                colors: _colors,
                onSelected: (value) {
                  _selectedColorIndex = value;
                },
              ),
            ),
            SizedBox(height: AppHeight.h48),
            BlocListener<CartBloc, CartState>(
              listenWhen: (previous, current) => previous != current,
              listener: (context, cartState) {
                switch (cartState) {
                  case CartLoadingState():
                    EasyLoading.show(status: AppConstants.loading);
                  case AddProductToCartSuccessState():
                    EasyLoading.dismiss();
                    SnackBarService.showSuccessMessage(
                      AppStrings.addToCartSuccessMessage,
                    );
                  case GetCartSuccessState():
                  case CartEmptySuccessState():
                    EasyLoading.dismiss();
                  case CartFailureState():
                    EasyLoading.dismiss();
                    SnackBarService.showErrorMessage(AppStrings.failureMessage);
                  default:
                    return;
                }
              },
              child: ValueListenableBuilder<int>(
                valueListenable: _quantity,
                builder: (context, quantity, addToCartLabel) =>
                    BottomPriceBodySection(
                      totalPrice: _calculateTotalPrice(
                        quantity,
                        product.priceAfterDiscount ?? product.price,
                      ),
                      onTap: _onAddToCart,
                      customChildWidget: addToCartLabel!,
                    ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.appLocalization.addToCart,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: ColorManager.white,
                      ),
                    ),
                    Assets.icons.cartIcn.svg(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ).setHorizontalAndVerticalPadding(
      context,
      AppWidth.w8,
      AppHeight.h12,
      enableMediaQuery: false,
    ),
    );
  }
}
