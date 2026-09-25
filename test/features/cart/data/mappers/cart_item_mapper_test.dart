import 'package:e_commerce_app/features/cart/data/mappers/cart_item_mapper.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_item_data.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_product.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_data/test_data.dart';
import '../../../../helpers/test_data/test_models.dart';

void main() {
  test('CartItemModel transform to CartItemData is correctly.', () {
    final result = TestModels.tCartItemModel.toEntity;
    expect(result, isA<CartItemData>());
    expect(result.count, equals(TestConstants.tCount));
    expect(result.price, equals(TestConstants.tPrice));
    expect(result.cartProduct, isA<CartProduct>());
    expect(result.cartProduct.id, equals(TestConstants.tProductId));
  });
}
