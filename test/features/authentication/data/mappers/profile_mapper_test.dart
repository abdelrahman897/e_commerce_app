import 'package:e_commerce_app/features/authentication/data/mappers/profile_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_data/test_data.dart';
import '../../../../helpers/test_data/test_params.dart';

void main() {
  test('SignUpParams transform to Profile is correctly.', () {
    final result = TestParams.tSignUpParams.toEntity;
    expect(result.name, equals(TestConstants.tName));
    expect(result.email, equals(TestConstants.tEmail));
    expect(result.phoneNumber, equals(TestConstants.tPhone));
  });
}
