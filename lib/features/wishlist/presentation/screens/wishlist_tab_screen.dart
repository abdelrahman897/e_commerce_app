import 'package:e_commerce_app/core/di_core/app_di_core.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/services/snackbar_service.dart';
import 'package:e_commerce_app/core/widget/card/product_item_card.dart';
import 'package:e_commerce_app/core/widget/state/empty_state_widget.dart';
import 'package:e_commerce_app/core/widget/state/failure_state_widget.dart';
import 'package:e_commerce_app/features/cart/presentation/manager/cart_bloc.dart';

import 'package:e_commerce_app/features/wishlist/presentation/manager/wishlist_bloc.dart';
import 'package:e_commerce_app/features/wishlist/presentation/widgets/add_product_to_cart_button.dart';
import 'package:e_commerce_app/features/wishlist/presentation/widgets/delete_product_from_wishlist_button.dart';
import 'package:e_commerce_app/features/wishlist/presentation/widgets/wishlist_loading_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistTabScreen extends StatefulWidget {
  const WishlistTabScreen({super.key});

  @override
  State<WishlistTabScreen> createState() => _WishlistTabScreenState();
}

class _WishlistTabScreenState extends State<WishlistTabScreen> {
  late final WishlistBloc _wishlistBloc;
  @override
  void initState() {
    super.initState();
    _wishlistBloc = getIt<WishlistBloc>();
    _wishlistBloc.add(GetWishlistEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, cartState) {
        if (cartState is AddProductToCartSuccessState) {
          SnackBarService.showSuccessMessage(AppStrings.addToCart);
        }
      },
      child: BlocConsumer<WishlistBloc, WishlistState>(
        listener: (context, wishlistState) {
          if (wishlistState is AddProductToCartSuccessState) {
            SnackBarService.showSuccessMessage(AppStrings.addToCart);
          }
        },
        builder: (context, wishlistState) {
          switch (wishlistState) {
            case WishlistLoadingState():
              return WishlistLoadingStateWidget();
            case WishlistEmptySuccessState():
              return EmptyStateWidget();
            case GetWishlistSuccessState():
              
              return ListView.separated(
                itemBuilder: (context, index) {
                  final wishlistProduct = _wishlistBloc.wishlist[index];
                  return ProductItemCard(
                    topButtonWidget: DeleteProductFromWishlistButton(
                      onDeleteTap: () {
                        context.read<WishlistBloc>().add(
                          DeleteProductFromWishlistEvent(
                            wishlistParams: WishlistParams(
                              productId: wishlistProduct.id,
                            ),
                          ),
                        );
                      },
                    ),
                    bottomButtonWidget: AddProductToCartButton(
                      onAddProductTap: () {
                        context.read<CartBloc>().add(
                          AddProductToCartEvent(
                            cartParams: CartParams(
                              cartProductId: wishlistProduct.id,
                            ),
                          ),
                        );
                      },
                    ),
                    productImageCoverUrl: wishlistProduct.imageCoverUrl,
                    ratingsAverage: wishlistProduct.ratingsAverage,
                    titleProduct: wishlistProduct.title,
                    price: wishlistProduct.price,
                  );
                },
                separatorBuilder: (context, index) =>
                    SizedBox(height: AppHeight.h12),
                itemCount: _wishlistBloc.wishlist.length,
              );
            case WishlistFailureState():
              return FailureStateWidget(
                failureMessage: wishlistState.failureMessage,
              );
            default:
              return const WishlistLoadingStateWidget();
          }
        },
      ),
    );
  }
}
