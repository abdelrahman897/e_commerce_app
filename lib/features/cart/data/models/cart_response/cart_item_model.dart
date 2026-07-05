import 'package:e_commerce_app/core/network_handler/api_constants.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_response/cart_product_model.dart';
import 'package:equatable/equatable.dart';

class CartItemModel extends Equatable {
  final int count;
  final String id;
  final CartProductModel cartProduct;
  final int price;

  const CartItemModel({
    required this.count,
    required this.id,
    required this.cartProduct,
    required this.price,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
    count: json[ApiKeys.count] as int,
    id: json[ApiKeys.id] as String,
    cartProduct: CartProductModel.fromJson(
      json[ApiKeys.product] as Map<String, dynamic>,
    ),
    price: json[ApiKeys.price] as int,
  );

  @override
  List<Object?> get props => [count, id, cartProduct, price];
}
