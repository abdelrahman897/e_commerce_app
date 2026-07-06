import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failure.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/core/usecases/base_usecase.dart';
import 'package:e_commerce_app/features/checkout/domain/entities/payment.dart';
import 'package:e_commerce_app/features/checkout/domain/repositories/payment_repository.dart';

class CreatePaymentIntent implements BaseUsecase<Payment, PaymentParams> {
  final PaymentRepository _paymentRepository;
  const CreatePaymentIntent(this._paymentRepository);
  @override
  Future<Either<Failure, Payment>> call({required PaymentParams params}) async {
    return await _paymentRepository.createPaymentIntent(params: params);
  }
}
