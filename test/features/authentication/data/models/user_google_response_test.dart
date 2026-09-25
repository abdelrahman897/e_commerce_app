import 'package:e_commerce_app/features/authentication/data/models/sub_models/user_google_model.dart';
import 'package:e_commerce_app/features/authentication/data/models/user_google_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mocks/mock_auth.mocks.dart';
import '../../../../helpers/test_data/test_data.dart';

void main() {
  late MockUserInfo mockUserInfo;
  setUp(() {
    mockUserInfo = MockUserInfo();
    when(mockUserInfo.uid).thenReturn(TestConstants.tId);
    when(mockUserInfo.displayName).thenReturn(TestConstants.tName);
    when(mockUserInfo.email).thenReturn(TestConstants.tEmail);
    when(mockUserInfo.phoneNumber).thenReturn(TestConstants.tPhone);
  });
  group('UserGoogleResponse', () {
    group('fromFirebaseCredential', () {
      test('fromFirebaseCredential Success', () {
        final result = UserGoogleResponse.fromFirebaseCredential(
          userInfo: mockUserInfo,
          token: TestConstants.tToken,
        );
        expect(result, isA<UserGoogleResponse>());
        expect(result.token, equals(TestConstants.tToken));
        expect(result.userGoogle, isA<UserGoogleModel>());
      });
      test('with null', () {
        final result = UserGoogleModel.fromJson(mockUserInfo);
        expect(result.id, equals(TestConstants.tId));
        expect(result.name, equals(TestConstants.tName));
        expect(result.email, equals(TestConstants.tEmail));
        expect(result.phoneNumber, equals(TestConstants.tPhone));
      });
      test('يجب أن يتعامل بشكل صحيح مع القيم الـ Null', () {
        when(mockUserInfo.uid).thenReturn(null);
        when(mockUserInfo.displayName).thenReturn(null);
        when(mockUserInfo.email).thenReturn(null);
        when(mockUserInfo.phoneNumber).thenReturn(null);

        final result = UserGoogleModel.fromJson(mockUserInfo);

        expect(result.id, isNull);
        expect(result.name, isNull);
        expect(result.email, isNull);
        expect(result.phoneNumber, isNull);
      });
    });
    group('equatable', () {
      test('Two instance identical', () {
        final a = UserGoogleResponse.fromFirebaseCredential(
          userInfo: mockUserInfo,
          token: TestConstants.tToken,
        );
        final b = UserGoogleResponse.fromFirebaseCredential(
          userInfo: mockUserInfo,
          token: TestConstants.tToken,
        );
        expect(a, equals(b));
        expect(a.hashCode, equals(b.hashCode));
      });
      test('props contain 2 elements userGoogle, token', () {
        final result = UserGoogleResponse.fromFirebaseCredential(
          userInfo: mockUserInfo,
          token: TestConstants.tToken,
        );
        expect(result.props, hasLength(2));
      });
    });
  });
}
