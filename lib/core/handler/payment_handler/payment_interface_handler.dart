import 'package:dio/dio.dart';

abstract interface class PaymentInterfaceHandler {
  Future<Response> get(String endPoint, {Map<String, dynamic>? queryParams});

  Future<Response> post(
    String endPoint, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
  });

  Future<Response> postFormData(
    String endPoint, {
    Map<String, dynamic>? queryParams,
    FormData? body,
  });

  Future<Response> put(
    String endPoint, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
  });

  Future<Response> delete(
    String endPoint, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
  });
}
