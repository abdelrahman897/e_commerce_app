import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/routes_manager/routes.dart';
import 'package:e_commerce_app/core/services/loading_service.dart';
import 'package:e_commerce_app/core/services/snackbar_service.dart';
import 'package:e_commerce_app/core/widget/app_bar/product_app_bar.dart';
import 'package:e_commerce_app/core/widget/bottom/bottom_price_body_section.dart';
import 'package:e_commerce_app/core/widget/button/product_counter_button.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_item_data.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/cart_product_image.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/color_body_section.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/product_section_item.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/rating_body_section.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/size_body_section.dart';
import 'package:e_commerce_app/features/wishlist/presentation/manager/wishlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CartProductDetailsScreen extends StatefulWidget {
  final CartItemData cartItem;
  final int productCount;
  const CartProductDetailsScreen({
    super.key,
    required this.cartItem,
    required this.productCount,
  });

  @override
  State<CartProductDetailsScreen> createState() =>
      _CartProductDetailsScreenState();
}

class _CartProductDetailsScreenState extends State<CartProductDetailsScreen> {
  late int _quantity;
  int selectedColor = -1;
  int selectedSize = -1;

  int _calculateTotalPrice(int quantity, int price) {
    return quantity * price;
  }

  @override
  void initState() {
    super.initState();
    configLoading();
    _quantity = widget.productCount;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<WishlistBloc, WishlistState>(
        listener: (context, wishlistState) {
          switch (wishlistState) {
            case WishlistLoadingState():
              EasyLoading.show(status: AppConstants.loading);
            case AddProductToWishlistSuccessState():
              EasyLoading.dismiss();
              SnackBarService.showSuccessMessage(
                AppStrings.whishlistAddedMessage,
              );
            case DeleteProductFromWishlistSuccessState():
              EasyLoading.dismiss();
              SnackBarService.showSuccessMessage(
                AppStrings.whishlistDeletedMessage,
              );
            case GetWishlistSuccessState():
              EasyLoading.dismiss();
            case WishlistEmptySuccessState():
              EasyLoading.dismiss();
            default:
              return;
          }
        },
        child: Scaffold(
          appBar: ProductAppBar(title: context.appLocalization.cartItemDetails),
          body: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: AppWidth.w16,
              right: AppWidth.w16,
              bottom: AppHeight.h50,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CartProductImage(
                  imagePath: widget.cartItem.cartProduct.imageCoverUrl,
                  onTap: () => context.read<WishlistBloc>().add(
                    AddProductToWishlistEvent(
                      wishlistParams: WishlistParams(
                        productId: widget.cartItem.cartProduct.id,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: AppHeight.h24),
                ProductSectionItem(
                  title: widget.cartItem.cartProduct.title,
                  price: widget.cartItem.price,
                  body: RatingBodySection(
                    productRatingAverage:
                        widget.cartItem.cartProduct.ratingsAverage,
                    productRatingsQuantity:
                        widget.cartItem.cartProduct.quantity ?? 0,
                    numberOfProductSold: widget.cartItem.price,
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
                BottomPriceBodySection(
                  onTap: () => Navigator.pushNamed(
                    context,
                    Routes.checkoutRoute,
                    arguments: _calculateTotalPrice(
                      _quantity,
                      widget.cartItem.price,
                    ),
                  ),
                  totalPrice: _calculateTotalPrice(
                    _quantity,
                    widget.cartItem.price,
                  ),
                  customChildWidget: Row(
                    spacing: AppWidth.w4,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.appLocalization.checkOut,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.customColorScheme.primary,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: context.customColorScheme.icon,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
