import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mock_auth.mocks.dart';

abstract class TestConnection {
  static void onLine(MockNetworkInfo mockNetworkInfo) =>
      when(mockNetworkInfo.isConnected).thenAnswer((_) => Future.value(true));

  static void offLine(MockNetworkInfo mockNetworkInfo) =>
      when(mockNetworkInfo.isConnected).thenAnswer((_) => Future.value(false));
}

abstract final class TestWidgetkeys {
  TestWidgetkeys._();
  static const Key kFullNameField = Key(WidgetKeys.fullNameFormField);
  static const Key kPhoneField = Key(WidgetKeys.phoneFormField);
  static const Key kEmailField = Key(WidgetKeys.emailFormField);
  static const Key kPasswordField = Key(WidgetKeys.passwordFormField);
  static const Key kRePasswordField = Key(WidgetKeys.rePasswordFormField);
  static const Key kSignUpButton = Key(WidgetKeys.signUpElevatedButton);
  static const Key kSignUpGoogleButton = Key(
    WidgetKeys.signUpWithGoogleElevatedButton,
  );
  static const Key kSignUpTextButton = Key(WidgetKeys.signUpTextButton);
  static const Key kRegisterScrollView = Key(WidgetKeys.registerScrollView);
}

abstract final class TestConstants {
  TestConstants._();
  static const String tAuthSuccess = 'Authentication successful';
  static const String tId = '1';
  static const String tStatus = 'Success';
  static const String tEmail = 'ahmed1234@gmail.com';
  static const String tPassword = 'Pass#123';
  static const String tName = 'Ahmed';
  static const String tPhone = '01012345678';
  static const String tToken = 'test_token_123';
  static const String tNewToken = 'new_token_789';
  static const String tRole = 'user';
  static const String tFailure = 'Failure';
  static const String tAddressName = 'Home';
  static const String tAddressDetails = '123 Main St';
  static const String tAddressCity = 'Cairo';
  static const String tAddressSuccessMessage = 'Addresses fetched successfully';
  static const String tAddressEmptySuccessMessage = 'No addresses found';
  static const String tGoogleId = 'google_uid_1';
  static const String tGoogleName = 'Ahmed Google';
  static const String tGoogleEmail = 'ahmed@gmail.com';
  static const String tGoogleToken = 'google_id_token_xyz';

  static const String tExcpectedMessageLeft = 'Expected Left';
  static const String tServerFailureMessage = 'Invalid credentials';

  static const String tCartStatus = 'success';
  static const String tCartId = 'cart_1';
  static const String tCartOwnerId = 'user_1';
  static const String tProductId = 'product_1';
  static const String tCartItemId = 'cart_item_1';
  static const String tProductTitle = 'Test Product';
  static const String tImageCoverUrl = 'https://example.com/image.jpg';
  static const String tCategoryId = 'cat_1';
  static const String tCategoryName = 'Electronics';
  static const String tCategorySlug = 'electronics';
  static const String tCategoryImageUrl = 'https://example.com/cat.jpg';
  static const String tBrandId = 'brand_1';
  static const String tBrandName = 'Test Brand';
  static const String tBrandSlug = 'test-brand';
  static const String tBrandImageUrl = 'https://example.com/brand.jpg';
  static const double tRatingsAverage = 4.5;
  static const int tCount = 2;
  static const int tPrice = 200;
  static const int tTotalCartPrice = 400;
  static const int tQuantity = 3;
  static const int tNumOfCartItems = 1;
  static const int tProductQuantity = 100;

  // ─── WISHLIST CONSTANTS ──────────────────────────────────────────────────
  static const String tWishlistStatus = 'success';
  static const int tWishlistCount = 1;
  static const int tProductSold = 50;
  static const int tProductRatingsQuantity = 100;
  static const List<String> tProductImagesUrl = [
    'https://example.com/img1.jpg',
  ];
  static const String tProductSlug = 'test-product';
  static final DateTime tProductCreatedAt = DateTime.parse('2024-01-01T00:00:00.000Z');
  static final DateTime tProductUpdatedAt = DateTime.parse('2024-01-02T00:00:00.000Z');

  // ─── PAYMENT CONSTANTS ───────────────────────────────────────────────────
  static const String tClientSecret = 'pi_secret_123_test';
  static const int tPaymentAmount = 100;
  static const String tCurrency = 'egp';
}
