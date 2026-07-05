import 'package:e_commerce_app/features/cart/data/mappers/cart_item_mapper.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_response/cart_model.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart.dart';

extension CartMappers on CartModel {
  Cart get toEntity => Cart(
    items: items.map((item) => item.toEntity).toList(),
    totalCartPrice: totalCartPrice,
  );
}
