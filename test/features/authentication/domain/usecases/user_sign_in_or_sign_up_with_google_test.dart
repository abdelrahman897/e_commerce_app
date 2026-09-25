import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failures.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/user_google.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_sign_in_or_sign_up_with_google.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mocks/mock_auth.mocks.dart';
import '../../../../helpers/test_data/test_entities.dart';
import '../../../../helpers/test_data/test_failures.dart';

void main() {
  late MockAuthenticationRepository mockAuthRepository;
  late UserSignInOrSignUpWithGoogle userSignWithGoogle;
  setUp(() {
    mockAuthRepository = MockAuthenticationRepository();
    userSignWithGoogle = UserSignInOrSignUpWithGoogle(mockAuthRepository);
  });

  group('User SignIn Or SignUp With Google', () {
    test('User Sign With Google is Success.', () async {
      when(
        mockAuthRepository.signInOrSignUpWithGoogle(),
      ).thenAnswer((_) => Future.value(Right(TestEntities.tUserGoogle)));
      final result = await userSignWithGoogle();
      expect(
        result,
        equals(Right<Failure, UserGoogle>(TestEntities.tUserGoogle)),
      );
    });
    test('User Sign With Google is failure.', () async {
      when(
        mockAuthRepository.signInOrSignUpWithGoogle(),
      ).thenAnswer((_) => Future.value(Left(TestFailures.tServerFailure)));
      final result = await userSignWithGoogle();
      expect(
        result,
        equals(Left<Failure, UserGoogle>(TestFailures.tServerFailure)),
      );
    });

    test('signInOrSignUpWithGoogle Repository called excatly one.', () async {
      when(
        mockAuthRepository.signInOrSignUpWithGoogle(),
      ).thenAnswer((_) => Future.value(Right(TestEntities.tUserGoogle)));
      await userSignWithGoogle();
      verify(mockAuthRepository.signInOrSignUpWithGoogle()).called(1);
    });
  });
}
