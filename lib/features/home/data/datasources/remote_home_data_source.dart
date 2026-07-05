import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/errors/handlers/dio_exception_handler.dart';
import 'package:e_commerce_app/core/errors/models/error_model.dart';
import 'package:e_commerce_app/core/network_handler/api_interface.dart';
import 'package:e_commerce_app/core/network_handler/end_point.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/features/home/data/datasources/home_data_source.dart';

import 'package:e_commerce_app/features/home/data/models/brands_response/brands_response.dart';
import 'package:e_commerce_app/features/home/data/models/categories_response/categories_response.dart';

class RemoteHomeDataSource implements HomeDataSource {
  final ApiInterface _apiInterface;
  const RemoteHomeDataSource({required ApiInterface apiInterface})
    : _apiInterface = apiInterface;
  @override
  Future<BrandsResponse> getBrands({required BrandParams params}) async {
    try {
      final response = await _apiInterface.get(
        EndPoint.brands,
        queryParams: params.toJson(),
      );
      return BrandsResponse.fromJson(response.data);
    } on DioException catch (dioException) {
      throw DioExceptionHandler.handle(dioException);
    } catch (error) {
      throw ErrorModel.unknownError();
    }
  }

  @override
  Future<CategoriesResponse> getCategories({
    required CategoryParams params,
  }) async {
    try {
      final response = await _apiInterface.get(
        EndPoint.categories,
        queryParams: params.toJson(),
      );
      return CategoriesResponse.fromJson(response.data);
    } on DioException catch (dioException) {
      throw DioExceptionHandler.handle(dioException);
    } catch (error) {
      throw ErrorModel.unknownError();
    }
  }

  @override
  Future<CategoriesResponse> getAllCategories() async {
    try {
      final response = await _apiInterface.get(EndPoint.categories);
      return CategoriesResponse.fromJson(response.data);
    } on DioException catch (dioException) {
      throw DioExceptionHandler.handle(dioException);
    } catch (error) {
      throw ErrorModel.unknownError();
    }
  }
}
