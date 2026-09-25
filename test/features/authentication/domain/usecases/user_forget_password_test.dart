import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failures.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/user.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_forget_password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mocks/mock_auth.mocks.dart';
import '../../../../helpers/test_data/test_failures.dart';
import '../../../../helpers/test_data/test_params.dart';

void main() {
  late MockAuthenticationRepository mockAuthRepository;
  late UserForgetPassword userForgetPassword;
  setUp(() {
    mockAuthRepository = MockAuthenticationRepository();
    userForgetPassword = UserForgetPassword(mockAuthRepository);
  });

  group('User Forget Password', () {
    test('User Forget Password Success', () async {
      when(
        mockAuthRepository.forgetPasswordWithCredentials(
          params: TestParams.tForgetPasswordParams,
        ),
      ).thenAnswer((_) => Future.value(Right(null)));
      final result = await userForgetPassword(params: TestParams.tForgetPasswordParams);
      expect(result, equals(Right<Failure, void>(null)));
    });
    test('User Forget Password failure', () async {
      when(
        mockAuthRepository.forgetPasswordWithCredentials(
          params: TestParams.tForgetPasswordParams,
        ),
      ).thenAnswer((_) => Future.value(Left(TestFailures.tServerFailure)));
      final result = await userForgetPassword(params: TestParams.tForgetPasswordParams);
      expect(result, equals(Left<Failure, User>(TestFailures.tServerFailure)));
    });

    test('User Forget Password called excatly one.', () async {
      when(
        mockAuthRepository.forgetPasswordWithCredentials(
          params: TestParams.tForgetPasswordParams,
        ),
      ).thenAnswer((_) => Future.value(Right(null)));
      await userForgetPassword(params: TestParams.tForgetPasswordParams);
      verify(
        mockAuthRepository.forgetPasswordWithCredentials(
          params: TestParams.tForgetPasswordParams,
        ),
      ).called(1);
    });
  });
}
