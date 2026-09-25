import 'package:e_commerce_app/features/products/data/mappers/products_mappers.dart';
import 'package:e_commerce_app/features/products/domain/entities/products.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_data/test_models.dart';

void main() {
  group('ProductsMappers', () {
    test('ProductsModel toEntity maps correctly to Products', () {
      final model = TestModels.tProductsModel;
      final entity = model.toEntity;
      expect(entity, isA<Products>());
      expect(entity.products, hasLength(1));
      expect(entity.metadata.currentPage, equals(1));
      expect(entity.products.first.id, equals(model.products.first.id));
      expect(entity.products.first.title, equals(model.products.first.title));
      expect(
        entity.products.first.description,
        equals(model.products.first.description),
      );
      expect(entity.products.first.price, equals(model.products.first.price));
      expect(
        entity.products.first.imageCoverUrl,
        equals(model.products.first.imageCoverUrl),
      );
      expect(
        entity.products.first.ratingsAverage,
        equals(model.products.first.ratingsAverage),
      );
    });
  });
}
