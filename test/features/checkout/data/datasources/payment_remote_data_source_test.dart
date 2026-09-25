import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/errors/exceptions/exceptions.dart';
import 'package:e_commerce_app/core/network_handler/end_point.dart';
import 'package:e_commerce_app/features/checkout/data/datasources/payment_remote_data_source.dart';
import 'package:e_commerce_app/features/checkout/data/models/payment_model/payment_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/mocks/mock_checkout.mocks.dart';
import '../../../../helpers/test_data/test_data.dart';
import '../../../../helpers/test_data/test_exceptions.dart';
import '../../../../helpers/test_data/test_json.dart';
import '../../../../helpers/test_data/test_params.dart';

void main() {
  late MockPaymentInterfaceHandler mockPaymentInterfaceHandler;
  late PaymentRemoteDataSource dataSource;

  setUp(() {
    mockPaymentInterfaceHandler = MockPaymentInterfaceHandler();
    dataSource = PaymentRemoteDataSource(
      paymentInterfaceHandler: mockPaymentInterfaceHandler,
    );
  });
  group('PaymentRemoteDataSource', () {
    group('createPaymentIntent', () {
      test('createPaymentIntent is successfully.', () async {
        when(
          mockPaymentInterfaceHandler.post(
            EndPoint.paymentIntents,
            body: anyNamed('body'),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              data: TestJson.paymentSuccessResponse,
              requestOptions: RequestOptions(path: EndPoint.paymentIntents),
            ),
          ),
        );
        final result = await dataSource.createPaymentIntent(
          params: TestParams.tPaymentParams,
        );
        expect(result, isA<PaymentModel>());
        expect(result.clientSecret, equals(TestConstants.tClientSecret));
      });

      test('createPaymentIntent is error.', () async {
        when(
          mockPaymentInterfaceHandler.post(
            EndPoint.paymentIntents,
            body: anyNamed('body'),
          ),
        ).thenThrow(
          TestExceptions.dioException(
            statusCode: 404,
            message: 'Not Found',
            path: EndPoint.paymentIntents,
          ),
        );
        Future<PaymentModel> result() async => await dataSource
            .createPaymentIntent(params: TestParams.tPaymentParams);
        expect(result, throwsA(isA<ServerException>()));
      });

      test('createPaymentIntent is called exactly one.', () async {
        when(
          mockPaymentInterfaceHandler.post(
            EndPoint.paymentIntents,
            body: anyNamed('body'),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              data: TestJson.paymentSuccessResponse,
              requestOptions: RequestOptions(path: EndPoint.paymentIntents),
            ),
          ),
        );
        await dataSource.createPaymentIntent(
          params: TestParams.tPaymentParams,
        );
        verify(
          mockPaymentInterfaceHandler.post(
            EndPoint.paymentIntents,
            body: anyNamed('body'),
          ),
        ).called(1);
      });
    });
  });
}
