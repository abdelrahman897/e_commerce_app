import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/exceptions/cache_exception.dart';
import 'package:e_commerce_app/core/errors/exceptions/server_exception.dart';
import 'package:e_commerce_app/core/errors/failures/cache_failure.dart';
import 'package:e_commerce_app/core/errors/failures/failure.dart';
import 'package:e_commerce_app/core/errors/failures/server_failure.dart';
import 'package:e_commerce_app/core/errors/handlers/error_mapper.dart';

import 'package:e_commerce_app/core/network_handler/network_info.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/features/products/data/mappers/product_item_mapper.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_item.dart';
import 'package:e_commerce_app/features/wishlist/data/datasources/wishlist_local_data_source.dart';
import 'package:e_commerce_app/features/wishlist/data/datasources/wishlist_remote_data_source.dart';
import 'package:e_commerce_app/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:flutter/material.dart';

class WishlistRepositoryImp implements WishlistRepository {
  final WishlistRemoteDataSource _wishlistRemoteDataSource;
  final WishlistLocalDataSource _wishlistLocalDataSource;
  final NetworkInfo _networkInfo;
  const WishlistRepositoryImp({
    required WishlistRemoteDataSource wishlistRemoteDataSource,
    required NetworkInfo networkInfo,
    required WishlistLocalDataSource wishlistLocalDataSource,
  }) : _wishlistLocalDataSource = wishlistLocalDataSource,
       _wishlistRemoteDataSource = wishlistRemoteDataSource,
       _networkInfo = networkInfo;
  @override
  Future<Either<Failure, void>> addProduct({
    required WishlistParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        await _wishlistRemoteDataSource.addProduct(params: params);
        return const Right(null);
      } on ServerException catch (serverException) {
        return Left(ErrorMapper.mapServerExceptionToFailure(serverException));
      } catch (error, stackTrace) {
        debugPrint('addProduct failed: $error\n$stackTrace');
        return Left(CacheFailure.unknown());
      }
    } else {
      return const Left(ServerFailure.noInternet());
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct({
    required WishlistParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        await _wishlistRemoteDataSource.deleteProduct(params: params);
        unawaited(
          _wishlistLocalDataSource
              .deleteCachedProduct(params: params)
              .catchError((error, stackTrace) {
                debugPrint('deleteCachedProduct failed: $error');
              }),
        );
        return const Right(null);
      } on ServerException catch (serverException) {
        return Left(ErrorMapper.mapServerExceptionToFailure(serverException));
      } catch (error, stackTrace) {
        debugPrint('deleteProduct failed: $error\n$stackTrace');
        return const Left(CacheFailure.unknown());
      }
    } else {
      return const Left(ServerFailure.noInternet());
    }
  }

  @override
  Future<Either<Failure, List<ProductItem>>> getWishlist() async {
    if (await _networkInfo.isConnected) {
      try {
        final models = await _wishlistRemoteDataSource.getWishlist();
        final products = models.products
            .map((element) => element.toEntity)
            .toList();
        unawaited(
          _wishlistLocalDataSource
              .addCachedProduct(items: models.products)
              .catchError((error, stackTrace) {
                debugPrint('addCachedProduct failed: $error');
              }),
        );

        return Right(products);
      } on ServerException catch (serverException) {
        return Left(ErrorMapper.mapServerExceptionToFailure(serverException));
      } catch (error, stackTrace) {
        debugPrint('getWishlist failed: $error\n$stackTrace');
        return const Left(CacheFailure.unknown());
      }
    } else {
      try {
        final localProduct = await _wishlistLocalDataSource.getCachedWishlist();
        final products = localProduct
            .map((element) => element.toEntity)
            .toList();
        return Right(products);
      } on CacheException catch (error) {
        return Left(ErrorMapper.mapCacheExceptionToFailure(error));
      }
    }
  }
}
