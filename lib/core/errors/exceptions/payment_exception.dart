import 'package:e_commerce_app/core/resources/constants_manager.dart';

sealed class PaymentException implements Exception {
  final String message;
  const PaymentException(this.message);
}

final class NetworkPaymentException extends PaymentException {
  const NetworkPaymentException(super.message);
}

final class StripePaymentException extends PaymentException {
  const StripePaymentException(super.message);
}

final class CancelledPaymentException extends PaymentException {
  const CancelledPaymentException() : super(AppErrorMessages.paymentCancelled);
}

final class UnknownPaymentException extends PaymentException {
  const UnknownPaymentException() : super(AppErrorMessages.unknown);
}