import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/features/checkout/domain/entities/payment.dart';
import 'package:e_commerce_app/features/checkout/domain/usecases/create_payment_intent.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final CreatePaymentIntent _createPaymentIntent;
  final Stripe _stripe;

  PaymentBloc({
    required CreatePaymentIntent createPaymentIntent,
    required Stripe stripe,
  }) : _stripe = stripe,
       _createPaymentIntent = createPaymentIntent,
       super(const PaymentInitialState()) {
    on<CreatePaymentIntentEvent>(_onCreatePaymentIntentEvent);
    on<PaymentProcessEvent>(_onPaymentProcessEvent);
  }
  FutureOr<void> _onCreatePaymentIntentEvent(
    CreatePaymentIntentEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoadingState());
    final result = await _createPaymentIntent(params: event.params);
    await result.fold(
      (failure) async =>
          emit(PaymentFailureState(failureMessage: failure.message)),
      (success) async {
        try {
          await _stripe.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: success.clientSecret,
              merchantDisplayName: AppStrings.merchantName,
            ),
          );
          emit(CreatePaymentIntentSuccessState(payment: success));
        } on StripeException catch (e) {
          emit(
            PaymentFailureState(
              failureMessage: e.error.message ?? AppConstants.failure,
            ),
          );
        }
      },
    );
  }

  FutureOr<void> _onPaymentProcessEvent(
    PaymentProcessEvent event,
    Emitter<PaymentState> emit,
  ) async {
    try {
      await _stripe.presentPaymentSheet();
      emit(ProcessPaymentSuccessState());
    } on StripeException catch (stripeException) {
      if (stripeException.error.code == FailureCode.Canceled) {
        emit(PaymentCancelledState());
      } else {
        emit(
          ProcessPaymentFailureState(
            failureMessage:
                stripeException.error.message ?? AppConstants.failure,
          ),
        );
      }
    }
  }
}
