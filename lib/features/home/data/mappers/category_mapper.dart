import 'package:e_commerce_app/features/home/data/models/categories_response/category_model.dart';
import 'package:e_commerce_app/features/home/domain/entities/category/category.dart';

extension CategoryMapper on CategoryModel {
  Category get toEntity =>
      Category(id: id, name: name, slug: slug, imageUrl: imageUrl);
}
