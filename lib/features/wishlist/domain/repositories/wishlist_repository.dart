import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failures.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_item.dart';

abstract interface class WishlistRepository {
  Future<Either<Failure, List<ProductItem>>> getWishlist();
  Future<Either<Failure, void>> deleteProduct({required WishlistParams params});
  Future<Either<Failure, void>> addProduct({required WishlistParams params});
}
