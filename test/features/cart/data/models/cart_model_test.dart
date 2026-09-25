import 'package:e_commerce_app/features/cart/data/models/cart_response/cart_model.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_response/cart_item_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_data/test_json.dart';

void main() {
  group('CartModel', () {
    group('fromJson', () {
      test('success', () {
        final result = CartModel.fromJson(TestJson.cartModelSuccessResponse);
        expect(result, isA<CartModel>());
        expect(result.items, isNotEmpty);
        expect(result.items.first, isA<CartItemModel>());
      });
      test('empty success', () {
        final result = CartModel.fromJson(TestJson.cartEmptyModelResponse);
        expect(result, isA<CartModel>());
        expect(result.items, isEmpty);
      });
    });
    group('equatable', () {
      test('Two instance identical', () {
        final a = CartModel.fromJson(TestJson.cartModelSuccessResponse);
        final b = CartModel.fromJson(TestJson.cartModelSuccessResponse);
        expect(a, equals(b));
        expect(a.hashCode, equals(b.hashCode));
      });

      test('props contain 7 elements', () {
        final result = CartModel.fromJson(TestJson.cartModelSuccessResponse);
        expect(result.props, hasLength(7));
      });
    });
  });
}
