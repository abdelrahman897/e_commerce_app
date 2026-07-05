import 'package:e_commerce_app/core/network_handler/api_constants.dart';
import 'package:e_commerce_app/features/products/data/models/product_item_model.dart';
import 'package:equatable/equatable.dart';

class WishlistResponse extends Equatable {
  final String status;
  final int count;
  final List<ProductItemModel> products;

  const WishlistResponse({
    required this.status,
    required this.count,
    required this.products,
  });

  factory WishlistResponse.fromJson(Map<String, dynamic> json) {
    return WishlistResponse(
      status: json[ApiKeys.status] as String,
      count: json[ApiKeys.count] as int,
      products: (json[ApiKeys.data] as List<dynamic>)
          .map((e) => ProductItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [status, count, products];
}
