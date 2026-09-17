import 'package:e_commerce_app/core/params/params.dart';

import 'test_data.dart';

abstract class TestParams {
  static SignInParams get tSignInParams => const SignInParams(
    email: TestConstants.tEmail,
    password: TestConstants.tPassword,
  );

  static SignUpParams get tSignUpParams => const SignUpParams(
    name: TestConstants.tName,
    email: TestConstants.tEmail,
    phone: TestConstants.tPhone,
    password: TestConstants.tPassword,
    rePassword: TestConstants.tPassword,
  );
  static ForgetPasswordParams get tForgetPasswordParams =>
      const ForgetPasswordParams(email: TestConstants.tEmail);

  static UserUpdateDataParams get tUserUpdateDataParams =>
      const UserUpdateDataParams(
        email: TestConstants.tEmail,
        name: TestConstants.tName,
        phone: TestConstants.tPhone,
      );
  static AddressParams get tAddressParams => const AddressParams(
    userId: TestConstants.tId,
    name: TestConstants.tName,
    phone: TestConstants.tPhone,
    city: TestConstants.tAddressCity,
    details: TestConstants.tAddressDetails,
  );

  static CartParams get tCartParams =>
      const CartParams(cartProductId: TestConstants.tProductId);

  static CartParams get tCartParamsWithQuantity => const CartParams(
    cartProductId: TestConstants.tProductId,
    quantity: TestConstants.tQuantity,
  );

  static WishlistParams get tWishlistParams =>
      const WishlistParams(productId: TestConstants.tProductId);

  static ProductParams get tProductParams => const ProductParams(
    categoryId: TestConstants.tCategoryId,
    limit: '20',
    pageNumber: '1',
  );

  static ProductParams get tProductParamsSorted => const ProductParams(
    limit: '20',
    pageNumber: '1',
    soldParam: '-sold',
  );

  static PaymentParams get tPaymentParams => const PaymentParams(
    amount: TestConstants.tPaymentAmount,
    currency: TestConstants.tCurrency,
  );

}
