import 'package:equatable/equatable.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_product.dart';

class CartItemData extends Equatable {
  final int count;
  final CartProduct cartProduct;
  final int price;

  const CartItemData({
    required this.count,
    required this.cartProduct,
    required this.price,
  });
  factory CartItemData.skeleton() {
    return CartItemData(
      count: 1,
      cartProduct: CartProduct.skeleton(),
      price: 4,
    );
  }

  @override
  List<Object> get props => [count, cartProduct, price];
}
