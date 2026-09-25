import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failures.dart';
import 'package:e_commerce_app/features/checkout/domain/entities/payment.dart';
import 'package:e_commerce_app/features/checkout/domain/usecases/create_payment_intent.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mocks/mock_checkout.mocks.dart';
import '../../../../helpers/test_data/test_entities.dart';
import '../../../../helpers/test_data/test_failures.dart';
import '../../../../helpers/test_data/test_params.dart';

void main() {
  late MockPaymentRepository mockPaymentRepository;
  late CreatePaymentIntent createPaymentIntent;
  setUp(() {
    mockPaymentRepository = MockPaymentRepository();
    createPaymentIntent = CreatePaymentIntent(mockPaymentRepository);
  });

  group('CreatePaymentIntent', () {
    test('CreatePaymentIntent Success', () async {
      when(
        mockPaymentRepository.createPaymentIntent(
          params: TestParams.tPaymentParams,
        ),
      ).thenAnswer((_) => Future.value(Right(TestEntities.tPayment)));
      final result = await createPaymentIntent(
        params: TestParams.tPaymentParams,
      );
      expect(result, equals(Right<Failure, Payment>(TestEntities.tPayment)));
      verify(
        mockPaymentRepository.createPaymentIntent(
          params: TestParams.tPaymentParams,
        ),
      ).called(1);
    });
    test('CreatePaymentIntent failure', () async {
      when(
        mockPaymentRepository.createPaymentIntent(
          params: TestParams.tPaymentParams,
        ),
      ).thenAnswer((_) => Future.value(Left(TestFailures.tServerFailure)));
      final result = await createPaymentIntent(
        params: TestParams.tPaymentParams,
      );
      expect(
        result,
        equals(Left<Failure, Payment>(TestFailures.tServerFailure)),
      );
    });

    test('paymentRepository called excatly one.', () async {
      when(
        mockPaymentRepository.createPaymentIntent(
          params: TestParams.tPaymentParams,
        ),
      ).thenAnswer((_) => Future.value(Right(TestEntities.tPayment)));
      await createPaymentIntent(params: TestParams.tPaymentParams);
      verify(
        mockPaymentRepository.createPaymentIntent(
          params: TestParams.tPaymentParams,
        ),
      ).called(1);
    });
  });
}
