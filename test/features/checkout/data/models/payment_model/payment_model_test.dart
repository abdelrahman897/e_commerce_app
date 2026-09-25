import 'package:e_commerce_app/features/checkout/data/models/payment_model/payment_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/test_data/test_data.dart';
import '../../../../../helpers/test_data/test_json.dart';

void main() {
  group('PaymentModel', () {
    group('fromJson', () {
      test('parce is correctly and clientSecret is exist', () {
        final result = PaymentModel.fromJson(TestJson.paymentSuccessResponse);
        expect(result.clientSecret, equals(TestConstants.tClientSecret));
        expect(result.id, equals('pi_123'));
        expect(result.amount, equals(10000));
        expect(result.currency, equals(TestConstants.tCurrency));
        expect(result.status, equals('succeeded'));
      });
    });
  });
}
