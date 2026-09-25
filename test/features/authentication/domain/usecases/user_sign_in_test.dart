import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failures.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/user.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_sign_in.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mocks/mock_auth.mocks.dart';
import '../../../../helpers/test_data/test_entities.dart';
import '../../../../helpers/test_data/test_failures.dart';
import '../../../../helpers/test_data/test_params.dart';

void main() {
  late MockAuthenticationRepository mockAuthRepository;
  late UserSignIn userSignIn;
  setUp(() {
    mockAuthRepository = MockAuthenticationRepository();
    userSignIn = UserSignIn(mockAuthRepository);
  });

  group('UserSignIn', () {
    test('UserSignIn Success', () async {
      when(
        mockAuthRepository.signInWithCredentials(
          params: TestParams.tSignInParams,
        ),
      ).thenAnswer((_) => Future.value(Right(TestEntities.tUser)));
      final result = await userSignIn(params: TestParams.tSignInParams);
      expect(result, equals(Right<Failure, User>(TestEntities.tUser)));
      verify(
        mockAuthRepository.signInWithCredentials(
          params: TestParams.tSignInParams,
        ),
      ).called(1);
    });
    test('UserSignIn failure', () async {
      when(
        mockAuthRepository.signInWithCredentials(
          params: TestParams.tSignInParams,
        ),
      ).thenAnswer((_) => Future.value(Left(TestFailures.tServerFailure)));
      final result = await userSignIn(params: TestParams.tSignInParams);
      expect(result, equals(Left<Failure, User>(TestFailures.tServerFailure)));
    });

    test('authRepository called excatly one.', () async {
      when(
        mockAuthRepository.signInWithCredentials(
          params: TestParams.tSignInParams,
        ),
      ).thenAnswer((_) => Future.value(Right(TestEntities.tUser)));
      await userSignIn(params: TestParams.tSignInParams);
      verify(
        mockAuthRepository.signInWithCredentials(
          params: TestParams.tSignInParams,
        ),
      ).called(1);
    });
  });
}
