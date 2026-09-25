import 'package:e_commerce_app/features/authentication/data/models/authentication_user_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_data/test_data.dart';
import '../../../../helpers/test_data/test_json.dart';

void main() {
  group('AuthenticationUserModel', () {
    // fromJson
    group('fromJson', () {
      test("parce is correctly and user, token is exist", () {
        final result = AuthenticatedUserModel.fromJson(
          TestJson.authenticationSuccess,
        );
        expect(result.message, equals(TestConstants.tAuthSuccess));
        expect(result.user, isNotNull);
        expect(result.user!.name, equals(TestConstants.tName));
        expect(result.user!.email, equals(TestConstants.tEmail));
        expect(result.user!.role, equals(TestConstants.tRole));
        expect(result.token, equals(TestConstants.tToken));
        expect(result.statusMsg, isNull);
      });
      test("parce is correctly and user, token is null", () {
        final result = AuthenticatedUserModel.fromJson(
          TestJson.authenticationWithNoToken,
        );
        expect(result.message, equals('OTP sent'));
        expect(result.user, isNull);
        expect(result.token, isNull);
        expect(result.statusMsg, equals('pending'));
      });
    });
    group('equatable', () {
      test('Two instance identical', () {
        final a = AuthenticatedUserModel.fromJson(
          TestJson.authenticationSuccess,
        );
        final b = AuthenticatedUserModel.fromJson(
          TestJson.authenticationSuccess,
        );
        expect(a, equals(b));
        expect(a.hashCode, equals(b.hashCode));
      });

      test('model with token not equal model without token', () {
        final modelWithToken = AuthenticatedUserModel.fromJson(
          TestJson.authenticationSuccess,
        );
        final modelWithoutToken = AuthenticatedUserModel.fromJson(
          TestJson.authenticationWithNoToken,
        );
        expect(modelWithToken, isNot(equals(modelWithoutToken)));
      });

      test('props contain 4 elements message, user, token, stausMsg', () {
        final a = AuthenticatedUserModel.fromJson(
          TestJson.authenticationSuccess,
        );
        expect(a.props, hasLength(4));
      });
    });
  });
}
