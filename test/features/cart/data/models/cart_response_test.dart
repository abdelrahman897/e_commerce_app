import 'package:e_commerce_app/features/cart/data/models/cart_response/cart_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_data/test_data.dart';
import '../../../../helpers/test_data/test_json.dart';

void main() {
  group('CartResponse', () {
    group('fromJson', () {
      test('parce is correctly and cart items exist', () {
        final result = CartResponse.fromJson(TestJson.cartSuccessResponse);
        expect(result.status, equals(TestConstants.tCartStatus));
        expect(result.numOfCartItems, equals(TestConstants.tNumOfCartItems));
        expect(result.cartId, equals(TestConstants.tCartId));
        expect(result.cart.items, isNotEmpty);
      });
      test('parce is correctly and cart items is empty', () {
        final result = CartResponse.fromJson(TestJson.cartEmptySuccessResponse);
        expect(result.status, equals(TestConstants.tCartStatus));
        expect(result.numOfCartItems, equals(0));
        expect(result.cart.items, isEmpty);
      });
    });
    group('equatable', () {
      test('Two instance identical', () {
        final a = CartResponse.fromJson(TestJson.cartSuccessResponse);
        final b = CartResponse.fromJson(TestJson.cartSuccessResponse);
        expect(a, equals(b));
        expect(a.hashCode, equals(b.hashCode));
      });

      test('cart with items not equal cart without items', () {
        final cartWithItems = CartResponse.fromJson(
          TestJson.cartSuccessResponse,
        );
        final cartWithoutItems = CartResponse.fromJson(
          TestJson.cartEmptySuccessResponse,
        );
        expect(cartWithItems, isNot(equals(cartWithoutItems)));
      });

      test('props contain 4 elements status, numOfCartItems, cartId, cart', () {
        final result = CartResponse.fromJson(TestJson.cartSuccessResponse);
        expect(result.props, hasLength(4));
      });
    });
  });
}
