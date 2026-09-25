import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failures.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/update_product_quantity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mocks/mock_cart.mocks.dart';
import '../../../../helpers/test_data/test_entities.dart';
import '../../../../helpers/test_data/test_failures.dart';
import '../../../../helpers/test_data/test_params.dart';

void main() {
  late MockCartRepository mockCartRepository;
  late UpdateProductQuantity updateProductQuantity;
  setUp(() {
    mockCartRepository = MockCartRepository();
    updateProductQuantity = UpdateProductQuantity(mockCartRepository);
  });

  group('UpdateProductQuantity', () {
    test('UpdateProductQuantity Success', () async {
      when(
        mockCartRepository.updateProduct(
          params: TestParams.tCartParamsWithQuantity,
        ),
      ).thenAnswer((_) => Future.value(Right(TestEntities.tCart)));
      final result = await updateProductQuantity(
        params: TestParams.tCartParamsWithQuantity,
      );
      expect(result, equals(Right<Failure, Cart>(TestEntities.tCart)));
      verify(
        mockCartRepository.updateProduct(
          params: TestParams.tCartParamsWithQuantity,
        ),
      ).called(1);
    });
    test('UpdateProductQuantity failure', () async {
      when(
        mockCartRepository.updateProduct(
          params: TestParams.tCartParamsWithQuantity,
        ),
      ).thenAnswer((_) => Future.value(Left(TestFailures.tServerFailure)));
      final result = await updateProductQuantity(
        params: TestParams.tCartParamsWithQuantity,
      );
      expect(
        result,
        equals(Left<Failure, Cart>(TestFailures.tServerFailure)),
      );
    });

    test('cartRepository called excatly one.', () async {
      when(
        mockCartRepository.updateProduct(
          params: TestParams.tCartParamsWithQuantity,
        ),
      ).thenAnswer((_) => Future.value(Right(TestEntities.tCart)));
      await updateProductQuantity(params: TestParams.tCartParamsWithQuantity);
      verify(
        mockCartRepository.updateProduct(
          params: TestParams.tCartParamsWithQuantity,
        ),
      ).called(1);
    });
  });
}
