import 'package:e_commerce_app/features/authentication/data/mappers/profile_google_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_data/test_data.dart';
import '../../../../helpers/test_data/test_entities.dart';

void main() {
  group('description', () {
    test('UserGoogle transform to Profile is correctly.', () {
      final result = TestEntities.tUserGoogle.toEntity;
      expect(result.email, equals(TestConstants.tGoogleEmail));
      expect(result.name, equals(TestConstants.tGoogleName));
      expect(result.phoneNumber, equals(TestConstants.tPhone));
    });
  });
}
