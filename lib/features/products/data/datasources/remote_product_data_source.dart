import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/errors/handlers/dio_exception_handler.dart';
import 'package:e_commerce_app/core/network_handler/api_interface.dart';
import 'package:e_commerce_app/core/network_handler/end_point.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/features/products/data/datasources/product_data_source.dart';
import 'package:e_commerce_app/features/products/data/models/products_model.dart';

class RemoteProductDataSource implements ProductDataSource {
  final ApiInterface _apiInterface;
  const RemoteProductDataSource({required ApiInterface apiInterface})
    : _apiInterface = apiInterface;
  @override
  Future<ProductsModel> getProducts({required ProductParams params}) async {
    try {
      final response = await _apiInterface.get(
        EndPoint.products,
        queryParams: params.soldParam != null
            ? params.soldToJson()
            : params.paginationToJson(),
      );
      return ProductsModel.fromJson(response.data);
    } on DioException catch (dioException) {
      throw DioExceptionHandler.handle(dioException);
    } 
  }
}
