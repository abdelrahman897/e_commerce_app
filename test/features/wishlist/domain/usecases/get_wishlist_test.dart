import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failure.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_item.dart';
import 'package:e_commerce_app/features/wishlist/domain/usecases/get_wishlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mocks/mock_wishlist.mocks.dart';
import '../../../../helpers/test_data/test_data.dart';
import '../../../../helpers/test_data/test_entities.dart';
import '../../../../helpers/test_data/test_failures.dart';

void main() {
  late MockWishlistRepository mockWishlistRepository;
  late GetWishlist getWishlist;

  setUp(() {
    mockWishlistRepository = MockWishlistRepository();
    getWishlist = GetWishlist(mockWishlistRepository);
  });

  group('GetWishlist', () {
    test('GetWishlist Success', () async {
      when(mockWishlistRepository.getWishlist()).thenAnswer(
        (_) => Future.value(Right(TestEntities.tProductItems)),
      );
      final result = await getWishlist();
      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail(TestConstants.tExcpectedMessageLeft),
        (products) {
          expect(products, isA<List<ProductItem>>());
          expect(products.length, equals(TestEntities.tProductItems.length));
          expect(products.first.id, equals(TestEntities.tProductItems.first.id));
        },
      );
      verify(mockWishlistRepository.getWishlist()).called(1);
    });

    test('GetWishlist failure', () async {
      when(mockWishlistRepository.getWishlist()).thenAnswer(
        (_) => Future.value(
          Left<Failure, List<ProductItem>>(TestFailures.tServerFailure),
        ),
      );
      final result = await getWishlist();
      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<Failure>()),
        (_) => fail(TestConstants.tExcpectedMessageLeft),
      );
    });

    test('wishlistRepository called exactly one.', () async {
      when(mockWishlistRepository.getWishlist()).thenAnswer(
        (_) => Future.value(Right(TestEntities.tProductItems)),
      );
      await getWishlist();
      verify(mockWishlistRepository.getWishlist()).called(1);
    });
  });
}
