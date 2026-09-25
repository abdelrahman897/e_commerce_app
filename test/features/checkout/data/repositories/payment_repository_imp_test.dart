import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/exceptions/exceptions.dart';
import 'package:e_commerce_app/core/errors/failures/failures.dart';
import 'package:e_commerce_app/features/checkout/data/repositories/payment_repository_imp.dart';
import 'package:e_commerce_app/features/checkout/domain/entities/payment.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/mocks/mock_auth.mocks.dart';
import '../../../../helpers/mocks/mock_checkout.mocks.dart';
import '../../../../helpers/test_data/test_data.dart';
import '../../../../helpers/test_data/test_entities.dart';
import '../../../../helpers/test_data/test_exceptions.dart';
import '../../../../helpers/test_data/test_models.dart';
import '../../../../helpers/test_data/test_params.dart';

void main() {
  late PaymentRepositoryImp paymentRepository;
  late MockPaymentDataSource mockDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockDataSource = MockPaymentDataSource();
    paymentRepository = PaymentRepositoryImp(
      paymentDataSource: mockDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  const tNoInternet = Left<Failure, dynamic>(ServerFailure.noInternet());
  group('payment repository imp', () {
    group('createPaymentIntent Repository', () {
      test('createPaymentIntent Repository is successfully', () async {
        TestConnection.onLine(mockNetworkInfo);
        when(
          mockDataSource.createPaymentIntent(
            params: TestParams.tPaymentParams,
          ),
        ).thenAnswer((_) => Future.value(TestModels.tPaymentModel));
        final result = await paymentRepository.createPaymentIntent(
          params: TestParams.tPaymentParams,
        );
        expect(
          result,
          equals(Right<Failure, Payment>(TestEntities.tPayment)),
        );
      });
      test('createPaymentIntent Repository is failure', () async {
        TestConnection.onLine(mockNetworkInfo);
        when(
          mockDataSource.createPaymentIntent(
            params: TestParams.tPaymentParams,
          ),
        ).thenThrow(
          UnauthorizedException(
            TestExceptions.errorModel(
              errorMessage: 'Unauthorized',
              statusCode: 401,
            ),
          ),
        );
        final result = await paymentRepository.createPaymentIntent(
          params: TestParams.tPaymentParams,
        );
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) => expect(failure, isA<Failure>()),
          (_) => fail(TestConstants.tExcpectedMessageLeft),
        );
      });

      test('isOffline', () async {
        TestConnection.offLine(mockNetworkInfo);
        final result = await paymentRepository.createPaymentIntent(
          params: TestParams.tPaymentParams,
        );
        expect(result, equals(tNoInternet));
        verifyNever(
          mockDataSource.createPaymentIntent(
            params: TestParams.tPaymentParams,
          ),
        );
      });
    });
  });
}
