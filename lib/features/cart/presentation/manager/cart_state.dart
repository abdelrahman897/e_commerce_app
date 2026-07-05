part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitialState extends CartState {
  const CartInitialState();
}

final class CartLoadingState extends CartState {
  const CartLoadingState();
}

final class CartEmptySuccessState extends CartState {
  const CartEmptySuccessState();
}

final class GetCartSuccessState extends CartState {
  const GetCartSuccessState();
}

final class AddProductToCartSuccessState extends CartState {
  const AddProductToCartSuccessState();
}

final class DeleteProductFromCartSuccessState extends CartState {
  const DeleteProductFromCartSuccessState();
}

final class UpdateProductQuantitySuccessState extends CartState {
  const UpdateProductQuantitySuccessState();
}
final class UpdateCartLoadingState extends CartState {
  const UpdateCartLoadingState();
}

final class CartFailureState extends CartState {
  final String failureMessage;
  const CartFailureState({required this.failureMessage});
  @override
  List<Object> get props => [failureMessage];
}
