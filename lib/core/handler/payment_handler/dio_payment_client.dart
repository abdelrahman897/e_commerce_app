import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/handler/payment_handler/payment_interface_handler.dart';
import 'package:e_commerce_app/core/network_handler/api_constants.dart';
import 'package:e_commerce_app/core/network_handler/api_logs_interceptors.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';

class DioPaymentClient implements PaymentInterfaceHandler {
  DioPaymentClient() {
    _initInterceptors();
  }

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: StripeApiConstants.baseUrl,
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      sendTimeout: ApiConstants.sendTimeout,
    ),
  );

  void _initInterceptors() {
    _dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String basicAuth = base64Encode(
            utf8.encode("${EnvKeys.secretKey}:"),
          );
          options.headers[ApiKeys.authorization] = "Basic $basicAuth";
          options.headers[ApiKeys.contentType] =
              "application/x-www-form-urlencoded";
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (error, handler) {
          return handler.next(error);
        },
      ),
      ApiLogsInterceptors(),
    ]);
  }

  @override
  Future<Response> delete(
    String endPoint, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
  }) async {
    return await _dio.delete(
      endPoint,
      data: body,
      queryParameters: queryParams,
    );
  }

  @override
  Future<Response> get(
    String endPoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    return await _dio.get(endPoint, queryParameters: queryParams);
  }

  @override
  Future<Response> post(
    String endPoint, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
  }) async {
    return await _dio.post(endPoint, queryParameters: queryParams, data: body);
  }

  @override
  Future<Response> postFormData(
    String endPoint, {
    Map<String, dynamic>? queryParams,
    body,
  }) async {
    return await _dio.post(endPoint, data: body, queryParameters: queryParams);
  }

  @override
  Future<Response> put(
    String endPoint, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
  }) async {
    return await _dio.put(endPoint, data: body, queryParameters: queryParams);
  }
}
