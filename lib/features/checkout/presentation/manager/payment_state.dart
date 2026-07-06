part of 'payment_bloc.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

final class PaymentInitialState extends PaymentState {
  const PaymentInitialState();
}

final class PaymentLoadingState extends PaymentState {
  const PaymentLoadingState();
}

final class CreatePaymentIntentSuccessState extends PaymentState {
  final Payment payment;
  const CreatePaymentIntentSuccessState({required this.payment});
  @override
  List<Object> get props => [payment];
}

final class ProcessPaymentSuccessState extends PaymentState {
  const ProcessPaymentSuccessState();
}
final class ProcessPaymentFailureState extends PaymentState {
  final String failureMessage;
  const ProcessPaymentFailureState({required this.failureMessage});
  @override
  List<Object> get props => [failureMessage];
}
final class PaymentCancelledState extends PaymentState {
  const PaymentCancelledState();
}

final class PaymentFailureState extends PaymentState {
  final String failureMessage;
  const PaymentFailureState({required this.failureMessage});
  @override
  List<Object> get props => [failureMessage];
}
