part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

final class GetCartEvent extends CartEvent {
  const GetCartEvent();
}

final class AddProductToCartEvent extends CartEvent {
  final CartParams cartParams;
  const AddProductToCartEvent({required this.cartParams});
  @override
  List<Object> get props => [cartParams];
}

final class DeleteProductFromCartEvent extends CartEvent {
  final CartParams cartParams;
  const DeleteProductFromCartEvent({required this.cartParams});
  @override
  List<Object> get props => [cartParams];
}

final class UpdateProductQuantityEvent extends CartEvent {
  final CartParams cartParams;
  const UpdateProductQuantityEvent({required this.cartParams});
  @override
  List<Object> get props => [cartParams];
}
