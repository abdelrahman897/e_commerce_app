import 'package:e_commerce_app/features/cart/data/models/cart_response/cart_product_model.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_product.dart';
import 'package:e_commerce_app/features/home/data/mappers/brand_mapper.dart';
import 'package:e_commerce_app/features/home/data/mappers/category_mapper.dart';

extension CartProductMapper on CartProductModel {
  CartProduct get toEntity => CartProduct(
    id: id,
    title: title,
    quantity: quantity,
    imageCoverUrl: imageCoverUrl,
    category: category.toEntity,
    brand: brand.toEntity,
    ratingsAverage: ratingsAverage,
  );
}
