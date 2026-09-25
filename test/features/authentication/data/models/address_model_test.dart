import 'package:e_commerce_app/features/authentication/data/models/address_model.dart';
import 'package:e_commerce_app/features/authentication/data/models/sub_models/address_item_data_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_data/test_json.dart';

void main() {
  group('Address Model', () {
    group('fromJson', () {
      test('success', () {
        final result = AddressModel.fromJson(TestJson.addressSuccessResponse);
        expect(result, isA<AddressModel>());
        expect(result.addresses, isNotNull);
        expect(result.addresses, isNotEmpty);
        expect(result.addresses.first, isA<AddressItemDataModel>());
      });
      test('empty success', () {
        final result = AddressModel.fromJson(
          TestJson.addressEmptySuccessResponse,
        );
        expect(result, isA<AddressModel>());
        expect(result.addresses, isEmpty);
      });
    });
    group('equatable', () {
      test('Two instance identical', () {
        final a = AddressModel.fromJson(TestJson.addressSuccessResponse);
        final b = AddressModel.fromJson(TestJson.addressSuccessResponse);
        expect(a, equals(b));
        expect(a.hashCode, equals(b.hashCode));
      });

      test('props contain 3 elements status, message, addresses', () {
        final result = AddressModel.fromJson(TestJson.addressSuccessResponse);
        expect(result.props, hasLength(3));
      });
    });
  });
}
