import 'package:e_commerce_app/features/cart/data/models/cart_response/cart_item_model.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_response/cart_product_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_data/test_data.dart';
import '../../../../helpers/test_data/test_json.dart';

void main() {
  group('CartItemModel', () {
    group('fromJson', () {
      test('success', () {
        final result = CartItemModel.fromJson(TestJson.cartItemSuccessResponse);
        expect(result, isA<CartItemModel>());
        expect(result.count, equals(TestConstants.tCount));
        expect(result.id, equals(TestConstants.tCartItemId));
        expect(result.cartProduct, isA<CartProductModel>());
      });
    });
    group('equatable', () {
      test('Two instance identical', () {
        final a = CartItemModel.fromJson(TestJson.cartItemSuccessResponse);
        final b = CartItemModel.fromJson(TestJson.cartItemSuccessResponse);
        expect(a, equals(b));
        expect(a.hashCode, equals(b.hashCode));
      });

      test('props contain 4 elements count, id, cartProduct, price', () {
        final result = CartItemModel.fromJson(TestJson.cartItemSuccessResponse);
        expect(result.props, hasLength(4));
      });
    });
  });
}
