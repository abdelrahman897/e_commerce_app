import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/exceptions/server_exception.dart';
import 'package:e_commerce_app/core/errors/failures/failures.dart';
import 'package:e_commerce_app/features/products/data/repositories/product_repository_imp.dart';
import 'package:e_commerce_app/features/products/domain/entities/products.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/mocks/mock_product.mocks.dart';
import '../../../../helpers/test_data/test_data.dart';
import '../../../../helpers/test_data/test_exceptions.dart';
import '../../../../helpers/test_data/test_models.dart';
import '../../../../helpers/test_data/test_params.dart';

void main() {
  late ProductRepositoryImp productRepository;
  late MockProductDataSource mockDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockDataSource = MockProductDataSource();
    productRepository = ProductRepositoryImp(
      productDataSource: mockDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  const tNoInternet = Left<Failure, dynamic>(ServerFailure.noInternet());

  group('ProductRepositoryImp', () {
    group('getProducts', () {
      test('getProducts is successfully', () async {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((_) => Future.value(true));
        when(
          mockDataSource.getProducts(params: TestParams.tProductParams),
        ).thenAnswer((_) => Future.value(TestModels.tProductsModel));
        final result = await productRepository.getProducts(
          params: TestParams.tProductParams,
        );
        expect(result.isRight(), isTrue);
        result.fold(
          (_) => fail(TestConstants.tExcpectedMessageLeft),
          (products) => expect(products, isA<Products>()),
        );
      });

      test('getProducts is failure', () async {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((_) => Future.value(true));
        when(
          mockDataSource.getProducts(params: TestParams.tProductParams),
        ).thenThrow(
          NotFoundException(
            TestExceptions.errorModel(
              errorMessage: 'Not Found',
              statusCode: 404,
            ),
          ),
        );
        final result = await productRepository.getProducts(
          params: TestParams.tProductParams,
        );
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) => expect(failure, isA<Failure>()),
          (_) => fail(TestConstants.tExcpectedMessageLeft),
        );
      });

      test('isOffline', () async {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((_) => Future.value(false));
        final result = await productRepository.getProducts(
          params: TestParams.tProductParams,
        );
        expect(result, equals(tNoInternet));
        verifyNever(
          mockDataSource.getProducts(params: TestParams.tProductParams),
        );
      });
    });
  });
}
