import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failures.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/delete_product_from_cart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mocks/mock_cart.mocks.dart';
import '../../../../helpers/test_data/test_entities.dart';
import '../../../../helpers/test_data/test_failures.dart';
import '../../../../helpers/test_data/test_params.dart';

void main() {
  late MockCartRepository mockCartRepository;
  late DeleteProductFromCart deleteProductFromCart;
  setUp(() {
    mockCartRepository = MockCartRepository();
    deleteProductFromCart = DeleteProductFromCart(mockCartRepository);
  });

  group('DeleteProductFromCart', () {
    test('DeleteProductFromCart Success', () async {
      when(
        mockCartRepository.deleteProduct(params: TestParams.tCartParams),
      ).thenAnswer((_) => Future.value(Right(TestEntities.tCart)));
      final result = await deleteProductFromCart(
        params: TestParams.tCartParams,
      );
      expect(result, equals(Right<Failure, Cart>(TestEntities.tCart)));
      verify(
        mockCartRepository.deleteProduct(params: TestParams.tCartParams),
      ).called(1);
    });
    test('DeleteProductFromCart failure', () async {
      when(
        mockCartRepository.deleteProduct(params: TestParams.tCartParams),
      ).thenAnswer((_) => Future.value(Left(TestFailures.tServerFailure)));
      final result = await deleteProductFromCart(
        params: TestParams.tCartParams,
      );
      expect(
        result,
        equals(Left<Failure, Cart>(TestFailures.tServerFailure)),
      );
    });

    test('cartRepository called excatly one.', () async {
      when(
        mockCartRepository.deleteProduct(params: TestParams.tCartParams),
      ).thenAnswer((_) => Future.value(Right(TestEntities.tCart)));
      await deleteProductFromCart(params: TestParams.tCartParams);
      verify(
        mockCartRepository.deleteProduct(params: TestParams.tCartParams),
      ).called(1);
    });
  });
}
