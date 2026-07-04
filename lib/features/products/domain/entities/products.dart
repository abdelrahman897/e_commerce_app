import 'package:e_commerce_app/features/products/domain/entities/metadata.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_item.dart';
import 'package:equatable/equatable.dart';

class Products extends Equatable {
  final Metadata metadata;
  final List<ProductItem> products;

  const Products({required this.metadata, required this.products});

  @override
  List<Object> get props => [metadata, products];
}
