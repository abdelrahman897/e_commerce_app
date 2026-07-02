import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/network_handler/api_constants.dart';
import 'package:flutter/foundation.dart';

class ApiLogsInterceptors extends InterceptorsWrapper {
  void _debugLog(String Function() builder) {
    if (kDebugMode || kProfileMode) {
      log(builder(), name: ApiKeys.apiLogs);
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _debugLog(
      () => '${options.method} Request: ${options.baseUrl}${options.path}',
    );
    _debugLog(() => 'Headers: ${options.headers}');

    if (options.queryParameters.isNotEmpty) {
      _debugLog(() => 'Query Parameters: ${options.queryParameters}');
    }

    if (options.data != null) {
      _debugLog(() => 'Body: ${options.data}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _debugLog(
      () =>
          'API Logs Success Response: ${response.statusCode} ${response.requestOptions.path}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _debugLog(
      () =>
          'API Logs Error Response: ${err.response?.statusCode ?? 'No status'} ${err.requestOptions.path} - ${err.message}',
    );
    handler.reject(err);
  }
}
