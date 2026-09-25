import 'package:e_commerce_app/features/cart/data/models/cart_response/cart_product_model.dart';
import 'package:e_commerce_app/features/home/data/models/brands_response/brand_model.dart';
import 'package:e_commerce_app/features/home/data/models/categories_response/category_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_data/test_data.dart';
import '../../../../helpers/test_data/test_json.dart';

void main() {
  group('CartProductModel', () {
    group('fromJson', () {
      test('success', () {
        final result = CartProductModel.fromJson(
          TestJson.cartProductSuccessResponse,
        );
        expect(result, isA<CartProductModel>());
        expect(result.id, equals(TestConstants.tProductId));
        expect(result.title, equals(TestConstants.tProductTitle));
        expect(result.category, isA<CategoryModel>());
        expect(result.brand, isA<BrandModel>());
      });
    });
    group('equatable', () {
      test('Two instance identical', () {
        final a = CartProductModel.fromJson(
          TestJson.cartProductSuccessResponse,
        );
        final b = CartProductModel.fromJson(
          TestJson.cartProductSuccessResponse,
        );
        expect(a, equals(b));
        expect(a.hashCode, equals(b.hashCode));
      });

      test('props contain 7 elements', () {
        final result = CartProductModel.fromJson(
          TestJson.cartProductSuccessResponse,
        );
        expect(result.props, hasLength(7));
      });
    });
  });
}
