import 'package:e_commerce_app/features/authentication/data/mappers/address_item_data_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_data/test_data.dart';
import '../../../../helpers/test_data/test_models.dart';

void main() {
  test('AddressItemDataModel transform to User is correctly.', () {
    final result = TestModels.tAddressItemDataResponse.toEntity;
    expect(result.id, equals(TestConstants.tId));
    expect(result.name, equals(TestConstants.tAddressName));
    expect(result.city, equals(TestConstants.tAddressCity));
    expect(result.details, equals(TestConstants.tAddressDetails));
  });
}
