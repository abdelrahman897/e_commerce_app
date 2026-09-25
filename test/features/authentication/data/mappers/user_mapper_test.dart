import 'package:e_commerce_app/features/authentication/data/mappers/user_mapper.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_data/test_data.dart';
import '../../../../helpers/test_data/test_models.dart';

void main() {
  test('UserModel transform to User is correctly.', () {
    final User user = TestModels.tUserModel.toEntity;
    expect(user.name, equals(TestConstants.tName));
    expect(user.email, equals(TestConstants.tEmail));
    expect(user.role, equals(TestConstants.tRole));
  });
}
