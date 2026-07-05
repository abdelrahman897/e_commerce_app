import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/gen/assets.gen.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/services/loading_service.dart';
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
  int _quantity = 1;
  int selectedColor = -1;
  int selectedSize = -1;

  int _calculateTotalPrice(int quantity, int price) {
    return quantity * price;
  }

  @override
  void initState() {
    super.initState();
    configLoading();
  }

  @override
  Widget build(BuildContext context) {
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
              items: widget.product.imagesUrl,
              onTap: () => context.read<WishlistBloc>().add(
                AddProductToWishlistEvent(
                  wishlistParams: WishlistParams(productId: widget.product.id),
                ),
              ),
            ),
            SizedBox(height: AppHeight.h24),
            ProductSectionItem(
              title: widget.product.title,
              price: widget.product.priceAfterDiscount ?? widget.product.price,
              body: RatingBodySection(
                productRatingAverage: widget.product.ratingsAverage,
                productRatingsQuantity: widget.product.ratingsQuantity,
                numberOfProductSold: widget.product.sold,
                customChildWidget: ProductCounterButton(
                  initialValue: _quantity,
                  onIncrement: (int value) {
                    setState(() => _quantity = value);
                  },
                  onDecrement: (int value) {
                    setState(() => _quantity = value);
                  },
                ),
              ),
            ),
            SizedBox(height: AppHeight.h16),
            ProductSectionItem(
              title: context.appLocalization.description,
              body: DescriptionBodySection(
                productDescription: widget.product.description,
              ),
            ),
            SizedBox(height: AppHeight.h16),
            ProductSectionItem(
              title: context.appLocalization.size,
              body: SizeBodySection(
                sizes: const [39, 40, 41, 42, 43],
                onSelected: (value) {
                  selectedSize = value;
                },
              ),
            ),
            SizedBox(height: AppHeight.h20),
            ProductSectionItem(
              title: context.appLocalization.color,
              body: ColorBodySection(
                colors: const [
                  Colors.red,
                  Colors.blueAccent,
                  Colors.green,
                  Colors.yellow,
                ],
                onSelected: (value) {
                  selectedColor = value;
                },
              ),
            ),
            SizedBox(height: AppHeight.h48),
            BlocListener<CartBloc, CartState>(
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
              child: BottomPriceBodySection(
                totalPrice: _calculateTotalPrice(
                  _quantity,
                  widget.product.priceAfterDiscount ?? widget.product.price,
                ),
                onTap: () {
                  if (selectedSize == -1) {
                    SnackBarService.showErrorMessage('Please select a size');
                    return;
                  }
                  context.read<CartBloc>().add(
                    AddProductToCartEvent(
                      cartParams: CartParams(cartProductId: widget.product.id),
                    ),
                  );
                },
                customChildWidget: Row(
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
      ),
    );
  }
}
