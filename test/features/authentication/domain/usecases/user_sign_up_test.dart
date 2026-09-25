import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failures.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/user.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_sign_up.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mocks/mock_auth.mocks.dart';
import '../../../../helpers/test_data/test_entities.dart';
import '../../../../helpers/test_data/test_failures.dart';
import '../../../../helpers/test_data/test_params.dart';

void main() {
  late MockAuthenticationRepository mockAuthRepository;
  late UserSignUp userSignUp;
  setUp(() {
    mockAuthRepository = MockAuthenticationRepository();
    userSignUp = UserSignUp(mockAuthRepository);
  });

  group('User SignUp', () {
    test('User SignUp Success', () async {
      when(
        mockAuthRepository.signUpWithCredentials(
          params: TestParams.tSignUpParams,
        ),
      ).thenAnswer((_) => Future.value(Right(TestEntities.tUser)));
      final result = await userSignUp(params: TestParams.tSignUpParams);
      expect(result, equals(Right<Failure, User>(TestEntities.tUser)));
      verify(
        mockAuthRepository.signUpWithCredentials(
          params: TestParams.tSignUpParams,
        ),
      ).called(1);
    });
    test('User SignUp failure', () async {
      when(
        mockAuthRepository.signUpWithCredentials(
          params: TestParams.tSignUpParams,
        ),
      ).thenAnswer((_) => Future.value(Left(TestFailures.tServerFailure)));
      final result = await userSignUp(params: TestParams.tSignUpParams);
      expect(result, equals(Left<Failure, User>(TestFailures.tServerFailure)));
    });

    test('SignUp With Credentials Repository called excatly one.', () async {
      when(
        mockAuthRepository.signUpWithCredentials(
          params: TestParams.tSignUpParams,
        ),
      ).thenAnswer((_) => Future.value(Right(TestEntities.tUser)));
      await userSignUp(params: TestParams.tSignUpParams);
      verify(
        mockAuthRepository.signUpWithCredentials(
          params: TestParams.tSignUpParams,
        ),
      ).called(1);
    });
  });
}
