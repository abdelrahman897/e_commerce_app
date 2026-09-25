// 📁 test/features/authentication/data/models/authenticated_user_model_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:e_commerce_app/features/authentication/data/models/authentication_user_model.dart';
import '../../../../helpers/test_data.dart';

void main() {
  group('AuthenticatedUserModel', () {
    // ── fromJson ────────────────────────────────────────────────────────────
    group('fromJson', () {
      test('يعمل parse صح مع user و token موجودين', () {
        final result = AuthenticatedUserModel.fromJson(TestJson.signInSuccess);

        expect(result.message, equals('Login successful'));
        expect(result.user, isNotNull);
        expect(result.user!.name, equals(TestConstants.tName));
        expect(result.user!.email, equals(TestConstants.tEmail));
        expect(result.user!.role, equals(TestConstants.tRole));
        expect(result.token, equals(TestConstants.tToken));
        expect(result.statusMsg, isNull);
      });

      test('يعمل parse صح لما user = null و token = null', () {
        final result = AuthenticatedUserModel.fromJson(TestJson.signInNoToken);

        expect(result.message, equals('OTP sent'));
        expect(result.user, isNull);
        expect(result.token, isNull);
        expect(result.statusMsg, equals('pending'));
      });

      test('يعمل parse صح من fixture file', () {
        final fromFile = readFixture('sign_in_success.json');
        final result = AuthenticatedUserModel.fromJson(fromFile);

        expect(result.token, equals(TestConstants.tToken));
        expect(result.user, isNotNull);
      });

      test('يقرأ sign_up fixture بنجاح', () {
        final fromFile = readFixture('sign_up_success.json');
        final result = AuthenticatedUserModel.fromJson(fromFile);

        expect(result.token, equals('test_token_456'));
        expect(result.message, equals('Registration successful'));
      });

      test('token موجود و statusMsg = null في الـ success response', () {
        final result = AuthenticatedUserModel.fromJson(TestJson.signInSuccess);

        expect(result.token, isNotNull);
        expect(result.statusMsg, isNull);
      });
    });

    // ── Equatable ───────────────────────────────────────────────────────────
    group('Equatable', () {
      test('نسختين متطابقتين → متساويتين', () {
        final a = AuthenticatedUserModel.fromJson(TestJson.signInSuccess);
        final b = AuthenticatedUserModel.fromJson(TestJson.signInSuccess);

        expect(a, equals(b));
        expect(a.hashCode, equals(b.hashCode));
      });

      test('model مع token ≠ model من غير token', () {
        final withToken = AuthenticatedUserModel.fromJson(TestJson.signInSuccess);
        final withoutToken = AuthenticatedUserModel.fromJson(TestJson.signInNoToken);

        expect(withToken, isNot(equals(withoutToken)));
      });

      test('props تشمل message + user + token + statusMsg', () {
        final model = AuthenticatedUserModel.fromJson(TestJson.signInSuccess);

        expect(model.props, hasLength(4));
      });
    });
  });
}
