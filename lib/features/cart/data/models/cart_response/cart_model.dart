import 'package:e_commerce_app/core/network_handler/api_constants.dart';
import 'package:equatable/equatable.dart';

import 'cart_item_model.dart';

class CartModel extends Equatable {
  final String? id;
  final String? cartOwnerId;
  final List<CartItemModel> items;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final int totalCartPrice;

  const CartModel({
    this.id,
    this.cartOwnerId,
    required this.items,
    this.createdAt,
    this.updatedAt,
    this.v,
    required this.totalCartPrice,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json[ApiKeys.id] as String?,
    cartOwnerId: json[ApiKeys.cartOwner] as String?,
    items: (json[ApiKeys.products] as List<dynamic>)
        .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    createdAt: json[ApiKeys.createdAt] == null
        ? null
        : DateTime.parse(json[ApiKeys.createdAt] as String),
    updatedAt: json[ApiKeys.updatedAt] == null
        ? null
        : DateTime.parse(json[ApiKeys.updatedAt] as String),
    v: json[ApiKeys.v] as int?,
    totalCartPrice: json[ApiKeys.totalCartPrice] as int,
  );

  @override
  List<Object?> get props {
    return [id, cartOwnerId, items, createdAt, updatedAt, v, totalCartPrice];
  }
}
