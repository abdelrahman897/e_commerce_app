import 'package:e_commerce_app/core/network_handler/api_constants.dart';
import 'package:equatable/equatable.dart';

import 'cart_model.dart';

class CartResponse extends Equatable {
  final String status;
  final int numOfCartItems;
  final String? cartId;
  final CartModel cart;

  const CartResponse({
    required this.status,
    required this.numOfCartItems,
    this.cartId,
    required this.cart,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
    status: json[ApiKeys.status] as String,
    numOfCartItems: json[ApiKeys.numOfCartItems] as int,
    cartId: json[ApiKeys.cartId] as String?,
    cart: CartModel.fromJson(json[ApiKeys.data] as Map<String, dynamic>),
  );

  @override
  List<Object?> get props => [status, numOfCartItems, cartId, cart];
}
