import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failures.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart.dart';

abstract interface class CartRepository {
  Future<Either<Failure, Cart>> getCart();
  Future<Either<Failure, Cart>> deleteProduct({required CartParams params});
  Future<Either<Failure, Cart>> updateProduct({required CartParams params});
  Future<Either<Failure, void>> addProduct({required CartParams params});
}
