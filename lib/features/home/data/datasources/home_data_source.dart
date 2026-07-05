import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/features/home/data/models/brands_response/brands_response.dart';
import 'package:e_commerce_app/features/home/data/models/categories_response/categories_response.dart';

abstract interface class HomeDataSource {
  Future<CategoriesResponse> getCategories({required CategoryParams params});
  Future<CategoriesResponse> getAllCategories();
  Future<BrandsResponse> getBrands({required BrandParams params});
}