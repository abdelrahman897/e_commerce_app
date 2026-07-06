import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/errors/handlers/dio_exception_handler.dart';
import 'package:e_commerce_app/core/errors/models/error_model.dart';
import 'package:e_commerce_app/core/handler/payment_handler/payment_interface_handler.dart';
import 'package:e_commerce_app/core/network_handler/end_point.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/features/checkout/data/datasources/payment_data_source.dart';
import 'package:e_commerce_app/features/checkout/data/models/payment_model/payment_model.dart';

class PaymentRemoteDataSource implements PaymentDataSource {
  final PaymentInterfaceHandler _paymentInterfaceHandler;
  const PaymentRemoteDataSource({
    required PaymentInterfaceHandler paymentInterfaceHandler,
  }) : _paymentInterfaceHandler = paymentInterfaceHandler;
  @override
  Future<PaymentModel> createPaymentIntent({
    required PaymentParams params,
  }) async {
    try {
      final response = await _paymentInterfaceHandler.post(
        EndPoint.paymentIntents,
        body: params.toFormData(),
      );
      return PaymentModel.fromJson(response.data);
    } on DioException catch (dioException) {
      throw DioExceptionHandler.handle(dioException);
    } catch (error) {
      log("❌ Real Error: $error");
      throw ErrorModel.unknownError();
    }
  }
}
