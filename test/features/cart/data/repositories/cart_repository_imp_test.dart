import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/exceptions/server_exception.dart';
import 'package:e_commerce_app/core/errors/failures/failures.dart';
import 'package:e_commerce_app/features/cart/data/repositories/cart_repository_imp.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/mocks/mock_auth.mocks.dart';
import '../../../../helpers/mocks/mock_cart.mocks.dart';
import '../../../../helpers/test_data/test_data.dart';
import '../../../../helpers/test_data/test_entities.dart';
import '../../../../helpers/test_data/test_exceptions.dart';
import '../../../../helpers/test_data/test_models.dart';
import '../../../../helpers/test_data/test_params.dart';

void main() {
  late CartRepositoryImp cartRepository;
  late MockCartDataSource mockDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockDataSource = MockCartDataSource();
    cartRepository = CartRepositoryImp(
      cartDataSource: mockDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  const tNoInternet = Left<Failure, dynamic>(ServerFailure.noInternet());
  group('cart repository imp', () {
    group('getCart Repository', () {
      test('getCart Repository is successfully', () async {
        TestConnection.onLine(mockNetworkInfo);
        when(mockDataSource.getCart()).thenAnswer(
          (_) => Future.value(TestModels.tCartResponse),
        );
        final result = await cartRepository.getCart();
        expect(
          result,
          equals(Right<Failure, Cart>(TestEntities.tCart)),
        );
      });
      test('getCart Repository is failure', () async {
        TestConnection.onLine(mockNetworkInfo);
        when(mockDataSource.getCart()).thenThrow(
          UnauthorizedException(
            TestExceptions.errorModel(
              errorMessage: 'Unauthorized',
              statusCode: 401,
            ),
          ),
        );
        final result = await cartRepository.getCart();
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) => expect(failure, isA<Failure>()),
          (_) => fail(TestConstants.tExcpectedMessageLeft),
        );
      });
      test('isOffline', () async {
        TestConnection.offLine(mockNetworkInfo);
        final result = await cartRepository.getCart();
        expect(result, equals(tNoInternet));
        verifyNever(mockDataSource.getCart());
      });
    });
    group('addProduct Repository', () {
      test('addProduct Repository is successfully', () async {
        TestConnection.onLine(mockNetworkInfo);
        when(
          mockDataSource.addProduct(params: TestParams.tCartParams),
        ).thenAnswer((_) => Future.value());
        final result = await cartRepository.addProduct(
          params: TestParams.tCartParams,
        );
        expect(result, equals(Right<Failure, void>(null)));
      });
      test('addProduct Repository is failure', () async {
        TestConnection.onLine(mockNetworkInfo);
        when(
          mockDataSource.addProduct(params: TestParams.tCartParams),
        ).thenThrow(
          UnauthorizedException(
            TestExceptions.errorModel(
              errorMessage: 'Unauthorized',
              statusCode: 401,
            ),
          ),
        );
        final result = await cartRepository.addProduct(
          params: TestParams.tCartParams,
        );
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) => expect(failure, isA<Failure>()),
          (_) => fail(TestConstants.tExcpectedMessageLeft),
        );
      });
      test('isOffline', () async {
        TestConnection.offLine(mockNetworkInfo);
        final result = await cartRepository.addProduct(
          params: TestParams.tCartParams,
        );
        expect(result, equals(tNoInternet));
        verifyNever(
          mockDataSource.addProduct(params: TestParams.tCartParams),
        );
      });
    });
    group('deleteProduct Repository', () {
      test('deleteProduct Repository is successfully', () async {
        TestConnection.onLine(mockNetworkInfo);
        when(
          mockDataSource.deleteProduct(params: TestParams.tCartParams),
        ).thenAnswer((_) => Future.value(TestModels.tCartResponse));
        final result = await cartRepository.deleteProduct(
          params: TestParams.tCartParams,
        );
        expect(
          result,
          equals(Right<Failure, Cart>(TestEntities.tCart)),
        );
      });
      test('deleteProduct Repository is failure', () async {
        TestConnection.onLine(mockNetworkInfo);
        when(
          mockDataSource.deleteProduct(params: TestParams.tCartParams),
        ).thenThrow(
          UnauthorizedException(
            TestExceptions.errorModel(
              errorMessage: 'Unauthorized',
              statusCode: 401,
            ),
          ),
        );
        final result = await cartRepository.deleteProduct(
          params: TestParams.tCartParams,
        );
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) => expect(failure, isA<Failure>()),
          (_) => fail(TestConstants.tExcpectedMessageLeft),
        );
      });
      test('isOffline', () async {
        TestConnection.offLine(mockNetworkInfo);
        final result = await cartRepository.deleteProduct(
          params: TestParams.tCartParams,
        );
        expect(result, equals(tNoInternet));
        verifyNever(
          mockDataSource.deleteProduct(params: TestParams.tCartParams),
        );
      });
    });
    group('updateProduct Repository', () {
      test('updateProduct Repository is successfully', () async {
        TestConnection.onLine(mockNetworkInfo);
        when(
          mockDataSource.updateProduct(
            params: TestParams.tCartParamsWithQuantity,
          ),
        ).thenAnswer((_) => Future.value(TestModels.tCartResponse));
        final result = await cartRepository.updateProduct(
          params: TestParams.tCartParamsWithQuantity,
        );
        expect(
          result,
          equals(Right<Failure, Cart>(TestEntities.tCart)),
        );
      });
      test('updateProduct Repository is failure', () async {
        TestConnection.onLine(mockNetworkInfo);
        when(
          mockDataSource.updateProduct(
            params: TestParams.tCartParamsWithQuantity,
          ),
        ).thenThrow(
          UnauthorizedException(
            TestExceptions.errorModel(
              errorMessage: 'Unauthorized',
              statusCode: 401,
            ),
          ),
        );
        final result = await cartRepository.updateProduct(
          params: TestParams.tCartParamsWithQuantity,
        );
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) => expect(failure, isA<Failure>()),
          (_) => fail(TestConstants.tExcpectedMessageLeft),
        );
      });
      test('isOffline', () async {
        TestConnection.offLine(mockNetworkInfo);
        final result = await cartRepository.updateProduct(
          params: TestParams.tCartParamsWithQuantity,
        );
        expect(result, equals(tNoInternet));
        verifyNever(
          mockDataSource.updateProduct(
            params: TestParams.tCartParamsWithQuantity,
          ),
        );
      });
    });
  });
}
