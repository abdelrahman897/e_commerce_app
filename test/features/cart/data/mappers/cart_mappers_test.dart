import 'package:e_commerce_app/features/cart/data/mappers/cart_mappers.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_item_data.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_data/test_data.dart';
import '../../../../helpers/test_data/test_models.dart';

void main() {
  test('CartModel transform to Cart is correctly.', () {
    final result = TestModels.tCartModel.toEntity;
    expect(result, isA<Cart>());
    expect(result.totalCartPrice, equals(TestConstants.tTotalCartPrice));
    expect(result.items, isNotNull);
    expect(result.items, isNotEmpty);
    expect(result.items.first, isA<CartItemData>());
  });
}
