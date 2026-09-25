import 'package:e_commerce_app/features/checkout/data/mappers/payment_mapper.dart';
import 'package:e_commerce_app/features/checkout/domain/entities/payment.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_data/test_data.dart';
import '../../../../helpers/test_data/test_models.dart';

void main() {
  test('PaymentModel transform to Payment is correctly.', () {
    final result = TestModels.tPaymentModel.toEntity;
    expect(result, isA<Payment>());
    expect(result.clientSecret, equals(TestConstants.tClientSecret));
  });
}
