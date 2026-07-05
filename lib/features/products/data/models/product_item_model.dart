import 'package:e_commerce_app/core/network_handler/api_constants.dart';
import 'package:e_commerce_app/features/home/data/models/brands_response/brand_model.dart';
import 'package:e_commerce_app/features/home/data/models/categories_response/category_model.dart';


import 'package:equatable/equatable.dart';
import 'package:hive_ce/hive.dart';
part 'product_item_model.g.dart';

@HiveType(typeId: 0)
class ProductItemModel extends Equatable {
  @HiveField(0)
  final int sold;
  @HiveField(1)
  final List<String> imagesUrl;
  @HiveField(2)
  final int ratingsQuantity;
  @HiveField(3)
  final String id;
  @HiveField(4)
  final String title;
  @HiveField(5)
  final String slug;
  @HiveField(6)
  final String description;
  @HiveField(7)
  final int quantity;
  @HiveField(8)
  final int price;
  @HiveField(9)
  final String imageCoverUrl;
  @HiveField(10)
  final CategoryModel category;
  @HiveField(11)
  final BrandModel brand;
  @HiveField(12)
  final double ratingsAverage;
  @HiveField(13)
  final DateTime createdAt;
  @HiveField(14)
  final DateTime updatedAt;
  @HiveField(15)
  final int? priceAfterDiscount;
  @HiveField(16)
  final List<dynamic>? availableColors;
  @HiveField(17)
  final int? v;

  const ProductItemModel({
    required this.sold,
    required this.imagesUrl,
    required this.ratingsQuantity,
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.quantity,
    required this.price,
    required this.imageCoverUrl,
    required this.category,
    required this.brand,
    required this.ratingsAverage,
    required this.createdAt,
    required this.updatedAt,
    this.priceAfterDiscount,
    this.availableColors,
    this.v,
  });

  factory ProductItemModel.fromJson(Map<String, dynamic> json) =>
      ProductItemModel(
        sold: json[ApiKeys.sold] as int,
        imagesUrl: (json[ApiKeys.images] as List).cast<String>(),
        ratingsQuantity: json[ApiKeys.ratingsQuantity] as int,
        id: json[ApiKeys.id] as String,
        title: json[ApiKeys.title] as String,
        slug: json[ApiKeys.slug] as String,
        description: json[ApiKeys.description] as String,
        quantity: json[ApiKeys.quantity] as int,
        price: json[ApiKeys.price] as int,
        imageCoverUrl: json[ApiKeys.imageCover] as String,
        category: CategoryModel.fromJson(
          json[ApiKeys.category] as Map<String, dynamic>,
        ),
        brand: BrandModel.fromJson(json[ApiKeys.brand] as Map<String, dynamic>),
        ratingsAverage: (json[ApiKeys.ratingsAverage] as num).toDouble(),
        createdAt: DateTime.parse(json[ApiKeys.createdAt] as String),
        updatedAt: DateTime.parse(json[ApiKeys.updatedAt] as String),
        priceAfterDiscount: json[ApiKeys.priceAfterDiscount] as int?,
        availableColors: json[ApiKeys.availableColors] == null
            ? null
            : json[ApiKeys.availableColors] as List<dynamic>,
        v: json[ApiKeys.v] as int?,
      );

  @override
  List<Object?> get props {
    return [
      sold,
      imagesUrl,
      ratingsQuantity,
      id,
      title,
      slug,
      description,
      quantity,
      price,
      imageCoverUrl,
      category,
      brand,
      ratingsAverage,
      createdAt,
      updatedAt,
      priceAfterDiscount,
      availableColors,
      v,
    ];
  }
}
