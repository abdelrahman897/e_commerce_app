import 'package:e_commerce_app/features/cart/data/mappers/cart_product_mapper.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_response/cart_item_model.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_item_data.dart';

extension CartItemMapper on CartItemModel {
  CartItemData get toEntity => CartItemData(
    count: count,
    cartProduct: cartProduct.toEntity,
    price: price,
  );
}
