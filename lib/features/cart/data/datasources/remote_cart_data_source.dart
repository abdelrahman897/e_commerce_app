import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/errors/handlers/dio_exception_handler.dart';
import 'package:e_commerce_app/core/errors/models/error_model.dart';
import 'package:e_commerce_app/core/network_handler/api_interface.dart';
import 'package:e_commerce_app/core/network_handler/end_point.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/features/cart/data/datasources/cart_data_source.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_response/cart_response.dart';

class RemoteCartDataSource implements CartDataSource {
  final ApiInterface _apiInterface;
  const RemoteCartDataSource({required ApiInterface apiInterface})
    : _apiInterface = apiInterface;
  @override
  Future<void> addProduct({required CartParams params}) async {
    try {
      await _apiInterface.post(EndPoint.cart, body: params.toJson());
    } on DioException catch (dioException) {
      throw DioExceptionHandler.handle(dioException);
    } catch (error) {
      throw ErrorModel.unknownError();
    }
  }

  @override
  Future<CartResponse> deleteProduct({required CartParams params}) async {
    try {
      final response = await _apiInterface.delete(
        '${EndPoint.cart}/${params.cartProductId}',
      );
      return CartResponse.fromJson(response.data);
    } on DioException catch (dioException) {
      throw DioExceptionHandler.handle(dioException);
    } catch (error) {
      throw ErrorModel.unknownError();
    }
  }

  @override
  Future<CartResponse> getCart() async {
    try {
      final response = await _apiInterface.get(EndPoint.cart);
      return CartResponse.fromJson(response.data);
    } on DioException catch (dioException) {
      throw DioExceptionHandler.handle(dioException);
    } catch (error) {
      throw ErrorModel.unknownError();
    }
  }

  @override
  Future<CartResponse> updateProduct({required CartParams params}) async {
    try {
      final response = await _apiInterface.put(
        '${EndPoint.cart}/${params.cartProductId}',
        body: params.toJson(),
      );
      return CartResponse.fromJson(response.data);
    } on DioException catch (dioException) {
      throw DioExceptionHandler.handle(dioException);
    } catch (error) {
      throw ErrorModel.unknownError();
    }
  }
}
