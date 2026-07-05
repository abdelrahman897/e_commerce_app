import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/exceptions/server_exception.dart';
import 'package:e_commerce_app/core/errors/failures/failure.dart';
import 'package:e_commerce_app/core/errors/failures/server_failure.dart';
import 'package:e_commerce_app/core/errors/handlers/error_mapper.dart';
import 'package:e_commerce_app/core/network_handler/network_info.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/features/cart/data/datasources/cart_data_source.dart';
import 'package:e_commerce_app/features/cart/data/mappers/cart_mappers.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart.dart';
import 'package:e_commerce_app/features/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImp implements CartRepository {
  final CartDataSource _cartDataSource;
  final NetworkInfo _networkInfo;
  const CartRepositoryImp({
    required CartDataSource cartDataSource,
    required NetworkInfo networkInfo,
  }) : _cartDataSource = cartDataSource,
       _networkInfo = networkInfo;
  @override
  Future<Either<Failure, void>> addProduct({required CartParams params}) async {
    if (await _networkInfo.isConnected) {
      try {
        await _cartDataSource.addProduct(params: params);
        return Right(null);
      } on ServerException catch (serverException) {
        return Left(ErrorMapper.mapServerExceptionToFailure(serverException));
      }
    } else {
      return const Left(ServerFailure.noInternet());
    }
  }

  @override
  Future<Either<Failure, Cart>> deleteProduct({
    required CartParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final model = await _cartDataSource.deleteProduct(params: params);
        return Right(model.cart.toEntity);
      } on ServerException catch (serverException) {
        return Left(ErrorMapper.mapServerExceptionToFailure(serverException));
      }
    } else {
      return const Left(ServerFailure.noInternet());
    }
  }

  @override
  Future<Either<Failure, Cart>> getCart() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _cartDataSource.getCart();
        return Right(response.cart.toEntity);
      } on ServerException catch (serverException) {
        return Left(ErrorMapper.mapServerExceptionToFailure(serverException));
      }
    } else {
      return const Left(ServerFailure.noInternet());
    }
  }

  @override
  Future<Either<Failure, Cart>> updateProduct({
    required CartParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _cartDataSource.updateProduct(params: params);
        return Right(response.cart.toEntity);
      } on ServerException catch (serverException) {
        return Left(ErrorMapper.mapServerExceptionToFailure(serverException));
      }
    } else {
      return const Left(ServerFailure.noInternet());
    }
  }
}
