import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/add_product_to_cart.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/delete_product_from_cart.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/get_cart.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/update_product_quantity.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCart _getCart;
  final DeleteProductFromCart _deleteProductFromCart;
  final UpdateProductQuantity _updateProductQuantity;
  final AddProductToCart _addProductToCart;
  late Cart cart;
  CartBloc({
    required GetCart getCart,
    required DeleteProductFromCart deleteProductFromCart,
    required UpdateProductQuantity updateProductQuantity,
    required AddProductToCart addProductToCart,
  }) : _deleteProductFromCart = deleteProductFromCart,
       _updateProductQuantity = updateProductQuantity,
       _addProductToCart = addProductToCart,
       _getCart = getCart,
       super(const CartInitialState()) {
    on<GetCartEvent>(_onGetCartEvent);
    on<DeleteProductFromCartEvent>(_onDeleteProductFromCartEvent);
    on<AddProductToCartEvent>(_onAddProductToCartEvent);
    on<UpdateProductQuantityEvent>(_onUpdateProductQuantityEvent);
  }
  FutureOr<void> _onGetCartEvent(
    GetCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoadingState());
    final result = await _getCart();
    result.fold(
      (failure) => emit(CartFailureState(failureMessage: failure.message)),
      (cart) {
        this.cart = cart;
        if (cart.items.isEmpty) {
          emit(CartEmptySuccessState());
        } else {
emit(
            GetCartSuccessState(),
        );
        }

      },
    );
  }

  FutureOr<void> _onDeleteProductFromCartEvent(
    DeleteProductFromCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(UpdateCartLoadingState());
    final result = await _deleteProductFromCart(params: event.cartParams);
    result.fold(
      (failure) => emit(CartFailureState(failureMessage: failure.message)),
      (cart) {
        this.cart = cart;
        if (cart.items.isEmpty) {
          emit(CartEmptySuccessState());
        } else {
          emit(DeleteProductFromCartSuccessState());
        }
      },
    );
  }

  FutureOr<void> _onAddProductToCartEvent(
    AddProductToCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoadingState());
    final result = await _addProductToCart(params: event.cartParams);
    result.fold(
      (failure) => emit(CartFailureState(failureMessage: failure.message)),
      (_) {
        emit(AddProductToCartSuccessState());
      },
    );
  }

  FutureOr<void> _onUpdateProductQuantityEvent(
    UpdateProductQuantityEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(UpdateCartLoadingState());
    final result = await _updateProductQuantity(params: event.cartParams);
    result.fold(
      (failure) => emit(CartFailureState(failureMessage: failure.message)),
      (cart) {
        this.cart = cart;
        if (cart.items.isEmpty) {
          emit(CartEmptySuccessState());
        } else {
          emit(UpdateProductQuantitySuccessState());
        }
      },
    );
  }
}
