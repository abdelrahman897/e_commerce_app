import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failure.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/features/home/domain/entities/brand/brand.dart';
import 'package:e_commerce_app/features/home/domain/entities/category/category.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, List<Category>>> getCategories({
    required CategoryParams params,
  });
  Future<Either<Failure, List<Category>>> getAllCategories();
  Future<Either<Failure, List<Brand>>> getBrands({required BrandParams params});
}
