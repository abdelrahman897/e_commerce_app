import 'package:e_commerce_app/features/products/data/mappers/metadata_mapper.dart';
import 'package:e_commerce_app/features/products/data/mappers/product_item_mapper.dart';
import 'package:e_commerce_app/features/products/data/models/products_model.dart';
import 'package:e_commerce_app/features/products/domain/entities/products.dart';

extension ProductsMappers on ProductsModel {
  Products get toEntity => Products(
    metadata: metadata.toEntity,
    products: products.map((element) => element.toEntity).toList(),
  );
}
