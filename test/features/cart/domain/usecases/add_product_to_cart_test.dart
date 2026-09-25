import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failures.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/add_product_to_cart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mocks/mock_cart.mocks.dart';
import '../../../../helpers/test_data/test_failures.dart';
import '../../../../helpers/test_data/test_params.dart';

void main() {
  late MockCartRepository mockCartRepository;
  late AddProductToCart addProductToCart;
  setUp(() {
    mockCartRepository = MockCartRepository();
    addProductToCart = AddProductToCart(mockCartRepository);
  });

  group('AddProductToCart', () {
    test('AddProductToCart Success', () async {
      when(
        mockCartRepository.addProduct(params: TestParams.tCartParams),
      ).thenAnswer((_) => Future.value(Right(null)));
      final result = await addProductToCart(params: TestParams.tCartParams);
      expect(result, equals(Right<Failure, void>(null)));
      verify(
        mockCartRepository.addProduct(params: TestParams.tCartParams),
      ).called(1);
    });
    test('AddProductToCart failure', () async {
      when(
        mockCartRepository.addProduct(params: TestParams.tCartParams),
      ).thenAnswer((_) => Future.value(Left(TestFailures.tServerFailure)));
      final result = await addProductToCart(params: TestParams.tCartParams);
      expect(
        result,
        equals(Left<Failure, void>(TestFailures.tServerFailure)),
      );
    });

    test('cartRepository called excatly one.', () async {
      when(
        mockCartRepository.addProduct(params: TestParams.tCartParams),
      ).thenAnswer((_) => Future.value(Right(null)));
      await addProductToCart(params: TestParams.tCartParams);
      verify(
        mockCartRepository.addProduct(params: TestParams.tCartParams),
      ).called(1);
    });
  });
}
