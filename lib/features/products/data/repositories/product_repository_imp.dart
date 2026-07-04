import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/exceptions/server_exception.dart';
import 'package:e_commerce_app/core/errors/failures/failure.dart';
import 'package:e_commerce_app/core/errors/failures/server_failure.dart';
import 'package:e_commerce_app/core/errors/handlers/error_mapper.dart';
import 'package:e_commerce_app/core/network_handler/network_info.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/features/products/data/datasources/product_data_source.dart';
import 'package:e_commerce_app/features/products/data/mappers/products_mappers.dart';
import 'package:e_commerce_app/features/products/domain/entities/products.dart';

import 'package:e_commerce_app/features/products/domain/repositories/product_repository.dart';

class ProductRepositoryImp implements ProductRepository {
  final ProductDataSource _productDataSource;
  final NetworkInfo _networkInfo;
  const ProductRepositoryImp({
    required ProductDataSource productDataSource,
    required NetworkInfo networkInfo,
  }) : _productDataSource = productDataSource,
       _networkInfo = networkInfo;
  @override
  Future<Either<Failure, Products>> getProducts({
    required ProductParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final products = await _productDataSource.getProducts(params: params);
        return Right(products.toEntity);
      } on ServerException catch (serverException) {
        return Left(ErrorMapper.mapServerExceptionToFailure(serverException));
      }
    } else {
      return const Left(ServerFailure.noInternet());
    }
  }
}
