import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/exceptions/server_exception.dart';
import 'package:e_commerce_app/core/errors/failures/failure.dart';
import 'package:e_commerce_app/core/errors/failures/server_failure.dart';
import 'package:e_commerce_app/core/errors/handlers/error_mapper.dart';
import 'package:e_commerce_app/core/network_handler/network_info.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/features/home/data/datasources/home_data_source.dart';
import 'package:e_commerce_app/features/home/data/mappers/brand_mapper.dart';
import 'package:e_commerce_app/features/home/data/mappers/category_mapper.dart';

import 'package:e_commerce_app/features/home/domain/entities/brand/brand.dart';
import 'package:e_commerce_app/features/home/domain/entities/category/category.dart';
import 'package:e_commerce_app/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImp implements HomeRepository {
  final HomeDataSource _homeDataSource;
  final NetworkInfo _networkInfo;
  const HomeRepositoryImp({
    required HomeDataSource homeDataSource,
    required NetworkInfo networkInfo,
  }) : _networkInfo = networkInfo,
       _homeDataSource = homeDataSource;
  @override
  Future<Either<Failure, List<Brand>>> getBrands({
    required BrandParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final models = await _homeDataSource.getBrands(params: params);
        final brands = models.brands
            .map((element) => element.toEntity)
            .toList();
        return Right(brands);
      } on ServerException catch (serverException) {
        return Left(ErrorMapper.mapServerExceptionToFailure(serverException));
      }
    } else {
      return const Left(ServerFailure.noInternet());
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getCategories({
    required CategoryParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final models = await _homeDataSource.getCategories(params: params);
        final categories = models.categories
            .map((element) => element.toEntity)
            .toList();
        return Right(categories);
      } on ServerException catch (serverException) {
        return Left(ErrorMapper.mapServerExceptionToFailure(serverException));
      }
    } else {
      return const Left(ServerFailure.noInternet());
    }
  }
  
  @override
  Future<Either<Failure, List<Category>>> getAllCategories() async{
    if (await _networkInfo.isConnected) {
      try {
        final models = await _homeDataSource.getAllCategories();
        final categories = models.categories
            .map((element) => element.toEntity)
            .toList();
        return Right(categories);
      } on ServerException catch (serverException) {
        return Left(ErrorMapper.mapServerExceptionToFailure(serverException));
      }
    } else {
      return const Left(ServerFailure.noInternet());
    }
  }
}
