import 'package:e_commerce_app/features/checkout/data/models/payment_model/payment_model.dart';
import 'package:e_commerce_app/features/checkout/domain/entities/payment.dart';

extension PaymentMapper on PaymentModel {
  Payment get toEntity => Payment(clientSecret: clientSecret);
}
