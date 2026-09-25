import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failures.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/get_cart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mocks/mock_cart.mocks.dart';
import '../../../../helpers/test_data/test_entities.dart';
import '../../../../helpers/test_data/test_failures.dart';

void main() {
  late MockCartRepository mockCartRepository;
  late GetCart getCart;
  setUp(() {
    mockCartRepository = MockCartRepository();
    getCart = GetCart(mockCartRepository);
  });

  group('GetCart', () {
    test('GetCart Success', () async {
      when(mockCartRepository.getCart()).thenAnswer(
        (_) => Future.value(Right(TestEntities.tCart)),
      );
      final result = await getCart();
      expect(result, equals(Right<Failure, Cart>(TestEntities.tCart)));
      verify(mockCartRepository.getCart()).called(1);
    });
    test('GetCart failure', () async {
      when(mockCartRepository.getCart()).thenAnswer(
        (_) => Future.value(Left(TestFailures.tServerFailure)),
      );
      final result = await getCart();
      expect(
        result,
        equals(Left<Failure, Cart>(TestFailures.tServerFailure)),
      );
    });

    test('cartRepository called excatly one.', () async {
      when(mockCartRepository.getCart()).thenAnswer(
        (_) => Future.value(Right(TestEntities.tCart)),
      );
      await getCart();
      verify(mockCartRepository.getCart()).called(1);
    });
  });
}
