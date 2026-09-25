import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failures.dart';
import 'package:e_commerce_app/features/products/domain/entities/products.dart';
import 'package:e_commerce_app/features/products/domain/usecases/get_products.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mocks/mock_product.mocks.dart';
import '../../../../helpers/test_data/test_entities.dart';
import '../../../../helpers/test_data/test_failures.dart';
import '../../../../helpers/test_data/test_params.dart';

void main() {
  late MockProductRepository mockProductRepository;
  late GetProducts getProducts;

  setUp(() {
    mockProductRepository = MockProductRepository();
    getProducts = GetProducts(mockProductRepository);
  });

  group('GetProducts', () {
    test('GetProducts Success', () async {
      when(
        mockProductRepository.getProducts(
          params: TestParams.tProductParams,
        ),
      ).thenAnswer(
        (_) => Future.value(
          Right<Failure, Products>(TestEntities.tProducts),
        ),
      );
      final result = await getProducts(params: TestParams.tProductParams);
      expect(
        result,
        equals(Right<Failure, Products>(TestEntities.tProducts)),
      );
      verify(
        mockProductRepository.getProducts(
          params: TestParams.tProductParams,
        ),
      ).called(1);
    });

    test('GetProducts failure', () async {
      when(
        mockProductRepository.getProducts(
          params: TestParams.tProductParams,
        ),
      ).thenAnswer(
        (_) => Future.value(
          Left<Failure, Products>(TestFailures.tServerFailure),
        ),
      );
      final result = await getProducts(params: TestParams.tProductParams);
      expect(
        result,
        equals(Left<Failure, Products>(TestFailures.tServerFailure)),
      );
    });

    test('productRepository called exactly one.', () async {
      when(
        mockProductRepository.getProducts(
          params: TestParams.tProductParams,
        ),
      ).thenAnswer(
        (_) => Future.value(
          Right<Failure, Products>(TestEntities.tProducts),
        ),
      );
      await getProducts(params: TestParams.tProductParams);
      verify(
        mockProductRepository.getProducts(
          params: TestParams.tProductParams,
        ),
      ).called(1);
    });
  });
}
