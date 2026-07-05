import 'package:e_commerce_app/core/network_handler/api_constants.dart';
import 'package:e_commerce_app/features/home/data/models/brands_response/brand_model.dart';
import 'package:e_commerce_app/features/home/data/models/categories_response/category_model.dart';

import 'package:equatable/equatable.dart';

class CartProductModel extends Equatable {
  final String id;
  final String title;
  final int? quantity;
  final String imageCoverUrl;
  final CategoryModel category;
  final BrandModel brand;
  final double ratingsAverage;

  const CartProductModel({
    required this.id,
    required this.title,
    this.quantity,
    required this.imageCoverUrl,
    required this.category,
    required this.brand,
    required this.ratingsAverage,
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json) =>
      CartProductModel(
        id: json[ApiKeys.id] as String,
        title: json[ApiKeys.title] as String,
        quantity: json[ApiKeys.quantity] as int?,
        imageCoverUrl: json[ApiKeys.imageCover] as String,
        category: CategoryModel.fromJson(
          json[ApiKeys.category] as Map<String, dynamic>,
        ),
        brand: BrandModel.fromJson(json[ApiKeys.brand] as Map<String, dynamic>),
        ratingsAverage: (json[ApiKeys.ratingsAverage] as num).toDouble(),
      );

  @override
  List<Object?> get props {
    return [
      id,
      title,
      quantity,
      imageCoverUrl,
      category,
      brand,
      ratingsAverage,
    ];
  }
}
