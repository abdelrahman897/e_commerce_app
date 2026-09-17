// 📁 test/helpers/test_data.dart
//
// المرجع الوحيد لكل الـ fixtures في المشروع.
// أي تغيير في الـ entities أو الـ models → يتعدّل هنا فقط.

import 'dart:convert';
import 'dart:io';

// ── Raw JSON Loaders ─────────────────────────────────────────────────────────
// بيقرأ من fixtures/ الحقيقية — نفس الـ JSON اللي بيجي من الـ API

Map<String, dynamic> readFixture(String fileName) {
  final file = File('test/fixtures/$fileName');
  return json.decode(file.readAsStringSync()) as Map<String, dynamic>;
}

// ── Inline JSON Maps ─────────────────────────────────────────────────────────
// للحالات اللي بنحتاج فيها variation سريعة من غير ملف خارجي

class TestJson {
  TestJson._();

  static Map<String, dynamic> get signInSuccess => {
        'message': 'Login successful',
        'user': {
          'name': 'Ahmed Ali',
          'email': 'ahmed@test.com',
          'role': 'user',
        },
        'token': 'test_token_123',
        'status_msg': null,
      };

  static Map<String, dynamic> get signInNoToken => {
        'message': 'OTP sent',
        'user': null,
        'token': null,
        'statusMsg': 'pending',
      };

  static Map<String, dynamic> get signUpSuccess => {
        'message': 'Registration successful',
        'user': {
          'name': 'Ahmed Ali',
          'email': 'ahmed@test.com',
          'role': 'user',
        },
        'token': 'test_token_456',
        'status_msg': null,
      };

  static Map<String, dynamic> get forgetPasswordSuccess => {
        'message': 'OTP sent to your email',
        'user': null,
        'token': null,
        'status_msg': null,
      };

  static Map<String, dynamic> get addressSingle => {
        'status': 'success',
        'message': 'Address retrieved',
        'data': [
          {
            'id': 'addr_1',
            'name': 'Home',
            'details': '123 Main St',
            'city': 'Cairo',
          },
        ],
      };

  static Map<String, dynamic> get addressMultiple => {
        'status': 'success',
        'message': 'Addresses retrieved',
        'data': [
          {
            'id': 'addr_1',
            'name': 'Home',
            'details': '123 Main St',
            'city': 'Cairo',
          },
          {
            'id': 'addr_2',
            'name': 'Work',
            'details': '456 Office Rd',
            'city': 'Giza',
          },
        ],
      };

  static Map<String, dynamic> get addressEmpty => {
        'status': 'success',
        'message': 'No addresses found',
        'data': <dynamic>[],
      };

  static Map<String, dynamic> get updateUserSuccess => {
        'message': 'Profile updated',
        'user': {
          'name': 'Ahmed Updated',
          'email': 'ahmed@test.com',
          'role': 'user',
        },
        'token': 'new_token_789',
        'status_msg': null,
      };
}

// ── Params ───────────────────────────────────────────────────────────────────
// مش بنعمل import هنا عشان test_data مش المفروض يعرف عن الـ app code
// الـ params بتتعرّف في كل test file بنفسها — ده intentional
// الثوابت دي بس للـ raw values اللي بتتكرر

class TestConstants {
  TestConstants._();

  static const String tEmail = 'ahmed@test.com';
  static const String tPassword = 'pass123';
  static const String tName = 'Ahmed Ali';
  static const String tPhone = '01012345678';
  static const String tToken = 'test_token_123';
  static const String tNewToken = 'new_token_789';
  static const String tRole = 'user';

  static const String tAddressId = 'addr_1';
  static const String tAddressName = 'Home';
  static const String tAddressDetails = '123 Main St';
  static const String tAddressCity = 'Cairo';

  static const String tGoogleId = 'google_uid_1';
  static const String tGoogleName = 'Ahmed Google';
  static const String tGoogleEmail = 'ahmed@gmail.com';
  static const String tGoogleToken = 'google_id_token_xyz';
}
