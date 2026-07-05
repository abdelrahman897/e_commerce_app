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
  // bool get _hasValidCartData {
  //   final state = _cartBloc.state;
  //   return state is GetCartSuccessState ||
  //       state is UpdateProductQuantitySuccessState ||
  //       state is DeleteProductFromCartSuccessState;
  // }

  @override
  void initState() {
    super.initState();
    configLoading();
    _cartBloc = context.read<CartBloc>();
    _cartBloc.add(const GetCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<CartBloc, CartState>(
        listener: (context, cartState) {
          if(cartState is UpdateCartLoadingState){
EasyLoading.show(status: AppConstants.loading);
          }
          if (cartState is DeleteProductFromCartSuccessState ||
        cartState is UpdateProductQuantitySuccessState ||
        cartState is CartFailureState) {
      EasyLoading.dismiss();
    }
          if (cartState is DeleteProductFromCartSuccessState) {
            EasyLoading.dismiss();
              SnackBarService.showSuccessMessage(
                AppStrings.deletefromCartSuccessMessage,
              );
          }
        },
        builder: (context, cartState) {
          return Scaffold(
            appBar: ProductAppBar(title: context.appLocalization.cart),
            body: switch (cartState) {
              CartLoadingState() => const CartLoadingStateWidget(),
              GetCartSuccessState() ||
              DeleteProductFromCartSuccessState() ||
              UpdateCartLoadingState()||
              UpdateProductQuantitySuccessState() => ListView.separated(
                itemBuilder: (context, index) {
                  final cartProduct = _cartBloc.cart.items[index];
                  int itemQuantity = cartProduct.count;
                  return Padding(
                    padding:  EdgeInsets.symmetric(horizontal: AppWidth.w8 ,),
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
                        onDeleteTap: () => context.read<CartBloc>().add(
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
                          context.read<CartBloc>().add(
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
                          context.read<CartBloc>().add(
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
            bottomNavigationBar: _buildBottomNav(context, cartState),
            // Visibility(
            //       visible: _cartBloc.cart.items.isNotEmpty,
            //       child: BottomPriceBodySection(
            //         totalPrice: _cartBloc.cart.totalCartPrice,
            //         onTap: () => Navigator.pushNamed(
            //           context,
            //           Routes.checkoutRoute,
            //           arguments: _cartBloc.cart.totalCartPrice,
            //         ),
            //         customChildWidget: Row(
            //           spacing: AppWidth.w4,
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text(
            //               context.appLocalization.checkOut,
            //               style: context.textTheme.bodyMedium?.copyWith(
            //                 color: context.customColorScheme.primary,
            //               ),
            //             ),
            //             Icon(
            //               Icons.arrow_forward_ios_outlined,
            //               color: context.customColorScheme.icon,
            //             ),
            //           ],
            //         ),
            //       ),
            // ),
          );
        },
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
      padding:  EdgeInsets.symmetric(horizontal: AppWidth.w8, vertical:AppHeight.h12),
      child: BottomPriceBodySection(
        totalPrice: _cartBloc.cart.totalCartPrice,
        onTap: () => Navigator.pushNamed(
          context,
          Routes.checkoutRoute,
          arguments: _cartBloc.cart.totalCartPrice,
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
    );
  }
}

/*

if (cartState is! GetCartSuccessState &&
                    cartState is! UpdateProductQuantitySuccessState &&
                    cartState is! DeleteProductFromCartSuccessState)
                  return const SizedBox.shrink();
                if (_cartBloc.cart.items.isEmpty)
                  return const SizedBox.shrink();

*/
