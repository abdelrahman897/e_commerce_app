import 'package:e_commerce_app/features/authentication/data/mappers/user_google_mapper.dart';
import 'package:test/test.dart';

import '../../../../helpers/test_data/test_data.dart';
import '../../../../helpers/test_data/test_models.dart';

void main() {
  test('UserGoogleModel transform to UserGoogle is correctly.', () {
    final result = TestModels.tGoogleUser.toEntity;
    expect(result.id, equals(TestConstants.tGoogleId));
    expect(result.name, equals(TestConstants.tGoogleName));
    expect(result.email, equals(TestConstants.tGoogleEmail));
    expect(result.phoneNumber, equals(TestConstants.tPhone));
  });
}
