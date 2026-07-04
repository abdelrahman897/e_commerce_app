import 'package:e_commerce_app/features/products/data/models/product_item_model.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_item.dart';

extension ProductItemMapper on ProductItemModel {
  ProductItem get toEntity => ProductItem(
    sold: sold,
    imagesUrl: imagesUrl,
    ratingsQuantity: ratingsQuantity,
    id: id,
    title: title,
    description: description,
    quantity: quantity,
    price: price,
    imageCoverUrl: imageCoverUrl,
    ratingsAverage: ratingsAverage,
    priceAfterDiscount: priceAfterDiscount,
    // category: category.toEntity,
  );
}
