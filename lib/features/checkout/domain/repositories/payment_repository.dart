import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failures.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/features/checkout/domain/entities/payment.dart';

abstract interface class PaymentRepository {
  Future<Either<Failure, Payment>> createPaymentIntent({
    required PaymentParams params,
  });

}
