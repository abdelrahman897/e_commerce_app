import 'package:e_commerce_app/core/errors/failures/failure.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';

sealed class PaymentFailure extends Failure {
  const PaymentFailure({required super.message});
}

final class NetworkPaymentFailure extends PaymentFailure {
  const NetworkPaymentFailure({required super.message});

  @override
  List<Object?> get props => [message];
}

final class StripePaymentFailure extends PaymentFailure {
  const StripePaymentFailure({required super.message});

  @override
  List<Object?> get props => [message];
}

final class CancelledPaymentFailure extends PaymentFailure {
  const CancelledPaymentFailure()
    : super(message: AppErrorMessages.paymentCancelled);

  @override
  List<Object?> get props => [message];
}

final class UnknownPaymentFailure extends PaymentFailure {
  const UnknownPaymentFailure() : super(message: AppErrorMessages.unknown);

  @override
  List<Object?> get props => [message];
}
