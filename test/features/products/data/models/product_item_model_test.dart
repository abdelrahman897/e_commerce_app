import 'package:e_commerce_app/features/products/data/models/product_item_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_data/test_data.dart';
import '../../../../helpers/test_data/test_json.dart';

void main() {
  group('ProductItemModel', () {
    group('fromJson', () {
      test('parses correctly with all fields', () {
        final result = ProductItemModel.fromJson(
          TestJson.productItemSuccessResponse,
        );
        expect(result.sold, equals(TestConstants.tProductSold));
        expect(result.imagesUrl, equals(TestConstants.tProductImagesUrl));
        expect(
          result.ratingsQuantity,
          equals(TestConstants.tProductRatingsQuantity),
        );
        expect(result.id, equals(TestConstants.tProductId));
        expect(result.title, equals(TestConstants.tProductTitle));
        expect(result.slug, equals(TestConstants.tProductSlug));
        expect(
          result.description,
          equals('Test product description'),
        );
        expect(result.quantity, equals(TestConstants.tProductQuantity));
        expect(result.price, equals(TestConstants.tPrice));
        expect(
          result.imageCoverUrl,
          equals(TestConstants.tImageCoverUrl),
        );
        expect(result.category.id, equals(TestConstants.tCategoryId));
        expect(result.category.name, equals(TestConstants.tCategoryName));
        expect(result.brand.id, equals(TestConstants.tBrandId));
        expect(result.brand.name, equals(TestConstants.tBrandName));
        expect(result.ratingsAverage, equals(TestConstants.tRatingsAverage));
        expect(result.createdAt, equals(TestConstants.tProductCreatedAt));
        expect(result.updatedAt, equals(TestConstants.tProductUpdatedAt));
        expect(result.priceAfterDiscount, equals(180));
      });

      test('parses optional fields as null when absent', () {
        final json = Map<String, dynamic>.from(
          TestJson.productItemSuccessResponse,
        );
        json.remove('priceAfterDiscount');
        json.remove('availableColors');
        json.remove('__v');
        final result = ProductItemModel.fromJson(json);
        expect(result.priceAfterDiscount, isNull);
        expect(result.availableColors, isNull);
        expect(result.v, isNull);
      });
    });

    group('equatable', () {
      test('Two instances identical', () {
        final a = ProductItemModel.fromJson(
          TestJson.productItemSuccessResponse,
        );
        final b = ProductItemModel.fromJson(
          TestJson.productItemSuccessResponse,
        );
        expect(a, equals(b));
        expect(a.hashCode, equals(b.hashCode));
      });

      test('different sold are not equal', () {
        final a = ProductItemModel.fromJson(
          TestJson.productItemSuccessResponse,
        );
        final b = ProductItemModel.fromJson(
          TestJson.productItemSuccessResponse,
        );
        expect(a, equals(b));
      });

      test('props have correct length', () {
        final a = ProductItemModel.fromJson(
          TestJson.productItemSuccessResponse,
        );
        expect(a.props, hasLength(18));
      });
    });
  });
}
