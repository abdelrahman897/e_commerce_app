import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/features/checkout/presentation/manager/payment_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mocks/mock_checkout.mocks.dart';
import '../../../../helpers/test_data/test_entities.dart';
import '../../../../helpers/test_data/test_failures.dart';
import '../../../../helpers/test_data/test_params.dart';

void main() {
  late PaymentBloc paymentBloc;
  late MockCreatePaymentIntent mockCreatePaymentIntent;
  late MockStripe mockStripe;

  setUp(() {
    mockCreatePaymentIntent = MockCreatePaymentIntent();
    mockStripe = MockStripe();
    paymentBloc = PaymentBloc(
      createPaymentIntent: mockCreatePaymentIntent,
      stripe: mockStripe,
    );
  });
  tearDown(() => paymentBloc.close());

  group('payment bloc', () {
    group('CreatePaymentIntent Event', () {
      blocTest<PaymentBloc, PaymentState>(
        'emits [Loading, CreatePaymentIntentSuccess] when create payment intent succeeds',
        build: () {
          when(
            mockCreatePaymentIntent(params: TestParams.tPaymentParams),
          ).thenAnswer((_) => Future.value(Right(TestEntities.tPayment)));
          when(
            mockStripe.initPaymentSheet(
              paymentSheetParameters: anyNamed('paymentSheetParameters'),
            ),
          ).thenAnswer(
            (_) => Future.value(),
          );
          return paymentBloc;
        },
        act: (bloc) => bloc.add(
          CreatePaymentIntentEvent(params: TestParams.tPaymentParams),
        ),
        expect: () => [
          PaymentLoadingState(),
          CreatePaymentIntentSuccessState(payment: TestEntities.tPayment),
        ],
        verify: (_) {
          verify(
            mockCreatePaymentIntent(params: TestParams.tPaymentParams),
          ).called(1);
          verify(
            mockStripe.initPaymentSheet(
              paymentSheetParameters: anyNamed('paymentSheetParameters'),
            ),
          ).called(1);
        },
      );
      blocTest<PaymentBloc, PaymentState>(
        'emits [Loading, PaymentFailure] when create payment intent fails',
        build: () {
          when(
            mockCreatePaymentIntent(params: TestParams.tPaymentParams),
          ).thenAnswer((_) => Future.value(left(TestFailures.tServerFailure)));
          return paymentBloc;
        },
        act: (bloc) => bloc.add(
          CreatePaymentIntentEvent(params: TestParams.tPaymentParams),
        ),
        expect: () => [
          PaymentLoadingState(),
          PaymentFailureState(
            failureMessage: TestFailures.tServerFailure.message,
          ),
        ],
      );
    });
    group('PaymentProcess Event', () {
      blocTest<PaymentBloc, PaymentState>(
        'emits [ProcessPaymentSuccess] when payment process succeeds',
        build: () {
          when(mockStripe.presentPaymentSheet()).thenAnswer(
            (_) => Future.value(),
          );
          return paymentBloc;
        },
        act: (bloc) => bloc.add(const PaymentProcessEvent()),
        expect: () => [
          ProcessPaymentSuccessState(),
        ],
        verify: (_) {
          verify(mockStripe.presentPaymentSheet()).called(1);
        },
      );
    });
  });
}
