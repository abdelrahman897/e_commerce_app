import 'package:dio/dio.dart';

import 'package:e_commerce_app/core/errors/models/error_model.dart';

abstract final class TestExceptions {
  static DioException dioException({
    int statusCode = 500,
    String message = 'Server Error',
    String path = '',
  }) {
    return DioException(
      requestOptions: RequestOptions(path: path),
      response: Response(
        requestOptions: RequestOptions(path: path),
        statusCode: statusCode,
        data: {'message': message},
      ),
      type: DioExceptionType.badResponse,
    );
  }

  static ErrorModel errorModel({
    int statusCode = 500,
    String errorMessage = 'Server Error',
  }) {
    return ErrorModel(errorMessage: errorMessage, statusCode: statusCode);
  }
}