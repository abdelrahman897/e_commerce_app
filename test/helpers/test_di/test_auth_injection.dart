// ─────────────────────────────────────────────────────────────────────────────
// test/helpers/features/auth_test_injection.dart
//
// المسؤولية: تسجيل mocks خاصة بـ authentication feature فقط
// ─────────────────────────────────────────────────────────────────────────────

import 'package:e_commerce_app/core/services/profile_cached_service.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/add_address.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/delete_address.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_forget_password.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_sign_in.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_sign_in_or_sign_up_with_google.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_sign_out.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_sign_up.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_update_data.dart';
import 'package:e_commerce_app/features/authentication/presentation/manager/authentication_bloc.dart';

import '../mocks/mock_auth.mocks.dart';
import 'base_test_injection.dart';


class AuthTestInjection {
  AuthTestInjection._(); // منع الـ instantiation

  // ── الـ mocks المتاحة للـ tests ──────────────────────────────────────────────
  static late MockUserSignIn mockUserSignIn;
  static late MockUserSignUp mockUserSignUp;
  static late MockUserForgetPassword mockUserForgetPassword;
  static late MockUserSignInOrSignUpWithGoogle mockSignInOrSignUpWithGoogle;
  static late MockDeleteAddress mockDeleteAddress;
  static late MockAddAddress mockAddAddress;
  static late MockUserUpdateData mockUserUpdateData;
  static late MockUserSignOut mockUserSignOut;
  static late MockProfileCacheService mockProfileCacheService;
  static late MockAuthenticationBloc mockAuthenticationBloc;

  // ───────────────────────────────────────────────────────────────────────────
  /// سجّل كل مشتركات الـ authentication في getIt
  /// لازم تستدعي BaseTestInjection.init() قبله
  // ───────────────────────────────────────────────────────────────────────────
  static void register() {
    // 1. إنشاء الـ mocks
    mockUserSignIn              = MockUserSignIn();
    mockUserSignUp              = MockUserSignUp();
    mockUserForgetPassword      = MockUserForgetPassword();
    mockSignInOrSignUpWithGoogle = MockUserSignInOrSignUpWithGoogle();
    mockDeleteAddress           = MockDeleteAddress();
    mockAddAddress              = MockAddAddress();
    mockUserUpdateData          = MockUserUpdateData();
    mockUserSignOut             = MockUserSignOut();
    mockProfileCacheService     = MockProfileCacheService();
    mockAuthenticationBloc      = MockAuthenticationBloc();

    // 2. تسجيل الـ use case mocks في getIt
    testGetIt
      ..registerFactory<UserSignIn>(() => mockUserSignIn)
      ..registerFactory<UserSignUp>(() => mockUserSignUp)
      ..registerFactory<UserForgetPassword>(() => mockUserForgetPassword)
      ..registerFactory<UserSignInOrSignUpWithGoogle>(
          () => mockSignInOrSignUpWithGoogle)
      ..registerFactory<DeleteAddress>(() => mockDeleteAddress)
      ..registerFactory<AddAddress>(() => mockAddAddress)
      ..registerFactory<UserUpdateData>(() => mockUserUpdateData)
      ..registerFactory<UserSignOut>(() => mockUserSignOut)
      ..registerFactory<ProfileCacheService>(() => mockProfileCacheService);

    // 3. تسجيل الـ Bloc بالـ mocks بدل الـ real use cases
    testGetIt.registerFactory<AuthenticationBloc>(
      () => AuthenticationBloc(
        userSignIn:                  mockUserSignIn,
        userSignUp:                  mockUserSignUp,
        userForgetPassword:          mockUserForgetPassword,
        userSignInOrSignUpWithGoogle: mockSignInOrSignUpWithGoogle,
        deleteAddress:               mockDeleteAddress,
        addAddress:                  mockAddAddress,
        userUpdateData:              mockUserUpdateData,
        userSignOut:                 mockUserSignOut,
        profileCacheService:         mockProfileCacheService,
      ),
    );
  }
}