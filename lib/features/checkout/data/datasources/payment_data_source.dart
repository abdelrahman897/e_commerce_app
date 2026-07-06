import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/features/checkout/data/models/payment_model/payment_model.dart';

abstract interface class PaymentDataSource {
  Future<PaymentModel> createPaymentIntent({required PaymentParams params});
}
