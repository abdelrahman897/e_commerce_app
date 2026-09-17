import 'package:e_commerce_app/features/checkout/domain/usecases/create_payment_intent.dart';
import 'package:e_commerce_app/features/checkout/presentation/manager/payment_bloc.dart';

import '../mocks/mock_checkout.mocks.dart';
import 'base_test_injection.dart';

class TestPaymentInjection {
  static late MockPaymentBloc mockPaymentBloc;
  static late MockStripe mockStripe;
  static late MockCreatePaymentIntent mockCreatePaymentIntent;
  static void register() {
    mockPaymentBloc = MockPaymentBloc();
    mockStripe = MockStripe();
    mockCreatePaymentIntent = MockCreatePaymentIntent();
    testGetIt.registerLazySingleton<CreatePaymentIntent>(
      () => mockCreatePaymentIntent,
    );
    testGetIt.registerFactory<PaymentBloc>(
      () => PaymentBloc(
        createPaymentIntent: mockCreatePaymentIntent,
        stripe: mockStripe,
      ),
    );
  }
}
