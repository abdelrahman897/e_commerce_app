import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract final class AppStrings {
  AppStrings._();
  static const String appTitle = 'E-commerce';
  static const String delete = 'Delete';
  static const String addToCart = 'Add to Cart';
  static const String noRouteFound = 'No Route Found';
  static const String searchHint = 'what do you search for?';
  static const String inFuture = 'in the future';
  static const String inFutureArabic = 'في المستقبل';
  static const String yesterday = 'Yesterday';
  static const String yesterdayArabic = 'أمس';
  static const String loginSuccessMessage = 'Login Successful! Welcome back.';
  static const String signUpSuccessMessage = 'Sign Up Successful!';
  static const String signOutSuccessMessage = 'Sign Out Successful!';
  static const String forgetPasswordSuccessMessage = 'verify Email Successful!';
  static const String soldParam = '-sold';
  static const String failureMessage =
      'Authentication Failed. Please check your credentials.';
  static const String searchHeroTag = 'search_bar_tag';
  static const String addToCartSuccessMessage =
      'add product to cart is Successfully.';
  static const String deletefromCartSuccessMessage =
      'delete product from cart is Successfully.';
  static const String updateProfileSuccessMessage =
      'Update Profile is Successfully.';
  static const String paymentSuccessMessage = "Payment done successfully.";
  static const String merchantName = "vision";
  static const String whishlistAddedMessage =
      "Add Product To Whishlist Is Successfully.";
  static const String whishlistDeletedMessage =
      "Delete Product Form Whishlist Is Successfully.";
}

abstract final class HiveBoxesConstant {
  HiveBoxesConstant._();
  static const String wishlistBox = 'wishlist';
  static const String profileBox = 'profile';
}

abstract final class ThemeConstants {
  ThemeConstants._();
  static const String themePreferenceKey = 'app_theme_mode';
  static const String lightModeValue = 'light';
  static const String darkModeValue = 'dark';
}

abstract final class AppErrorMessages {
  AppErrorMessages._();
  static const String unauthorized = 'You are not authorized';
  static const String notFound = 'Resource not found';
  static const String noInternet = 'No internet connection';
  static const String timeout = 'Request timed out';
  static const String requestCancelled = 'Request was cancelled';
  static const String serverError = 'Server error occurred';
  static const String unknown = 'Unknown error occurred';
  static const String forbidden = 'You don\'t have permission';
  static const String badCertificate = 'SSL certificate error';
  static const String gatewayTimeout = 'Gateway timeout';
  static const String conflict = 'Conflict error';
  static const String cacheNotFound = 'Data not found in cache';
  static const String cacheReadError = 'Failed to read from cache';
  static const String cacheWriteError = 'Failed to write to cache';
  static const String cacheClearError =
      'Failed to clear token from secure storage';
  static const String cacheClearUnexpectedError =
      'Unexpected error while clearing token';
  static const String cacheSavedError =
      'Failed to save token to secure storage';
  static const String cacheUnexpectedSaveError =
      'Unexpected error while saving token';
  static const String cacheReadedError =
      'Failed to read token from secure storage';
  static const String cacheUnexpectedReadError =
      'Unexpected error while reading token';
  static const String googleSignInCancelled =
      'تم إلغاء تسجيل الدخول بواسطة المستخدم';
  static const String googleNoIdToken =
      'لم يتم الحصول على رمز المصادقة من Google';
  static const String googleNoUser = 'لم يتم إرجاع بيانات المستخدم من Firebase';
  static const String paymentCancelled = 'Payment was cancelled';
  static const String errorResponse = 'Unexpected response: user data missing';
}

abstract final class GoogleAuthErrorMessages {
  GoogleAuthErrorMessages._();
  static const String cancelledByUser = 'تم إلغاء تسجيل الدخول بواسطة المستخدم';
  static const String noIdToken = 'لم يتم الحصول على رمز المصادقة من Google';
  static const String noUserReturned =
      'لم يتم إرجاع بيانات المستخدم من Firebase';
  static const String firebaseAuthFailed = 'فشل التحقق مع Firebase';
}

abstract final class FontConstants {
  FontConstants._();
  static const String cairoFontFamily = 'Cairo';
}

abstract final class AppStorageKeys {
  AppStorageKeys._();
  static const String onboardingCompleted = 'completed';
  static const String profileKey = 'cached_profile';
  static const String name = 'name';
  static const String email = 'email';
  static const String phoneNumber = 'phoneNumber';
  static const String address = 'address';
  static const String id = 'id';
  static const String details = 'details';
  static const String city = 'city';
  static const String isSignIn = 'isSignIn';
}

abstract final class DesignSize {
  DesignSize._();
  static const Size kDesignSize = Size(360, 690);
}

abstract final class EnvKeys {
  EnvKeys._();
  static String get googleClientId => dotenv.env['SERVER_CLIENT_ID'] ?? '';
  static String get publishableKey => dotenv.env['PUBLISHABLE_KEY'] ?? '';
  static String get secretKey => dotenv.env['SECRET_KEY'] ?? '';
}

abstract final class AppConstants {
  AppConstants._();
  static const String unauthorizedText = 'UNAUTHORIZED';
  static const String notFoundText = 'NOT_FOUND';
  static const String noInternetText = 'NO_INTERNET';
  static const String timeOutText = 'TIMEOUT';
  static const String unknownText = 'UNKNOWN';
  static const String conflictText = 'CONFLICT';
  static const String forbiddenText = 'FORBIDDEN';
  static const String en = 'en';
  static const String ar = 'ar';
  static const String emptyDash = '—';
  static const String languageCode = 'languageCode';
  static const String themeMode = 'themeMode';
  static const String loading = 'Loading';
  static const String success = 'Success';
  static const String failure = 'Failure';
  static const String unknown = 'unknown';
  static const String googleCancelledText = 'GOOGLE_CANCELLED';
  static const String googleNoIdTokenText = 'GOOGLE_NO_ID_TOKEN';
  static const String googleNoUserText = 'GOOGLE_NO_USER';
  static const String defaultLimit = '10';
  static const String defaultCategoryLimit = '5';
  static const String defaultBrandLimit = '5';
  static const String firstPage = '1';
  static const String egyptcurrency = 'EGP';
  static const String fixedNumber = "*********2109";
  static const String cartItem = 'cartItem';
  static const String productCount = 'productCount';
  static const String categoryId = 'categoryId';
  static const String brandId = 'brandId';
}

abstract final class WidgetKeys {
  WidgetKeys._();
  static const String emailFormField = "email_text_form_field";
  static const String phoneFormField = "phone_text_form_field";
  static const String fullNameFormField = "full_name_text_form_field";
  static const String passwordFormField = "password_text_form_field";
  static const String rePasswordFormField = "re_password_text_form_field";
  static const String addressFormField = "address_text_form_field";
  static const String signUpElevatedButton = "sign_up_elevated_button";
  static const String signInElevatedButton = "sign_in_elevated_button";
  static const String forgetPasswordElevatedButton =
      "forget_password_elevated_button";
  static const String signUpWithGoogleElevatedButton =
      "sign_up_with_google_elevated_button";
  static const String signInWithGoogleElevatedButton =
      "sign_in_with_google_elevated_button";
  static const String updateProfileElevatedButton =
      "update_profile_elevated_button";
  static const String forgetPasswordTextButton = "forget_password_text_button";
  static const String signInTextButton = "sign_in_text_button";
  static const String signUpTextButton = "sign_up_text_button";
  static const String registerScrollView = "register_scroll_view";
}
