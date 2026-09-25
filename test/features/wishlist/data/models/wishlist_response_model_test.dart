import 'package:e_commerce_app/features/wishlist/data/models/wishlist_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_data/test_data.dart';
import '../../../../helpers/test_data/test_json.dart';

void main() {
  group('WishlistResponse', () {
    group('fromJson', () {
      test('parses correctly with products', () {
        final result = WishlistResponse.fromJson(
          TestJson.wishlistSuccessResponse,
        );
        expect(result.status, equals(TestConstants.tWishlistStatus));
        expect(result.count, equals(TestConstants.tWishlistCount));
        expect(result.products, hasLength(1));
      });

      test('parses empty products correctly', () {
        final result = WishlistResponse.fromJson(
          TestJson.wishlistEmptySuccessResponse,
        );
        expect(result.status, equals(TestConstants.tWishlistStatus));
        expect(result.count, equals(0));
        expect(result.products, isEmpty);
      });
    });

    group('equatable', () {
      test('Two instances identical', () {
        final a = WishlistResponse.fromJson(
          TestJson.wishlistSuccessResponse,
        );
        final b = WishlistResponse.fromJson(
          TestJson.wishlistSuccessResponse,
        );
        expect(a, equals(b));
        expect(a.hashCode, equals(b.hashCode));
      });

      test('different count are not equal', () {
        final a = WishlistResponse.fromJson(
          TestJson.wishlistSuccessResponse,
        );
        final b = WishlistResponse.fromJson(
          TestJson.wishlistEmptySuccessResponse,
        );
        expect(a, isNot(equals(b)));
      });

      test('props contain status, count, products', () {
        final response = WishlistResponse.fromJson(
          TestJson.wishlistSuccessResponse,
        );
        expect(response.props, hasLength(3));
      });
    });
  });
}
