import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/errors/exceptions/exceptions.dart';
import 'package:e_commerce_app/core/network_handler/end_point.dart';
import 'package:e_commerce_app/features/cart/data/datasources/remote_cart_data_source.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_response/cart_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/mocks/mock_auth.mocks.dart';
import '../../../../helpers/test_data/test_data.dart';
import '../../../../helpers/test_data/test_exceptions.dart';
import '../../../../helpers/test_data/test_json.dart';
import '../../../../helpers/test_data/test_params.dart';

void main() {
  late MockApiInterface mockApi;
  late RemoteCartDataSource dataSource;

  setUp(() {
    mockApi = MockApiInterface();
    dataSource = RemoteCartDataSource(apiInterface: mockApi);
  });
  group('RemoteCartDataSource', () {
    group('getCart', () {
      test('getCart is successfully.', () async {
        when(mockApi.get(EndPoint.cart)).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              data: TestJson.cartSuccessResponse,
              requestOptions: RequestOptions(path: EndPoint.cart),
            ),
          ),
        );
        final result = await dataSource.getCart();
        expect(result, isA<CartResponse>());
        expect(result.numOfCartItems, equals(TestConstants.tNumOfCartItems));
      });

      test('getCart is error.', () async {
        when(mockApi.get(EndPoint.cart)).thenThrow(
          TestExceptions.dioException(
            statusCode: 404,
            message: 'Not Found',
            path: EndPoint.cart,
          ),
        );
        Future<CartResponse> result() async => await dataSource.getCart();
        expect(result, throwsA(isA<ServerException>()));
      });

      test('getCart is called exactly one.', () async {
        when(mockApi.get(EndPoint.cart)).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              data: TestJson.cartSuccessResponse,
              requestOptions: RequestOptions(path: EndPoint.cart),
            ),
          ),
        );
        await dataSource.getCart();
        verify(mockApi.get(EndPoint.cart)).called(1);
      });
    });
    group('addProduct', () {
      test('addProduct is successfully.', () async {
        when(
          mockApi.post(
            EndPoint.cart,
            body: TestParams.tCartParams.toJson(),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              requestOptions: RequestOptions(path: EndPoint.cart),
            ),
          ),
        );
        await expectLater(
          dataSource.addProduct(params: TestParams.tCartParams),
          completes,
        );
      });

      test('addProduct is error.', () async {
        when(
          mockApi.post(
            EndPoint.cart,
            body: TestParams.tCartParams.toJson(),
          ),
        ).thenThrow(
          TestExceptions.dioException(
            statusCode: 404,
            message: 'Not Found',
            path: EndPoint.cart,
          ),
        );
        Future<void> result() async =>
            await dataSource.addProduct(params: TestParams.tCartParams);
        expect(result, throwsA(isA<ServerException>()));
      });

      test('addProduct is called exactly one.', () async {
        when(
          mockApi.post(
            EndPoint.cart,
            body: TestParams.tCartParams.toJson(),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              requestOptions: RequestOptions(path: EndPoint.cart),
            ),
          ),
        );
        await dataSource.addProduct(params: TestParams.tCartParams);
        verify(
          mockApi.post(
            EndPoint.cart,
            body: TestParams.tCartParams.toJson(),
          ),
        ).called(1);
      });
    });
    group('deleteProduct', () {
      test('deleteProduct is successfully.', () async {
        when(
          mockApi.delete('${EndPoint.cart}/${TestParams.tCartParams.cartProductId}'),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              data: TestJson.cartSuccessResponse,
              requestOptions: RequestOptions(path: EndPoint.cart),
            ),
          ),
        );
        final result = await dataSource.deleteProduct(
          params: TestParams.tCartParams,
        );
        expect(result, isA<CartResponse>());
        expect(result.numOfCartItems, equals(TestConstants.tNumOfCartItems));
      });

      test('deleteProduct is error.', () async {
        when(
          mockApi.delete('${EndPoint.cart}/${TestParams.tCartParams.cartProductId}'),
        ).thenThrow(
          TestExceptions.dioException(
            statusCode: 404,
            message: 'Not Found',
            path: EndPoint.cart,
          ),
        );
        Future<CartResponse> result() async => await dataSource.deleteProduct(
          params: TestParams.tCartParams,
        );
        expect(result, throwsA(isA<ServerException>()));
      });

      test('deleteProduct is called exactly one.', () async {
        when(
          mockApi.delete('${EndPoint.cart}/${TestParams.tCartParams.cartProductId}'),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              data: TestJson.cartSuccessResponse,
              requestOptions: RequestOptions(path: EndPoint.cart),
            ),
          ),
        );
        await dataSource.deleteProduct(params: TestParams.tCartParams);
        verify(
          mockApi.delete('${EndPoint.cart}/${TestParams.tCartParams.cartProductId}'),
        ).called(1);
      });
    });
    group('updateProduct', () {
      test('updateProduct is successfully.', () async {
        when(
          mockApi.put(
            '${EndPoint.cart}/${TestParams.tCartParamsWithQuantity.cartProductId}',
            body: TestParams.tCartParamsWithQuantity.toJson(),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              data: TestJson.cartSuccessResponse,
              requestOptions: RequestOptions(path: EndPoint.cart),
            ),
          ),
        );
        final result = await dataSource.updateProduct(
          params: TestParams.tCartParamsWithQuantity,
        );
        expect(result, isA<CartResponse>());
        expect(result.numOfCartItems, equals(TestConstants.tNumOfCartItems));
      });

      test('updateProduct is error.', () async {
        when(
          mockApi.put(
            '${EndPoint.cart}/${TestParams.tCartParamsWithQuantity.cartProductId}',
            body: TestParams.tCartParamsWithQuantity.toJson(),
          ),
        ).thenThrow(
          TestExceptions.dioException(
            statusCode: 404,
            message: 'Not Found',
            path: EndPoint.cart,
          ),
        );
        Future<CartResponse> result() async => await dataSource.updateProduct(
          params: TestParams.tCartParamsWithQuantity,
        );
        expect(result, throwsA(isA<ServerException>()));
      });

      test('updateProduct is called exactly one.', () async {
        when(
          mockApi.put(
            '${EndPoint.cart}/${TestParams.tCartParamsWithQuantity.cartProductId}',
            body: TestParams.tCartParamsWithQuantity.toJson(),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              data: TestJson.cartSuccessResponse,
              requestOptions: RequestOptions(path: EndPoint.cart),
            ),
          ),
        );
        await dataSource.updateProduct(
          params: TestParams.tCartParamsWithQuantity,
        );
        verify(
          mockApi.put(
            '${EndPoint.cart}/${TestParams.tCartParamsWithQuantity.cartProductId}',
            body: TestParams.tCartParamsWithQuantity.toJson(),
          ),
        ).called(1);
      });
    });
  });
}
