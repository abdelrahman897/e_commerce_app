// 📁 test/features/authentication/presentation/bloc/authentication_bloc_test.dart

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failures.dart';
import 'package:e_commerce_app/core/params/params.dart';

import 'package:e_commerce_app/features/authentication/domain/entities/user.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/user_google.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/address.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/address_item_data.dart';
import 'package:e_commerce_app/features/authentication/presentation/manager/authentication_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mocks/mock_auth.mocks.dart';
import '../../../../helpers/test_data/test_data.dart';


class _InMemoryStorage extends Storage {
  final Map<String, dynamic> _storage = {};

  @override
  Future<void> write(String key, dynamic value) async {
    _storage[key] = value;
  }

  @override
  dynamic read(String key) {
    return _storage[key];
  }

  @override
  Future<void> delete(String key) async {
    _storage.remove(key);
  }

  @override
  Future<void> clear() async {
    _storage.clear();
  }

  @override
  Future<void> close() async {}
}

void main() {
  late AuthenticationBloc bloc;
  late MockUserSignIn mockSignIn;
  late MockUserSignUp mockSignUp;
  late MockUserForgetPassword mockForgetPassword;
  late MockUserSignInOrSignUpWithGoogle mockGoogleSignIn;
  late MockAddAddress mockAddAddress;
  late MockDeleteAddress mockDeleteAddress;
  late MockUserUpdateData mockUpdateData;
  late MockUserSignOut mockSignOut;
  late MockProfileCacheService mockProfileCacheService;

  setUpAll(() {
    HydratedBloc.storage = _InMemoryStorage();
  });

  // ── Fixtures ───────────────────────────────────────────────────────────────
  const tUser = User(
    name: TestConstants.tName,
    email: TestConstants.tEmail,
    role: TestConstants.tRole,
  );
  const tUserGoogle = UserGoogle(
    id: TestConstants.tGoogleId,
    name: TestConstants.tGoogleName,
    email: TestConstants.tGoogleEmail,
    phoneNumber: null,
  );

  // ── Params ─────────────────────────────────────────────────────────────────
  const tSignInParams = SignInParams(
    email: TestConstants.tEmail,
    password: TestConstants.tPassword,
  );
  const tSignUpParams = SignUpParams(
    name: TestConstants.tName,
    email: TestConstants.tEmail,
    phone: TestConstants.tPhone,
    password: TestConstants.tPassword,
    rePassword: TestConstants.tPassword,
  );
  const tForgetParams = ForgetPasswordParams(email: TestConstants.tEmail);
  const tAddressParams = AddressParams(
    userId: TestConstants.tId,
    name: TestConstants.tAddressName,
    details: TestConstants.tAddressDetails,
    city: TestConstants.tAddressCity,
  );
  

  setUp(() {
    mockSignIn = MockUserSignIn();
    mockSignUp = MockUserSignUp();
    mockForgetPassword = MockUserForgetPassword();
    mockGoogleSignIn = MockUserSignInOrSignUpWithGoogle();
    mockAddAddress = MockAddAddress();
    mockDeleteAddress = MockDeleteAddress();
    mockUpdateData = MockUserUpdateData();
    mockSignOut = MockUserSignOut();
    mockProfileCacheService = MockProfileCacheService();
    when(
      mockProfileCacheService.getCachedProfile(),
    ).thenAnswer((_) => Future.value(null));
    when(
      mockProfileCacheService.saveData(profile: anyNamed('profile')),
    ).thenAnswer((_) => Future.value());
    when(
      mockProfileCacheService.clearField(key: anyNamed('key')),
    ).thenAnswer((_) => Future.value());

    bloc = AuthenticationBloc(
      userSignIn: mockSignIn,
      userSignUp: mockSignUp,
      userForgetPassword: mockForgetPassword,
      userSignInOrSignUpWithGoogle: mockGoogleSignIn,
      deleteAddress: mockDeleteAddress,
      addAddress: mockAddAddress,
      userUpdateData: mockUpdateData,
      profileCacheService: mockProfileCacheService,
      userSignOut: mockSignOut,
    );
  });

  tearDown(() => bloc.close());

  // ── SignInEvent ────────────────────────────────────────────────────────────
  group('SignInEvent', () {
    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationLoadingState, SignInSuccessState] on success',
      build: () {
        when(mockSignIn.call(params: tSignInParams))
            .thenAnswer((_) async => const Right(tUser));
        return bloc;
      },
      act: (b) => b.add(const SignInEvent(signInParams: tSignInParams)),
      expect: () => [
        isA<AuthenticationLoadingState>(),
        isA<SignInSuccessState>(),
      ],
      verify: (_) =>
          verify(mockSignIn.call(params: tSignInParams)).called(1),
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationLoadingState, AuthenticationFailureState] on ServerFailure',
      build: () {
        when(mockSignIn.call(params: tSignInParams)).thenAnswer(
          (_) async => const Left(
            ServerFailure(statusCode: 401, message: 'Invalid credentials'),
          ),
        );
        return bloc;
      },
      act: (b) => b.add(const SignInEvent(signInParams: tSignInParams)),
      expect: () => [
        isA<AuthenticationLoadingState>(),
        isA<AuthenticationFailureState>(),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationLoadingState, AuthenticationFailureState] on no internet',
      build: () {
        when(mockSignIn.call(params: tSignInParams)).thenAnswer(
          (_) async => const Left(ServerFailure.noInternet()),
        );
        return bloc;
      },
      act: (b) => b.add(const SignInEvent(signInParams: tSignInParams)),
      expect: () => [
        isA<AuthenticationLoadingState>(),
        isA<AuthenticationFailureState>(),
      ],
    );
  });

  // ── SignUpEvent ────────────────────────────────────────────────────────────
  group('SignUpEvent', () {
    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationLoadingState, SignUpSuccessState] on success',
      build: () {
        when(mockSignUp.call(params: tSignUpParams))
            .thenAnswer((_) async => const Right(tUser));
        return bloc;
      },
      act: (b) => b.add(const SignUpEvent(signUpParams: tSignUpParams)),
      expect: () => [
        isA<AuthenticationLoadingState>(),
        isA<SignUpSuccessState>(),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationLoadingState, AuthenticationFailureState] on email already registered',
      build: () {
        when(mockSignUp.call(params: tSignUpParams)).thenAnswer(
          (_) async => const Left(
            ServerFailure(statusCode: 400, message: 'Email already registered'),
          ),
        );
        return bloc;
      },
      act: (b) => b.add(const SignUpEvent(signUpParams: tSignUpParams)),
      expect: () => [
        isA<AuthenticationLoadingState>(),
        isA<AuthenticationFailureState>(),
      ],
    );
  });

  // ── ForgetPasswordEvent ────────────────────────────────────────────────────
  group('ForgetPasswordEvent', () {
    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationLoadingState, ForgetPasswordSuccessState] on success',
      build: () {
        when(mockForgetPassword.call(params: tForgetParams))
            .thenAnswer((_) async => const Right(null));
        return bloc;
      },
      act: (b) => b.add(const ForgetPasswordEvent(forgetPasswordParams: tForgetParams)),
      expect: () => [
        isA<AuthenticationLoadingState>(),
        isA<ForgetPasswordSuccessState>(),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationLoadingState, AuthenticationFailureState] on email not found',
      build: () {
        when(mockForgetPassword.call(params: tForgetParams)).thenAnswer(
          (_) async => const Left(
            ServerFailure(statusCode: 404, message: 'Email not found'),
          ),
        );
        return bloc;
      },
      act: (b) => b.add(const ForgetPasswordEvent(forgetPasswordParams: tForgetParams)),
      expect: () => [
        isA<AuthenticationLoadingState>(),
        isA<AuthenticationFailureState>(),
      ],
    );
  });

  // ── SignInOrSignUpEvent (Google) ───────────────────────────────────────────
  group('SignInOrSignUpEvent', () {
    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationLoadingState, SignInOrSignUpWithGoogleSuccessState] on success',
      build: () {
        when(mockGoogleSignIn.call())
            .thenAnswer((_) async => const Right(tUserGoogle));
        return bloc;
      },
      act: (b) => b.add(const SignInOrSignUpEvent()),
      expect: () => [
        isA<AuthenticationLoadingState>(),
        isA<SignInOrSignUpWithGoogleSuccessState>(),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationLoadingState, AuthenticationFailureState] on user cancels',
      build: () {
        when(mockGoogleSignIn.call()).thenAnswer(
          (_) async => const Left(
            ServerFailure(statusCode: 401, message: 'Sign-in cancelled'),
          ),
        );
        return bloc;
      },
      act: (b) => b.add(const SignInOrSignUpEvent()),
      expect: () => [
        isA<AuthenticationLoadingState>(),
        isA<AuthenticationFailureState>(),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationLoadingState, AuthenticationFailureState] on no internet',
      build: () {
        when(mockGoogleSignIn.call()).thenAnswer(
          (_) async => const Left(ServerFailure.noInternet()),
        );
        return bloc;
      },
      act: (b) => b.add(const SignInOrSignUpEvent()),
      expect: () => [
        isA<AuthenticationLoadingState>(),
        isA<AuthenticationFailureState>(),
      ],
    );
  });

  // ── AddAddressEvent ────────────────────────────────────────────────────────
  group('AddAddressEvent', () {
    const tAddress = Address(
      status: TestConstants.tStatus,
      message: TestConstants.tAddressSuccessMessage,
      addresses: [
        AddressItemData(
          id: TestConstants.tId,
          name: TestConstants.tAddressName,
          details: TestConstants.tAddressDetails,
          city: TestConstants.tAddressCity,
        ),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationLoadingState, UpdateProfileSuccessState] on success',
      build: () {
        when(mockAddAddress.call(params: tAddressParams))
            .thenAnswer((_) async => const Right(tAddress));
        return bloc;
      },
      act: (b) => b.add(const AddAddressEvent(addressParams: tAddressParams)),
      expect: () => [
        isA<AuthenticationLoadingState>(),
        isA<UpdateProfileSuccessState>(),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationLoadingState, AuthenticationFailureState] on failure',
      build: () {
        when(mockAddAddress.call(params: tAddressParams)).thenAnswer(
          (_) async => const Left(
            ServerFailure(statusCode: 400, message: 'Address limit reached'),
          ),
        );
        return bloc;
      },
      act: (b) => b.add(const AddAddressEvent(addressParams: tAddressParams)),
      expect: () => [
        isA<AuthenticationLoadingState>(),
        isA<AuthenticationFailureState>(),
      ],
    );
  });

  // ── DeleteAddressEvent ─────────────────────────────────────────────────────
  group('DeleteAddressEvent', () {
    const tDeleteParams = AddressParams(userId: TestConstants.tId);

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationLoadingState, DeleteAddressSuccessState] on success',
      build: () {
        when(mockDeleteAddress.call(params: tDeleteParams))
            .thenAnswer((_) async => const Right(null));
        return bloc;
      },
      act: (b) => b.add(const DeleteAddressEvent(addressParams: tDeleteParams)),
      expect: () => [
        isA<AuthenticationLoadingState>(),
        isA<DeleteAddressSuccessState>(),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationLoadingState, AuthenticationFailureState] on address not found',
      build: () {
        when(mockDeleteAddress.call(params: tDeleteParams)).thenAnswer(
          (_) async => const Left(
            ServerFailure(statusCode: 404, message: 'Address not found'),
          ),
        );
        return bloc;
      },
      act: (b) => b.add(const DeleteAddressEvent(addressParams: tDeleteParams)),
      expect: () => [
        isA<AuthenticationLoadingState>(),
        isA<AuthenticationFailureState>(),
      ],
    );
  });
}