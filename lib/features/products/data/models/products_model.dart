import 'package:e_commerce_app/core/models/metadata_model.dart';
import 'package:e_commerce_app/core/network_handler/api_constants.dart';
import 'package:equatable/equatable.dart';

import 'product_item_model.dart';

class ProductsModel extends Equatable {
  final int results;
  final MetadataModel metadata;
  final List<ProductItemModel> products;

  const ProductsModel({
    required this.results,
    required this.metadata,
    required this.products,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      results: json[ApiKeys.results] as int,
      metadata: MetadataModel.fromJson(
        json[ApiKeys.metadata] as Map<String, dynamic>,
      ),
      products: (json[ApiKeys.data] as List<dynamic>)
          .map((e) => ProductItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [results, metadata, products];
}
