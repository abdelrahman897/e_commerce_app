import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/errors/exceptions/exceptions.dart';
import 'package:e_commerce_app/core/network_handler/end_point.dart';
import 'package:e_commerce_app/features/wishlist/data/datasources/wishlist_remote_data_source.dart';
import 'package:e_commerce_app/features/wishlist/data/models/wishlist_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/mocks/mock_wishlist.mocks.dart';
import '../../../../helpers/test_data/test_data.dart';
import '../../../../helpers/test_data/test_exceptions.dart';
import '../../../../helpers/test_data/test_json.dart';
import '../../../../helpers/test_data/test_params.dart';

void main() {
  late MockApiInterface mockApi;
  late WishlistRemoteDataSourceImp dataSource;

  setUp(() {
    mockApi = MockApiInterface();
    dataSource = WishlistRemoteDataSourceImp(apiInterface: mockApi);
  });

  group('WishlistRemoteDataSourceImp', () {
    group('getWishlist', () {
      test('getWishlist is successfully', () async {
        when(mockApi.get(EndPoint.wishlist)).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              data: TestJson.wishlistSuccessResponse,
              requestOptions: RequestOptions(path: EndPoint.wishlist),
            ),
          ),
        );
        final result = await dataSource.getWishlist();
        expect(result, isA<WishlistResponse>());
        expect(result.status, equals(TestConstants.tWishlistStatus));
      });

      test('getWishlist is error.', () async {
        when(mockApi.get(EndPoint.wishlist)).thenThrow(
          TestExceptions.dioException(
            statusCode: 404,
            message: 'Not Found',
            path: EndPoint.wishlist,
          ),
        );
        Future<WishlistResponse> result() async => dataSource.getWishlist();
        expect(result, throwsA(isA<ServerException>()));
      });

      test('getWishlist is called exactly one.', () async {
        when(mockApi.get(EndPoint.wishlist)).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              data: TestJson.wishlistSuccessResponse,
              requestOptions: RequestOptions(path: EndPoint.wishlist),
            ),
          ),
        );
        await dataSource.getWishlist();
        verify(mockApi.get(EndPoint.wishlist)).called(1);
      });
    });

    group('addProduct', () {
      test('addProduct is successfully', () async {
        when(
          mockApi.post(
            EndPoint.wishlist,
            body: TestParams.tWishlistParams.toJson(),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              requestOptions: RequestOptions(path: EndPoint.wishlist),
            ),
          ),
        );
        await expectLater(
          dataSource.addProduct(params: TestParams.tWishlistParams),
          completes,
        );
      });

      test('addProduct is error.', () async {
        when(
          mockApi.post(
            EndPoint.wishlist,
            body: TestParams.tWishlistParams.toJson(),
          ),
        ).thenThrow(
          TestExceptions.dioException(
            statusCode: 404,
            message: 'Not Found',
            path: EndPoint.wishlist,
          ),
        );
        Future<void> result() async =>
            dataSource.addProduct(params: TestParams.tWishlistParams);
        expect(result, throwsA(isA<ServerException>()));
      });

      test('addProduct is called exactly one.', () async {
        when(
          mockApi.post(
            EndPoint.wishlist,
            body: TestParams.tWishlistParams.toJson(),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              requestOptions: RequestOptions(path: EndPoint.wishlist),
            ),
          ),
        );
        await dataSource.addProduct(params: TestParams.tWishlistParams);
        verify(
          mockApi.post(
            EndPoint.wishlist,
            body: TestParams.tWishlistParams.toJson(),
          ),
        ).called(1);
      });
    });

    group('deleteProduct', () {
      test('deleteProduct is successfully', () async {
        when(
          mockApi.delete(
            '${EndPoint.wishlist}/${TestParams.tWishlistParams.productId}',
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              requestOptions: RequestOptions(path: EndPoint.wishlist),
            ),
          ),
        );
        await expectLater(
          dataSource.deleteProduct(params: TestParams.tWishlistParams),
          completes,
        );
      });

      test('deleteProduct is error.', () async {
        when(
          mockApi.delete(
            '${EndPoint.wishlist}/${TestParams.tWishlistParams.productId}',
          ),
        ).thenThrow(
          TestExceptions.dioException(
            statusCode: 404,
            message: 'Not Found',
            path: EndPoint.wishlist,
          ),
        );
        Future<void> result() async =>
            dataSource.deleteProduct(params: TestParams.tWishlistParams);
        expect(result, throwsA(isA<ServerException>()));
      });

      test('deleteProduct is called exactly one.', () async {
        when(
          mockApi.delete(
            '${EndPoint.wishlist}/${TestParams.tWishlistParams.productId}',
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              requestOptions: RequestOptions(path: EndPoint.wishlist),
            ),
          ),
        );
        await dataSource.deleteProduct(params: TestParams.tWishlistParams);
        verify(
          mockApi.delete(
            '${EndPoint.wishlist}/${TestParams.tWishlistParams.productId}',
          ),
        ).called(1);
      });
    });
  });
}
