import 'package:e_commerce_app/core/extensions/app_localization.dart';
import 'package:e_commerce_app/core/extensions/theme_extension.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/resources/values_manager.dart';
import 'package:e_commerce_app/core/routes_manager/routes.dart';
import 'package:e_commerce_app/core/services/snackbar_service.dart';
import 'package:e_commerce_app/core/widget/app_bar/product_app_bar.dart';
import 'package:e_commerce_app/core/widget/bottom/bottom_price_body_section.dart';
import 'package:e_commerce_app/core/widget/button/product_counter_button.dart';
import 'package:e_commerce_app/core/widget/card/product_item_card.dart';
import 'package:e_commerce_app/core/widget/state/empty_state_widget.dart';
import 'package:e_commerce_app/core/widget/state/failure_state_widget.dart';
import 'package:e_commerce_app/features/cart/presentation/manager/cart_bloc.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/cart_loading_state_widget.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/delete_product_from_cart_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final CartBloc _cartBloc;

  @override
  void initState() {
    super.initState();
    _cartBloc = context.read<CartBloc>();
    _cartBloc.add(const GetCartEvent());
  }

  void _goToCheckout(BuildContext context) {
    final items = _cartBloc.cart.items;
    if (items.isEmpty) return;

    final totalQuantity = items.fold<int>(0, (sum, item) => sum + item.count);
    final summaryTitle = items.length == 1
        ? items.first.cartProduct.title
        : '${items.length} products'; 

    Navigator.pushNamed(
      context,
      Routes.checkoutRoute,
      arguments: {
        AppConstants.orderPrice: _cartBloc.cart.totalCartPrice,
        AppConstants.productName: summaryTitle,
        AppConstants.quantity: totalQuantity,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: ProductAppBar(title: context.appLocalization.cart),
        body: BlocConsumer<CartBloc, CartState>(
          listenWhen: (p, c) =>
              p is UpdateCartLoadingState || c is UpdateCartLoadingState,
          buildWhen: (p, c) => c is! UpdateCartLoadingState,
          listener: (context, cartState) {
            if (cartState is UpdateCartLoadingState) {
              EasyLoading.show(status: AppConstants.loading);
              return;
            }

            EasyLoading.dismiss();

            if (cartState is DeleteProductFromCartSuccessState) {
              SnackBarService.showSuccessMessage(
                AppStrings.deletefromCartSuccessMessage,
              );
            }
          },
          builder: (context, cartState) => switch (cartState) {
            CartLoadingState() => const CartLoadingStateWidget(),
            GetCartSuccessState() ||
            DeleteProductFromCartSuccessState() ||
            UpdateCartLoadingState() ||
            UpdateProductQuantitySuccessState() => ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: AppWidth.w16,
                vertical: AppHeight.h16,
              ),
              itemBuilder: (context, index) {
                final cartProduct = _cartBloc.cart.items[index];
                int itemQuantity = cartProduct.count;
                return Padding(
                  key: ValueKey(cartProduct.cartProduct.id),
                  padding: EdgeInsets.symmetric(horizontal: AppWidth.w8),
                  child: ProductItemCard(
                    onTap: () => Navigator.pushNamed(
                      context,
                      Routes.cartProductDetailsRoute,
                      arguments: {
                        AppConstants.cartItem: cartProduct,
                        AppConstants.productCount: itemQuantity,
                      },
                    ),
                    topButtonWidget: DeleteProductFromCartButton(
                      onDeleteTap: () => _cartBloc.add(
                        DeleteProductFromCartEvent(
                          cartParams: CartParams(
                            cartProductId: cartProduct.cartProduct.id,
                          ),
                        ),
                      ),
                    ),
                    bottomButtonWidget: ProductCounterButton(
                      initialValue: itemQuantity,
                      onIncrement: (int value) {
                        itemQuantity = value;
                        _cartBloc.add(
                          UpdateProductQuantityEvent(
                            cartParams: CartParams(
                              cartProductId: cartProduct.cartProduct.id,
                              quantity: value,
                            ),
                          ),
                        );
                      },
                      onDecrement: (int value) {
                        itemQuantity = value;
                        _cartBloc.add(
                          UpdateProductQuantityEvent(
                            cartParams: CartParams(
                              cartProductId: cartProduct.cartProduct.id,
                              quantity: value,
                            ),
                          ),
                        );
                      },
                    ),
                    productImageCoverUrl: cartProduct.cartProduct.imageCoverUrl,
                    ratingsAverage: cartProduct.cartProduct.ratingsAverage,
                    titleProduct: cartProduct.cartProduct.title,
                    price: cartProduct.price,
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  SizedBox(height: AppHeight.h12),
              itemCount: _cartBloc.cart.items.length,
            ),
            CartEmptySuccessState() => EmptyStateWidget(),
            CartFailureState() => FailureStateWidget(
              failureMessage: cartState.failureMessage,
            ),
            _ => const CartLoadingStateWidget(),
          },
        ),
        bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
          buildWhen: (p, c) =>
              c is GetCartSuccessState ||
              c is UpdateProductQuantitySuccessState ||
              c is DeleteProductFromCartSuccessState ||
              c is CartEmptySuccessState,
          builder: (context, state) => _buildBottomNav(context, state),
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context, CartState cartState) {
    final bool isValidState =
        cartState is GetCartSuccessState ||
        cartState is UpdateProductQuantitySuccessState ||
        cartState is DeleteProductFromCartSuccessState;

    if (!isValidState || _cartBloc.cart.items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppWidth.w8,
        vertical: AppHeight.h12,
      ),
      child: BottomPriceBodySection(
        totalPrice: _cartBloc.cart.totalCartPrice,
        onTap: () => _goToCheckout(context),
        customChildWidget: Row(
          spacing: AppWidth.w8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.appLocalization.checkOut,
              style: context.textTheme.bodyMedium?.copyWith(
                color: ColorManager.white,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: context.customColorScheme.icon,
            ),
          ],
        ),
      ),
    );
  }
}
