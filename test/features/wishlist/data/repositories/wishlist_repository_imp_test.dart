import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/exceptions/cache_exception.dart';
import 'package:e_commerce_app/core/errors/exceptions/server_exception.dart';
import 'package:e_commerce_app/core/errors/failures/failures.dart';
import 'package:e_commerce_app/features/wishlist/data/repositories/wishlist_repository_imp.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/mocks/mock_wishlist.mocks.dart';
import '../../../../helpers/test_data/test_data.dart';
import '../../../../helpers/test_data/test_exceptions.dart';
import '../../../../helpers/test_data/test_models.dart';
import '../../../../helpers/test_data/test_params.dart';

void main() {
  late WishlistRepositoryImp wishlistRepository;
  late MockWishlistRemoteDataSource mockRemoteDataSource;
  late MockWishlistLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockWishlistRemoteDataSource();
    mockLocalDataSource = MockWishlistLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    wishlistRepository = WishlistRepositoryImp(
      wishlistRemoteDataSource: mockRemoteDataSource,
      wishlistLocalDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  const tNoInternet = Left<Failure, dynamic>(ServerFailure.noInternet());

  group('WishlistRepositoryImp', () {
    group('getWishlist', () {
      test('getWishlist is successfully (online)', () async {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((_) => Future.value(true));
        when(mockRemoteDataSource.getWishlist())
            .thenAnswer((_) => Future.value(TestModels.tWishlistResponse));
        final result = await wishlistRepository.getWishlist();
        expect(result.isRight(), isTrue);
        result.fold(
          (_) => fail(TestConstants.tExcpectedMessageLeft),
          (products) => expect(products, isA<List<ProductItem>>()),
        );
      });

      test('getWishlist is failure (online)', () async {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((_) => Future.value(true));
        when(mockRemoteDataSource.getWishlist()).thenThrow(
          NotFoundException(
            TestExceptions.errorModel(
              errorMessage: 'Not Found',
              statusCode: 404,
            ),
          ),
        );
        final result = await wishlistRepository.getWishlist();
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) => expect(failure, isA<Failure>()),
          (_) => fail(TestConstants.tExcpectedMessageLeft),
        );
      });

      test('getWishlist is successfully (offline)', () async {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((_) => Future.value(false));
        when(mockLocalDataSource.getCachedWishlist())
            .thenAnswer((_) => Future.value([TestModels.tProductItemModel]));
        final result = await wishlistRepository.getWishlist();
        expect(result.isRight(), isTrue);
        result.fold(
          (_) => fail(TestConstants.tExcpectedMessageLeft),
          (products) => expect(products, isA<List<ProductItem>>()),
        );
      });

      test('getWishlist is failure (offline)', () async {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((_) => Future.value(false));
        when(mockLocalDataSource.getCachedWishlist())
            .thenThrow(UnknownCacheException(errorMessage: 'Cache error'));
        final result = await wishlistRepository.getWishlist();
        expect(result.isLeft(), isTrue);
      });
    });

    group('addProduct', () {
      test('addProduct is successfully (online)', () async {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((_) => Future.value(true));
        when(
          mockRemoteDataSource.addProduct(
            params: TestParams.tWishlistParams,
          ),
        ).thenAnswer((_) => Future.value(null));
        final result = await wishlistRepository.addProduct(
          params: TestParams.tWishlistParams,
        );
        expect(result, equals(const Right<Failure, void>(null)));
      });

      test('addProduct is failure (online)', () async {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((_) => Future.value(true));
        when(
          mockRemoteDataSource.addProduct(
            params: TestParams.tWishlistParams,
          ),
        ).thenThrow(
          NotFoundException(
            TestExceptions.errorModel(
              errorMessage: 'Not Found',
              statusCode: 404,
            ),
          ),
        );
        final result = await wishlistRepository.addProduct(
          params: TestParams.tWishlistParams,
        );
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) => expect(failure, isA<Failure>()),
          (_) => fail(TestConstants.tExcpectedMessageLeft),
        );
      });

      test('addProduct isOffline', () async {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((_) => Future.value(false));
        final result = await wishlistRepository.addProduct(
          params: TestParams.tWishlistParams,
        );
        expect(result, equals(tNoInternet));
        verifyNever(
          mockRemoteDataSource.addProduct(
            params: TestParams.tWishlistParams,
          ),
        );
      });
    });

    group('deleteProduct', () {
      test('deleteProduct is successfully (online)', () async {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((_) => Future.value(true));
        when(
          mockRemoteDataSource.deleteProduct(
            params: TestParams.tWishlistParams,
          ),
        ).thenAnswer((_) => Future.value(null));
        when(
          mockLocalDataSource.deleteCachedProduct(
            params: TestParams.tWishlistParams,
          ),
        ).thenAnswer((_) => Future.value(null));
        final result = await wishlistRepository.deleteProduct(
          params: TestParams.tWishlistParams,
        );
        expect(result, equals(const Right<Failure, void>(null)));
      });

      test('deleteProduct is failure (online)', () async {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((_) => Future.value(true));
        when(
          mockRemoteDataSource.deleteProduct(
            params: TestParams.tWishlistParams,
          ),
        ).thenThrow(
          NotFoundException(
            TestExceptions.errorModel(
              errorMessage: 'Not Found',
              statusCode: 404,
            ),
          ),
        );
        final result = await wishlistRepository.deleteProduct(
          params: TestParams.tWishlistParams,
        );
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) => expect(failure, isA<Failure>()),
          (_) => fail(TestConstants.tExcpectedMessageLeft),
        );
      });

      test('deleteProduct isOffline', () async {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((_) => Future.value(false));
        final result = await wishlistRepository.deleteProduct(
          params: TestParams.tWishlistParams,
        );
        expect(result, equals(tNoInternet));
        verifyNever(
          mockRemoteDataSource.deleteProduct(
            params: TestParams.tWishlistParams,
          ),
        );
      });
    });
  });
}
