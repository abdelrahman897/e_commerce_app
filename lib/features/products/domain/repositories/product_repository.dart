import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failures.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/features/products/domain/entities/products.dart';

abstract interface class ProductRepository {
  Future<Either<Failure, Products>> getProducts({
    required ProductParams params,
  });
}
