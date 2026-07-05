import 'package:e_commerce_app/features/home/domain/entities/brand/brand.dart';
import 'package:e_commerce_app/features/home/domain/entities/category/category.dart';
import 'package:equatable/equatable.dart';

class CartProduct extends Equatable {
  final String id;
  final String title;
  final int? quantity;
  final String imageCoverUrl;
  final Category category;
  final Brand brand;
  final double ratingsAverage;

  const CartProduct({
    required this.id,
    required this.title,
    this.quantity,
    required this.imageCoverUrl,
    required this.category,
    required this.brand,
    required this.ratingsAverage,
  });

  factory CartProduct.skeleton() {
    return CartProduct(
      id: '1',
      title: 'product',
      imageCoverUrl: '',
      category: Category.skeleton(),
      brand: Brand.skeleton(),
      ratingsAverage: 4.5,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    quantity,
    imageCoverUrl,
    category,
    brand,
    ratingsAverage,
  ];
}
