part of 'payment_bloc.dart';

sealed class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

final class CreatePaymentIntentEvent extends PaymentEvent {
  final PaymentParams params;
  const CreatePaymentIntentEvent({required this.params});
  @override
  List<Object> get props => [params];
}

final class PaymentProcessEvent extends PaymentEvent {
  const PaymentProcessEvent();
}
