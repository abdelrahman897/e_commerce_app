import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/errors/exceptions/exceptions.dart';
import 'package:e_commerce_app/core/network_handler/end_point.dart';
import 'package:e_commerce_app/features/products/data/datasources/remote_product_data_source.dart';
import 'package:e_commerce_app/features/products/data/models/products_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/mocks/mock_product.mocks.dart';
import '../../../../helpers/test_data/test_exceptions.dart';
import '../../../../helpers/test_data/test_json.dart';
import '../../../../helpers/test_data/test_params.dart';

void main() {
  late MockApiInterface mockApi;
  late RemoteProductDataSource dataSource;

  setUp(() {
    mockApi = MockApiInterface();
    dataSource = RemoteProductDataSource(apiInterface: mockApi);
  });

  group('RemoteProductDataSource', () {
    group('getProducts', () {
      test('getProducts is successfully', () async {
        when(
          mockApi.get(
            any,
            queryParams: anyNamed('queryParams'),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              data: TestJson.productsSuccessResponse,
              requestOptions: RequestOptions(path: EndPoint.products),
            ),
          ),
        );
        final result = await dataSource.getProducts(
          params: TestParams.tProductParams,
        );
        expect(result, isA<ProductsModel>());
        expect(result.results, equals(1));
      });

      test('getProducts is error.', () async {
        when(
          mockApi.get(
            any,
            queryParams: anyNamed('queryParams'),
          ),
        ).thenThrow(
          TestExceptions.dioException(
            statusCode: 404,
            message: 'Not Found',
            path: EndPoint.products,
          ),
        );
        Future<ProductsModel> result() async =>
            await dataSource.getProducts(params: TestParams.tProductParams);
        expect(result, throwsA(isA<ServerException>()));
      });

      test('getProducts is called exactly one.', () async {
        when(
          mockApi.get(
            any,
            queryParams: anyNamed('queryParams'),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              data: TestJson.productsSuccessResponse,
              requestOptions: RequestOptions(path: EndPoint.products),
            ),
          ),
        );
        await dataSource.getProducts(params: TestParams.tProductParams);
        verify(
          mockApi.get(
            EndPoint.products,
            queryParams: TestParams.tProductParams.paginationToJson(),
          ),
        ).called(1);
      });
    });

    group('getProducts with soldParam', () {
      test('getProducts with sort is successfully', () async {
        when(
          mockApi.get(
            any,
            queryParams: anyNamed('queryParams'),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              data: TestJson.productsSuccessResponse,
              requestOptions: RequestOptions(path: EndPoint.products),
            ),
          ),
        );
        final result = await dataSource.getProducts(
          params: TestParams.tProductParamsSorted,
        );
        expect(result, isA<ProductsModel>());
      });
    });
  });
}
