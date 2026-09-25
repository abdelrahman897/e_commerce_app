import 'package:e_commerce_app/features/authentication/data/mappers/address_mapper.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/address_item_data.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_data/test_data.dart';
import '../../../../helpers/test_data/test_models.dart';

void main() {
  test('AddressModel transform to Address is correctly.', () {
    final result = TestModels.tAddressModelResponse.toEntity;
    expect(result.status, equals(TestConstants.tStatus));
    expect(result.message, equals(TestConstants.tAddressSuccessMessage));
    expect(result.addresses, isNotNull);
    expect(result.addresses, isNotEmpty);
    expect(result.addresses.first, isA<AddressItemData>());
  });
}
