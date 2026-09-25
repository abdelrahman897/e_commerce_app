import 'package:e_commerce_app/features/products/data/models/products_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_data/test_json.dart';

void main() {
  group('ProductsModel', () {
    group('fromJson', () {
      test('parses correctly with results, metadata, and data', () {
        final result = ProductsModel.fromJson(
          TestJson.productsSuccessResponse,
        );
        expect(result.results, equals(1));
        expect(result.metadata.currentPage, equals(1));
        expect(result.metadata.numberOfPages, equals(1));
        expect(result.metadata.limit, equals(20));
        expect(result.metadata.nextPage, isNull);
        expect(result.metadata.prevPage, isNull);
        expect(result.products, hasLength(1));
      });

      test('parses empty data correctly', () {
        final result = ProductsModel.fromJson(
          TestJson.productsEmptyResponse,
        );
        expect(result.results, equals(0));
        expect(result.products, isEmpty);
      });

      test('parses multiple page metadata correctly', () {
        final result = ProductsModel.fromJson(
          TestJson.productsMultiplePageResponse,
        );
        expect(result.metadata.currentPage, equals(2));
        expect(result.metadata.numberOfPages, equals(3));
        expect(result.metadata.nextPage, equals(3));
        expect(result.metadata.prevPage, equals(1));
      });
    });

    group('equatable', () {
      test('Two instances identical', () {
        final a = ProductsModel.fromJson(
          TestJson.productsSuccessResponse,
        );
        final b = ProductsModel.fromJson(
          TestJson.productsSuccessResponse,
        );
        expect(a, equals(b));
        expect(a.hashCode, equals(b.hashCode));
      });

      test('different results are not equal', () {
        final a = ProductsModel.fromJson(
          TestJson.productsSuccessResponse,
        );
        final b = ProductsModel.fromJson(
          TestJson.productsEmptyResponse,
        );
        expect(a, isNot(equals(b)));
      });

      test('props contain results, metadata, products', () {
        final products = ProductsModel.fromJson(
          TestJson.productsSuccessResponse,
        );
        expect(products.props, hasLength(3));
      });
    });
  });
}
