import 'package:e_commerce_app/features/home/domain/entities/category/category.dart';
import 'package:equatable/equatable.dart';

class ProductItem extends Equatable {
  final int sold;
  final List<String> imagesUrl;
  final int ratingsQuantity;
  final String id;
  final String title;
  final String description;
  final int quantity;
  final int price;
  final Category category;
  final String imageCoverUrl;
  final double ratingsAverage;
  final int? priceAfterDiscount;

  const ProductItem({
    required this.sold,
    required this.imagesUrl,
    required this.ratingsQuantity,
    required this.id,
    required this.title,
    required this.description,
    required this.quantity,
    required this.price,
    required this.imageCoverUrl,
    required this.ratingsAverage,
    this.priceAfterDiscount,
    required this.category,
  });

  factory ProductItem.skeleton() => const ProductItem(
    id: 'skeleton_id',
    title: 'Product Title Here',
    description: 'Product description goes here for skeleton',
    price: 999,
    priceAfterDiscount: 799,
    imageCoverUrl: '',
    imagesUrl: [],
    ratingsAverage: 4.5,
    ratingsQuantity: 100,
    quantity: 10,
    sold: 50,
    category: Category(id: '', name: '', slug: '', imageUrl: ''),
  );

  @override
  List<Object?> get props {
    return [
      sold,
      imagesUrl,
      ratingsQuantity,
      id,
      title,
      description,
      quantity,
      price,
      category,
      imageCoverUrl,
      ratingsAverage,
      priceAfterDiscount,
    ];
  }
}
