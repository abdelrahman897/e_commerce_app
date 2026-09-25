import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failure.dart';
import 'package:e_commerce_app/core/errors/failures/failures.dart';
import 'package:e_commerce_app/features/wishlist/domain/usecases/delete_product_from_wishlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mocks/mock_wishlist.mocks.dart';
import '../../../../helpers/test_data/test_failures.dart';
import '../../../../helpers/test_data/test_params.dart';

void main() {
  late MockWishlistRepository mockWishlistRepository;
  late DeleteProductFromWishlist deleteProductFromWishlist;

  setUp(() {
    mockWishlistRepository = MockWishlistRepository();
    deleteProductFromWishlist = DeleteProductFromWishlist(
      mockWishlistRepository,
    );
  });

  group('DeleteProductFromWishlist', () {
    test('DeleteProductFromWishlist Success', () async {
      when(
        mockWishlistRepository.deleteProduct(
          params: TestParams.tWishlistParams,
        ),
      ).thenAnswer((_) => Future.value(const Right<Failure, void>(null)));
      final result = await deleteProductFromWishlist(
        params: TestParams.tWishlistParams,
      );
      expect(result, equals(const Right<Failure, void>(null)));
      verify(
        mockWishlistRepository.deleteProduct(
          params: TestParams.tWishlistParams,
        ),
      ).called(1);
    });

    test('DeleteProductFromWishlist failure', () async {
      when(
        mockWishlistRepository.deleteProduct(
          params: TestParams.tWishlistParams,
        ),
      ).thenAnswer(
        (_) => Future.value(
          Left<Failure, void>(TestFailures.tServerFailure),
        ),
      );
      final result = await deleteProductFromWishlist(
        params: TestParams.tWishlistParams,
      );
      expect(
        result,
        equals(Left<Failure, void>(TestFailures.tServerFailure)),
      );
    });

    test('wishlistRepository called exactly one.', () async {
      when(
        mockWishlistRepository.deleteProduct(
          params: TestParams.tWishlistParams,
        ),
      ).thenAnswer((_) => Future.value(const Right<Failure, void>(null)));
      await deleteProductFromWishlist(
        params: TestParams.tWishlistParams,
      );
      verify(
        mockWishlistRepository.deleteProduct(
          params: TestParams.tWishlistParams,
        ),
      ).called(1);
    });
  });
}
