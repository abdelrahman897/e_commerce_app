import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/exceptions/google_auth_exception.dart';
import 'package:e_commerce_app/core/errors/exceptions/server_exception.dart';
import 'package:e_commerce_app/core/errors/failures/failures.dart';
import 'package:e_commerce_app/features/authentication/data/repositories/authentication_repository_imp.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/address.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/user.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/user_google.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/mocks/mock_auth.mocks.dart';
import '../../../../helpers/test_data/test_data.dart';
import '../../../../helpers/test_data/test_entities.dart';
import '../../../../helpers/test_data/test_exceptions.dart';
import '../../../../helpers/test_data/test_models.dart';
import '../../../../helpers/test_data/test_params.dart';

void main() {
  late AuthenticationRepositoryImp authRepository;
  late MockAuthenticationDataSource mockDataSource;
  late MockAuthInterfaceHandler mockAuthHandler;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockAuthHandler = MockAuthInterfaceHandler();
    mockDataSource = MockAuthenticationDataSource();
    authRepository = AuthenticationRepositoryImp(
      authenticationDataSource: mockDataSource,
      networkInfo: mockNetworkInfo,
      authInterfaceHandler: mockAuthHandler,
    );
  });

  const tNoInternet = Left<Failure, dynamic>(ServerFailure.noInternet());
  group('authentication repository imp', () {
    group('signIn With Credentials Repository', () {
      test('signInWithCredentials Repository is successfully', () async {
        TestConnection.onLine(mockNetworkInfo);
        when(
          mockDataSource.signInWithCredentials(
            params: TestParams.tSignInParams,
          ),
        ).thenAnswer((_) => Future.value(TestModels.tAuthModel));
        when(mockAuthHandler.saveToken(any)).thenAnswer((_) => Future.value());
        final result = await authRepository.signInWithCredentials(
          params: TestParams.tSignInParams,
        );
        expect(
          result,
          equals(
            Right<Failure, User>(
              const User(
                name: TestConstants.tName,
                email: TestConstants.tEmail,
                role: TestConstants.tRole,
              ),
            ),
          ),
        );
        verify(mockAuthHandler.saveToken(TestConstants.tToken)).called(1);
      });
      test(' signInWithCredentials Repository is failure', () async {
        TestConnection.onLine(mockNetworkInfo);
        when(
          mockDataSource.signInWithCredentials(
            params: TestParams.tSignInParams,
          ),
        ).thenThrow(
          UnauthorizedException(
            TestExceptions.errorModel(
              errorMessage: 'Unauthorized',
              statusCode: 401,
            ),
          ),
        );
        final result = await authRepository.signInWithCredentials(
          params: TestParams.tSignInParams,
        );
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) => expect(failure, isA<Failure>()),
          (_) => fail(TestConstants.tExcpectedMessageLeft),
        );
      });

      test('with no token', () async {
        TestConnection.onLine(mockNetworkInfo);
        when(
          mockDataSource.signInWithCredentials(
            params: TestParams.tSignInParams,
          ),
        ).thenAnswer((_) => Future.value(TestModels.tAuthWithNoTokenModel));
        await authRepository.signInWithCredentials(
          params: TestParams.tSignInParams,
        );
        verifyNever(mockAuthHandler.saveToken(any));
      });

      test('isOffline', () async {
        TestConnection.offLine(mockNetworkInfo);
        final result = await authRepository.signInWithCredentials(
          params: TestParams.tSignInParams,
        );
        expect(result, equals(tNoInternet));
        verifyNever(
          mockDataSource.signInWithCredentials(
            params: TestParams.tSignInParams,
          ),
        );
      });
    });
    group('signUp With Credentials Repository', () {
      test('signUp With Credentials Repository is successfully', () async {
        TestConnection.onLine(mockNetworkInfo);
        when(
          mockDataSource.signUpWithCredentials(
            params: TestParams.tSignUpParams,
          ),
        ).thenAnswer((_) => Future.value(TestModels.tAuthModel));
        when(mockAuthHandler.saveToken(any)).thenAnswer((_) => Future.value());
        final result = await authRepository.signUpWithCredentials(
          params: TestParams.tSignUpParams,
        );
        expect(
          result,
          equals(
            Right<Failure, User>(
              const User(
                name: TestConstants.tName,
                email: TestConstants.tEmail,
                role: TestConstants.tRole,
              ),
            ),
          ),
        );
        verify(mockAuthHandler.saveToken(TestConstants.tToken)).called(1);
      });
      test(' signUp With Credentials Repository is failure', () async {
        TestConnection.onLine(mockNetworkInfo);
        when(
          mockDataSource.signUpWithCredentials(
            params: TestParams.tSignUpParams,
          ),
        ).thenThrow(
          UnauthorizedException(
            TestExceptions.errorModel(
              errorMessage: 'Unauthorized',
              statusCode: 401,
            ),
          ),
        );
        final result = await authRepository.signUpWithCredentials(
          params: TestParams.tSignUpParams,
        );
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) => expect(failure, isA<Failure>()),
          (_) => fail(TestConstants.tExcpectedMessageLeft),
        );
      });

      test('with no token', () async {
        TestConnection.onLine(mockNetworkInfo);
        when(
          mockDataSource.signUpWithCredentials(
            params: TestParams.tSignUpParams,
          ),
        ).thenAnswer((_) => Future.value(TestModels.tAuthWithNoTokenModel));
        await authRepository.signUpWithCredentials(
          params: TestParams.tSignUpParams,
        );
        verifyNever(mockAuthHandler.saveToken(any));
      });

      test('isOffline', () async {
        TestConnection.offLine(mockNetworkInfo);
        final result = await authRepository.signUpWithCredentials(
          params: TestParams.tSignUpParams,
        );
        expect(result, equals(tNoInternet));
        verifyNever(
          mockDataSource.signUpWithCredentials(
            params: TestParams.tSignUpParams,
          ),
        );
      });
    });
    group('forgetPassword With Credentials Repository', () {
      test(
        'forgetPassword With Credentials Repository is successfully',
        () async {
          TestConnection.onLine(mockNetworkInfo);
          when(
            mockDataSource.forgetPasswordWithCredentials(
              params: TestParams.tForgetPasswordParams,
            ),
          ).thenAnswer((_) => Future.value(TestModels.tAuthModel));
          final result = await authRepository.forgetPasswordWithCredentials(
            params: TestParams.tForgetPasswordParams,
          );
          expect(result, equals(Right<Failure, void>(null)));
        },
      );
      test('forgetPassword With Credentials Repository is failure', () async {
        TestConnection.onLine(mockNetworkInfo);
        when(
          mockDataSource.forgetPasswordWithCredentials(
            params: TestParams.tForgetPasswordParams,
          ),
        ).thenThrow(
          UnauthorizedException(
            TestExceptions.errorModel(
              errorMessage: 'Unauthorized',
              statusCode: 401,
            ),
          ),
        );
        final result = await authRepository.forgetPasswordWithCredentials(
          params: TestParams.tForgetPasswordParams,
        );
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) => expect(failure, isA<Failure>()),
          (_) => fail(TestConstants.tExcpectedMessageLeft),
        );
      });

      test('isOffline', () async {
        TestConnection.offLine(mockNetworkInfo);
        final result = await authRepository.forgetPasswordWithCredentials(
          params: TestParams.tForgetPasswordParams,
        );
        expect(result, equals(tNoInternet));
        verifyNever(
          mockDataSource.forgetPasswordWithCredentials(
            params: TestParams.tForgetPasswordParams,
          ),
        );
      });
    });
    group('update User Data Repository', () {
      test('update User Data Repository is successfully', () async {
        TestConnection.onLine(mockNetworkInfo);
        when(
          mockDataSource.updateUserData(
            params: TestParams.tUserUpdateDataParams,
          ),
        ).thenAnswer((_) => Future.value(TestModels.tAuthModel));
        when(mockAuthHandler.saveToken(any)).thenAnswer((_) => Future.value());
        final result = await authRepository.updateUserData(
          params: TestParams.tUserUpdateDataParams,
        );
        expect(
          result,
          equals(
            Right<Failure, User>(
              const User(
                name: TestConstants.tName,
                email: TestConstants.tEmail,
                role: TestConstants.tRole,
              ),
            ),
          ),
        );
        verify(mockAuthHandler.saveToken(TestConstants.tToken)).called(1);
      });
      test('update User Data Repository is failure', () async {
        TestConnection.onLine(mockNetworkInfo);
        when(
          mockDataSource.updateUserData(
            params: TestParams.tUserUpdateDataParams,
          ),
        ).thenThrow(
          UnauthorizedException(
            TestExceptions.errorModel(
              errorMessage: 'Unauthorized',
              statusCode: 401,
            ),
          ),
        );
        final result = await authRepository.updateUserData(
          params: TestParams.tUserUpdateDataParams,
        );
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) => expect(failure, isA<Failure>()),
          (_) => fail(TestConstants.tExcpectedMessageLeft),
        );
      });

      test('with no token', () async {
        TestConnection.onLine(mockNetworkInfo);
        when(
          mockDataSource.updateUserData(
            params: TestParams.tUserUpdateDataParams,
          ),
        ).thenAnswer((_) => Future.value(TestModels.tAuthWithNoTokenModel));
        await authRepository.updateUserData(
          params: TestParams.tUserUpdateDataParams,
        );
        verifyNever(mockAuthHandler.saveToken(any));
      });
      test('isOffline', () async {
        TestConnection.offLine(mockNetworkInfo);
        final result = await authRepository.updateUserData(
          params: TestParams.tUserUpdateDataParams,
        );
        expect(result, equals(tNoInternet));
        verifyNever(
          mockDataSource.updateUserData(
            params: TestParams.tUserUpdateDataParams,
          ),
        );
      });
    });
    group('add Address Repository', () {
      test('add Address Repository is successfully', () async {
        TestConnection.onLine(mockNetworkInfo);
        when(
          mockDataSource.addAddress(params: TestParams.tAddressParams),
        ).thenAnswer((_) => Future.value(TestModels.tAddressModelResponse));
        final result = await authRepository.addAddress(
          params: TestParams.tAddressParams,
        );
        expect(result, equals(Right<Failure, Address>(TestEntities.tAddress)));
      });
      test('add Address Repository is failure', () async {
        TestConnection.onLine(mockNetworkInfo);
        when(
          mockDataSource.addAddress(params: TestParams.tAddressParams),
        ).thenThrow(
          UnauthorizedException(
            TestExceptions.errorModel(
              errorMessage: 'Unauthorized',
              statusCode: 401,
            ),
          ),
        );
        final result = await authRepository.addAddress(
          params: TestParams.tAddressParams,
        );
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) => expect(failure, isA<Failure>()),
          (_) => fail(TestConstants.tExcpectedMessageLeft),
        );
      });
      test('isOffline', () async {
        TestConnection.offLine(mockNetworkInfo);
        final result = await authRepository.addAddress(
          params: TestParams.tAddressParams,
        );
        expect(result, equals(tNoInternet));
        verifyNever(
          mockDataSource.addAddress(params: TestParams.tAddressParams),
        );
      });
    });
    group('delete Address Repository', () {
      test('delete Address Repository is successfully', () async {
        TestConnection.onLine(mockNetworkInfo);
        when(
          mockDataSource.deleteAddress(params: TestParams.tAddressParams),
        ).thenAnswer((_) => Future.value(null));
        final result = await authRepository.deleteAddress(
          params: TestParams.tAddressParams,
        );
        expect(result, equals(Right<Failure, void>(null)));
      });
      test('delete Address Repository is failure', () async {
        TestConnection.onLine(mockNetworkInfo);
        when(
          mockDataSource.deleteAddress(params: TestParams.tAddressParams),
        ).thenThrow(
          UnauthorizedException(
            TestExceptions.errorModel(
              errorMessage: 'Unauthorized',
              statusCode: 401,
            ),
          ),
        );
        final result = await authRepository.deleteAddress(
          params: TestParams.tAddressParams,
        );
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) => expect(failure, isA<Failure>()),
          (_) => fail(TestConstants.tExcpectedMessageLeft),
        );
      });
      test('isOffline', () async {
        TestConnection.offLine(mockNetworkInfo);
        final result = await authRepository.deleteAddress(
          params: TestParams.tAddressParams,
        );
        expect(result, equals(tNoInternet));
        verifyNever(
          mockDataSource.deleteAddress(params: TestParams.tAddressParams),
        );
      });
    });
    group('signIn Or SignUp With Google Repository', () {
      test('signIn Or SignUp With Google Repository is successfully', () async {
        TestConnection.onLine(mockNetworkInfo);
        when(
          mockDataSource.signInOrSignUpWithGoogle(),
        ).thenAnswer((_) => Future.value(TestModels.tGoogleResponse));
        when(
          mockAuthHandler.saveToken(TestConstants.tGoogleToken),
        ).thenAnswer((_) => Future.value());
        final result = await authRepository.signInOrSignUpWithGoogle();
        expect(
          result,
          equals(Right<Failure, UserGoogle>(TestEntities.tUserGoogle)),
        );
        verify(mockAuthHandler.saveToken(TestConstants.tGoogleToken)).called(1);
      });
      test('signIn Or SignUp With Google Repository is failure', () async {
        TestConnection.onLine(mockNetworkInfo);
        when(
          mockDataSource.signInOrSignUpWithGoogle(),
        ).thenThrow(const GoogleSignInCancelledException());
        final result = await authRepository.signInOrSignUpWithGoogle();
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) => expect(failure, isA<Failure>()),
          (_) => fail(TestConstants.tExcpectedMessageLeft),
        );
      });
      test('isOffline', () async {
        TestConnection.offLine(mockNetworkInfo);
        final result = await authRepository.signInOrSignUpWithGoogle();
        expect(result, equals(tNoInternet));
        verifyNever(mockDataSource.signInOrSignUpWithGoogle());
      });
    });
  });
}
