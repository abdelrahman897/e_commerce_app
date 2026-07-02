import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/errors/exceptions/server_exception.dart';
import 'package:e_commerce_app/core/errors/models/error_model.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';

// Single Responsibility Principle

class DioExceptionHandler {
  DioExceptionHandler._();

  static Never handle(DioException exception) {
    final errorModel = _buildErrorModel(exception);

    switch (exception.type) {
      case DioExceptionType.connectionError:
        throw ConnectionErrorException(errorModel);

      case DioExceptionType.badCertificate:
        throw BadCertificateException(errorModel);

      case DioExceptionType.connectionTimeout:
        throw ConnectionTimeoutException(errorModel);

      case DioExceptionType.receiveTimeout:
        throw ReceiveTimeoutException(errorModel);

      case DioExceptionType.sendTimeout:
        throw SendTimeoutException(errorModel);

      case DioExceptionType.cancel:
        throw RequestCancelledException(
          ErrorModel(
            statusCode: 0,
            errorMessage: AppErrorMessages.requestCancelled,
          ),
        );

      case DioExceptionType.badResponse:
        _handleBadResponse(exception);

      case DioExceptionType.unknown:
        throw UnknownServerException(
          ErrorModel(
            statusCode: 0,
            errorMessage: exception.message ?? AppErrorMessages.unknown,
          ),
        );
    }
  }

  static ErrorModel _buildErrorModel(DioException exception) {
    try {
      final data = exception.response?.data;
      if (data is Map<String, dynamic>) {
        return ErrorModel.fromJson(data);
      }

      return ErrorModel(
        statusCode: exception.response?.statusCode ?? 0,
        errorMessage: exception.message ?? AppErrorMessages.unknown,
      );
    } catch (_) {
      return ErrorModel.unknownError();
    }
  }

  static Never _handleBadResponse(DioException exception) {
    final errorModel = _buildErrorModel(exception);

    switch (exception.response?.statusCode) {
      case 400:
        throw NetworkException(errorModel);
      case 401:
        throw UnauthorizedException(errorModel);
      case 403:
        throw ForbiddenException(errorModel);
      case 404:
        throw NotFoundException(errorModel);
      case 409:
        throw ConflictException(errorModel);
      case 504:
        throw GatewayTimeoutException(errorModel);
      default:
        throw NetworkException(
          ErrorModel(
            statusCode: exception.response?.statusCode ?? 0,
            errorMessage: AppErrorMessages.serverError,
          ),
        );
    }
  }
}
