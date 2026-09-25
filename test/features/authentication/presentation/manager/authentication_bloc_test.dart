import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/features/authentication/presentation/manager/authentication_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mocks/mock_auth.mocks.dart';
import '../../../../helpers/test_data/test_entities.dart';
import '../../../../helpers/test_data/test_failures.dart';
import '../../../../helpers/test_data/test_params.dart';

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
  late AuthenticationBloc authBloc;
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
    authBloc = AuthenticationBloc(
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
  tearDown(() => authBloc.close());

  group('authentication bloc', () {
    group('SignIn Event', () {
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Loading, SignInSuccess] when sign in succeeds',
        build: () {
          when(
            mockSignIn(params: TestParams.tSignInParams),
          ).thenAnswer((_) => Future.value(Right(TestEntities.tUser)));
          return authBloc;
        },
        act: (bloc) =>
            bloc.add(SignInEvent(signInParams: TestParams.tSignInParams)),
        expect: () => [
          AuthenticationLoadingState(),
          SignInSuccessState(user: TestEntities.tUser),
        ],
        verify: (_) {
          verify(mockSignIn(params: TestParams.tSignInParams)).called(1);
        },
      );
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Loading, AuthenticationFailure] when sign in succeeds',
        build: () {
          when(
            mockSignIn(params: TestParams.tSignInParams),
          ).thenAnswer((_) => Future.value(left(TestFailures.tServerFailure)));
          return authBloc;
        },
        act: (bloc) =>
            bloc.add(SignInEvent(signInParams: TestParams.tSignInParams)),
        expect: () => [
          AuthenticationLoadingState(),
          AuthenticationFailureState(
            failureMessage: TestFailures.tServerFailure.message,
          ),
        ],
      );
    });
    group('SignUp Event', () {
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Loading, SignUpSuccess] when sign up succeeds',
        build: () {
          when(
            mockSignUp(params: TestParams.tSignUpParams),
          ).thenAnswer((_) => Future.value(Right(TestEntities.tUser)));
          return authBloc;
        },
        act: (bloc) =>
            bloc.add(SignUpEvent(signUpParams: TestParams.tSignUpParams)),
        expect: () => [
          AuthenticationLoadingState(),
          SignUpSuccessState(user: TestEntities.tUser),
        ],
        verify: (_) {
          verify(mockSignUp(params: TestParams.tSignUpParams)).called(1);
        },
      );
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Loading, AuthenticationFailure] when sign up succeeds',
        build: () {
          when(
            mockSignUp(params: TestParams.tSignUpParams),
          ).thenAnswer((_) => Future.value(left(TestFailures.tServerFailure)));
          return authBloc;
        },
        act: (bloc) =>
            bloc.add(SignUpEvent(signUpParams: TestParams.tSignUpParams)),
        expect: () => [
          AuthenticationLoadingState(),
          AuthenticationFailureState(
            failureMessage: TestFailures.tServerFailure.message,
          ),
        ],
      );
    });
    group('Forget Password Event', () {
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Loading, ForgetPasswordSuccess] when forget password succeeds',
        build: () {
          when(
            mockForgetPassword(params: TestParams.tForgetPasswordParams),
          ).thenAnswer((_) => Future.value(Right(null)));
          return authBloc;
        },
        act: (bloc) => bloc.add(
          ForgetPasswordEvent(
            forgetPasswordParams: TestParams.tForgetPasswordParams,
          ),
        ),
        expect: () => [
          AuthenticationLoadingState(),
          ForgetPasswordSuccessState(),
        ],
        verify: (_) {
          verify(
            mockForgetPassword(params: TestParams.tForgetPasswordParams),
          ).called(1);
        },
      );
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Loading, AuthenticationFailure] when forget password failure',
        build: () {
          when(
            mockForgetPassword(params: TestParams.tForgetPasswordParams),
          ).thenAnswer((_) => Future.value(left(TestFailures.tServerFailure)));
          return authBloc;
        },
        act: (bloc) => bloc.add(
          ForgetPasswordEvent(
            forgetPasswordParams: TestParams.tForgetPasswordParams,
          ),
        ),
        expect: () => [
          AuthenticationLoadingState(),
          AuthenticationFailureState(
            failureMessage: TestFailures.tServerFailure.message,
          ),
        ],
      );
    });
    group('Add Address Event', () {
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Loading, UpdateProfileSuccess] when addAddress succeeds',
        build: () {
          when(
            mockAddAddress(params: TestParams.tAddressParams),
          ).thenAnswer((_) => Future.value(Right(TestEntities.tAddress)));
          authBloc.profile = TestEntities.tProfile;
          return authBloc;
        },
        act: (bloc) =>
            bloc.add(AddAddressEvent(addressParams: TestParams.tAddressParams)),
        expect: () => [
          AuthenticationLoadingState(),
          UpdateProfileSuccessState(),
        ],
        verify: (_) {
          verify(mockAddAddress(params: TestParams.tAddressParams)).called(1);
        },
      );
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Loading, AuthenticationFailure] when addAddress succeeds',
        build: () {
          when(
            mockAddAddress(params: TestParams.tAddressParams),
          ).thenAnswer((_) => Future.value(left(TestFailures.tServerFailure)));
          return authBloc;
        },
        act: (bloc) =>
            bloc.add(AddAddressEvent(addressParams: TestParams.tAddressParams)),
        expect: () => [
          AuthenticationLoadingState(),
          AuthenticationFailureState(
            failureMessage: TestFailures.tServerFailure.message,
          ),
        ],
      );
    });
    group('Delete Address Event', () {
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Loading, UpdateProfileSuccess] when delete Address succeeds',
        build: () {
          when(
            mockDeleteAddress(params: TestParams.tAddressParams),
          ).thenAnswer((_) => Future.value(Right(null)));
          authBloc.profile = TestEntities.tProfile;
          return authBloc;
        },
        act: (bloc) => bloc.add(
          DeleteAddressEvent(addressParams: TestParams.tAddressParams),
        ),
        expect: () => [
          AuthenticationLoadingState(),
          DeleteAddressSuccessState(),
        ],
        verify: (_) {
          verify(
            mockDeleteAddress(params: TestParams.tAddressParams),
          ).called(1);
        },
      );
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Loading, AuthenticationFailure] when delete Address succeeds',
        build: () {
          when(
            mockDeleteAddress(params: TestParams.tAddressParams),
          ).thenAnswer((_) => Future.value(left(TestFailures.tServerFailure)));
          return authBloc;
        },
        act: (bloc) => bloc.add(
          DeleteAddressEvent(addressParams: TestParams.tAddressParams),
        ),
        expect: () => [
          AuthenticationLoadingState(),
          AuthenticationFailureState(
            failureMessage: TestFailures.tServerFailure.message,
          ),
        ],
      );
    });
    group('Update Data Event', () {
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Loading, UpdateProfileSuccess] when update Data succeeds',
        build: () {
          when(
            mockUpdateData(params: TestParams.tUserUpdateDataParams),
          ).thenAnswer((_) => Future.value(Right(TestEntities.tUser)));
          authBloc.profile = TestEntities.tProfile;
          return authBloc;
        },
        act: (bloc) => bloc.add(
          UpdateUserDataEvent(
            updateDataParams: TestParams.tUserUpdateDataParams,
          ),
        ),
        expect: () => [
          AuthenticationLoadingState(),
          UpdateProfileSuccessState(),
        ],
        verify: (_) {
          verify(
            mockUpdateData(params: TestParams.tUserUpdateDataParams),
          ).called(1);
        },
      );
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Loading, AuthenticationFailure] when update Data succeeds',
        build: () {
          when(
            mockUpdateData(params: TestParams.tUserUpdateDataParams),
          ).thenAnswer((_) => Future.value(left(TestFailures.tServerFailure)));
          return authBloc;
        },
        act: (bloc) => bloc.add(
          UpdateUserDataEvent(
            updateDataParams: TestParams.tUserUpdateDataParams,
          ),
        ),
        expect: () => [
          AuthenticationLoadingState(),
          AuthenticationFailureState(
            failureMessage: TestFailures.tServerFailure.message,
          ),
        ],
      );
    });
    group('Sign With Google Event', () {
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Loading, SignInOrSignUpWithGoogleSuccess] when sign with google succeeds',
        build: () {
          when(
            mockGoogleSignIn(),
          ).thenAnswer((_) => Future.value(Right(TestEntities.tUserGoogle)));
          return authBloc;
        },
        act: (bloc) => bloc.add(SignInOrSignUpEvent()),
        expect: () => [
          AuthenticationLoadingState(),
          SignInOrSignUpWithGoogleSuccessState(user: TestEntities.tUserGoogle),
        ],
        verify: (_) {
          verify(mockGoogleSignIn()).called(1);
        },
      );
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [Loading, AuthenticationFailure] when sign with google succeeds',
        build: () {
          when(
            mockGoogleSignIn(),
          ).thenAnswer((_) => Future.value(left(TestFailures.tServerFailure)));
          return authBloc;
        },
        act: (bloc) => bloc.add(SignInOrSignUpEvent()),
        expect: () => [
          AuthenticationLoadingState(),
          AuthenticationFailureState(
            failureMessage: TestFailures.tServerFailure.message,
          ),
        ],
      );
    });
  });
}
