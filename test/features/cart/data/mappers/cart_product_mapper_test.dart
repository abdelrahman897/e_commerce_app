import 'package:e_commerce_app/features/cart/data/mappers/cart_product_mapper.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_product.dart';
import 'package:e_commerce_app/features/home/domain/entities/category/category.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_data/test_data.dart';
import '../../../../helpers/test_data/test_models.dart';

void main() {
  test('CartProductModel transform to CartProduct is correctly.', () {
    final result = TestModels.tCartProductModel.toEntity;
    expect(result, isA<CartProduct>());
    expect(result.id, equals(TestConstants.tProductId));
    expect(result.title, equals(TestConstants.tProductTitle));
    expect(result.imageCoverUrl, equals(TestConstants.tImageCoverUrl));
    expect(result.ratingsAverage, equals(TestConstants.tRatingsAverage));
    expect(result.category, isA<Category>());
    expect(result.category.id, equals(TestConstants.tCategoryId));
  });
}
