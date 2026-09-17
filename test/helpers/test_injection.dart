// ─────────────────────────────────────────────────────────────────────────────
// test/helpers/test_injection.dart
//
// الغرض: يسجّل الـ mocks بدل الـ real implementations في getIt
//         ويعمل reset كامل بين كل test عشان كل test يبدأ نظيف.
//
// الاستخدام:
//   setUp(() => TestInjection.setUp());
//   tearDown(() => TestInjection.tearDown());
// ─────────────────────────────────────────────────────────────────────────────

import 'package:e_commerce_app/features/authentication/domain/usecases/add_address.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/delete_address.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_forget_password.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_sign_in.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_sign_in_or_sign_up_with_google.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_sign_up.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_update_data.dart';
import 'package:e_commerce_app/features/authentication/presentation/manager/authentication_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';

import 'mocks/mock_auth.mocks.dart';

// ─── تشغيل المولّد مرة واحدة فقط ─────────────────────────────────────────────
// flutter pub run build_runner build --delete-conflicting-outputs
// ─────────────────────────────────────────────────────────────────────────────
@GenerateMocks([
  UserSignIn,
  UserSignUp,
  UserForgetPassword,
  UserSignInOrSignUpWithGoogle,
  DeleteAddress,
  AddAddress,
  UserUpdateData,
  AuthenticationBloc,
])
// ─── Singleton للـ GetIt المخصص للـ tests ────────────────────────────────────
final GetIt testGetIt = GetIt.instance;

class TestInjection {
  // ── الـ mocks الخاصة بالـ use cases ─────────────────────────────────────────
  static late MockUserSignIn mockUserSignIn;
  static late MockUserSignUp mockUserSignUp;
  static late MockUserForgetPassword mockUserForgetPassword;
  static late MockUserSignInOrSignUpWithGoogle mockUserSignInOrSignUpWithGoogle;
  static late MockDeleteAddress mockDeleteAddress;
  static late MockAddAddress mockAddAddress;
  static late MockUserUpdateData mockUserUpdateData;
  static late MockProfileCacheService mockProfileCacheService;
  static late MockUserSignOut mockUserSignOut;

  // ── الـ bloc mock لو محتجته مباشرةً ──────────────────────────────────────────
  static late MockAuthenticationBloc mockAuthenticationBloc;

  // ───────────────────────────────────────────────────────────────────────────
  /// استدعيه في setUp() — يعمل reset ويسجّل كل الـ mocks من جديد
  // ───────────────────────────────────────────────────────────────────────────
  static Future<void> setUp() async {
    // 1. reset كامل لـ getIt عشان نبدأ نظيف
    await testGetIt.reset(dispose: false);

    // 2. إنشاء الـ mocks
    mockUserSignIn = MockUserSignIn();
    mockUserSignUp = MockUserSignUp();
    mockUserForgetPassword = MockUserForgetPassword();
    mockUserSignInOrSignUpWithGoogle = MockUserSignInOrSignUpWithGoogle();
    mockDeleteAddress = MockDeleteAddress();
    mockAddAddress = MockAddAddress();
    mockUserUpdateData = MockUserUpdateData();
    mockAuthenticationBloc = MockAuthenticationBloc();
    mockProfileCacheService = MockProfileCacheService();
    mockUserSignOut = MockUserSignOut();

    // 3. تسجيل الـ use case mocks
    testGetIt
      ..registerFactory<UserSignIn>(() => mockUserSignIn)
      ..registerFactory<UserSignUp>(() => mockUserSignUp)
      ..registerFactory<UserForgetPassword>(() => mockUserForgetPassword)
      ..registerFactory<UserSignInOrSignUpWithGoogle>(
        () => mockUserSignInOrSignUpWithGoogle,
      )
      ..registerFactory<DeleteAddress>(() => mockDeleteAddress)
      ..registerFactory<AddAddress>(() => mockAddAddress)
      ..registerFactory<UserUpdateData>(() => mockUserUpdateData)
      ..registerFactory<UserUpdateData>(() => mockUserUpdateData)
      ..registerFactory<UserUpdateData>(() => mockUserUpdateData);

    // 4. تسجيل AuthenticationBloc بالـ mocks بدل الـ real use cases
    testGetIt.registerFactory<AuthenticationBloc>(
      () => AuthenticationBloc(
        userSignIn: mockUserSignIn,
        userSignUp: mockUserSignUp,
        userForgetPassword: mockUserForgetPassword,
        userSignInOrSignUpWithGoogle: mockUserSignInOrSignUpWithGoogle,
        deleteAddress: mockDeleteAddress,
        addAddress: mockAddAddress,
        userUpdateData: mockUserUpdateData,
        profileCacheService: mockProfileCacheService,
        userSignOut: mockUserSignOut,
      ),
    );
  }

  // ───────────────────────────────────────────────────────────────────────────
  /// استدعيه في tearDown() — ينظّف getIt بعد كل test
  // ───────────────────────────────────────────────────────────────────────────
  static Future<void> tearDown() async {
    await testGetIt.reset(dispose: false);
  }
}
