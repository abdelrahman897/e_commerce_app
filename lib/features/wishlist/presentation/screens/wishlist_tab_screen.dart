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
    _wishlistBloc = context.read<WishlistBloc>();
    _wishlistBloc.add(GetWishlistEvent());
  }

  static bool _shouldRebuild(WishlistState previous, WishlistState current) {
    if (current is AddProductToWishlistSuccessState) return false;
    if (current is DeleteProductFromWishlistSuccessState) return false;
    if (current is WishlistFailureState) return false;
    return true;
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
        listenWhen: (previous, current) => current is WishlistFailureState,
        listener: (context, wishlistState) {
          if (wishlistState is AddProductToCartSuccessState) {
            SnackBarService.showSuccessMessage(AppStrings.addToCart);
          }
        },
        buildWhen: _shouldRebuild,
        builder: (context, wishlistState) {
          switch (wishlistState) {
            case WishlistLoadingState():
              return WishlistLoadingStateWidget();
            case WishlistEmptySuccessState():
              return EmptyStateWidget();
            case GetWishlistSuccessState():
              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: AppWidth.w8),
                itemBuilder: (context, index) {
                  final wishlistProduct = _wishlistBloc.wishlist[index];
                  return ProductItemCard(
                    key: ValueKey(wishlistProduct.id),
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
