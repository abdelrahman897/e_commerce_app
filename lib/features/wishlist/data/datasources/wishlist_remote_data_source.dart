import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/errors/handlers/dio_exception_handler.dart';
import 'package:e_commerce_app/core/errors/models/error_model.dart';
import 'package:e_commerce_app/core/network_handler/api_interface.dart';
import 'package:e_commerce_app/core/network_handler/end_point.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/features/wishlist/data/models/wishlist_response.dart';

abstract interface class WishlistRemoteDataSource {
  Future<WishlistResponse> getWishlist();
  Future<void> deleteProduct({required WishlistParams params});
  Future<void> addProduct({required WishlistParams params});
}

class WishlistRemoteDataSourceImp implements WishlistRemoteDataSource {
  final ApiInterface _apiInterface;
  const WishlistRemoteDataSourceImp({required ApiInterface apiInterface})
    : _apiInterface = apiInterface;

  @override
  Future<void> addProduct({required WishlistParams params}) async {
    try {
      await _apiInterface.post(EndPoint.wishlist, body: params.toJson());
    } on DioException catch (dioException) {
      throw DioExceptionHandler.handle(dioException);
    } catch (error) {
      throw ErrorModel.unknownError();
    }
  }

  @override
  Future<void> deleteProduct({required WishlistParams params}) async {
    try {
      await _apiInterface.delete('${EndPoint.wishlist}/${params.productId}');
    } on DioException catch (dioException) {
      throw DioExceptionHandler.handle(dioException);
    } catch (error) {
      throw ErrorModel.unknownError();
    }
  }

  @override
  Future<WishlistResponse> getWishlist() async {
    try {
      final response = await _apiInterface.get(EndPoint.wishlist);
      return WishlistResponse.fromJson(response.data);
    } on DioException catch (dioException) {
      throw DioExceptionHandler.handle(dioException);
    } catch (error) {
      throw ErrorModel.unknownError();
    }
  }
}
