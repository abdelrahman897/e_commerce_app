import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_item.dart';
import 'package:e_commerce_app/features/wishlist/domain/usecases/add_product_to_wishlist.dart';
import 'package:e_commerce_app/features/wishlist/domain/usecases/delete_product_from_wishlist.dart';
import 'package:e_commerce_app/features/wishlist/domain/usecases/get_wishlist.dart';
import 'package:equatable/equatable.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final GetWishlist _getWishlist;
  final DeleteProductFromWishlist _deleteProductFromWishlist;
  final AddProductToWishlist _addProductToWishlist;
  late List<ProductItem> wishlist;
  WishlistBloc({
    required GetWishlist getWishlist,
    required DeleteProductFromWishlist deleteProductFromWishlist,
    required AddProductToWishlist addProductToWishlist,
  }) : _getWishlist = getWishlist,
       _deleteProductFromWishlist = deleteProductFromWishlist,
       _addProductToWishlist = addProductToWishlist,
       super(const WishlistInitialState()) {
    on<GetWishlistEvent>(_onGetWishlistEvent, transformer: restartable());
    on<DeleteProductFromWishlistEvent>(
      _onDeleteProductFromWishlistEvent,
      transformer: sequential(),
    );
    on<AddProductToWishlistEvent>(
      _onAddProductToWishlistEvent,
      transformer: sequential(),
    );
  }
  FutureOr<void> _onGetWishlistEvent(
    GetWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    emit(const WishlistLoadingState());
    final result = await _getWishlist();
    result.fold(
      (failure) => emit(WishlistFailureState(failureMessage: failure.message)),
      (wishlist) {
        this.wishlist = wishlist;
        if (wishlist.isEmpty) {
          emit(const WishlistEmptySuccessState());
        } else {
          emit(GetWishlistSuccessState());
        }
      },
    );
  }

  FutureOr<void> _onDeleteProductFromWishlistEvent(
    DeleteProductFromWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    emit(const WishlistLoadingState());
    final result = await _deleteProductFromWishlist(
      params: event.wishlistParams,
    );
    result.fold(
      (failure) => emit(WishlistFailureState(failureMessage: failure.message)),
      (_) {
        emit(const DeleteProductFromWishlistSuccessState());
        add(GetWishlistEvent());
      },
    );
  }

  FutureOr<void> _onAddProductToWishlistEvent(
    AddProductToWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    emit(const WishlistLoadingState());
    final result = await _addProductToWishlist(params: event.wishlistParams);
    result.fold(
      (failure) => emit(WishlistFailureState(failureMessage: failure.message)),
      (_) {
        emit(const AddProductToWishlistSuccessState());
        add(GetWishlistEvent());
      },
    );
  }
}
