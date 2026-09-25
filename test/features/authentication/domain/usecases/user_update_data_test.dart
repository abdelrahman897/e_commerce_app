import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failures.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/user.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_update_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mocks/mock_auth.mocks.dart';
import '../../../../helpers/test_data/test_entities.dart';
import '../../../../helpers/test_data/test_failures.dart';
import '../../../../helpers/test_data/test_params.dart';

void main() {
  late MockAuthenticationRepository mockAuthRepository;
  late UserUpdateData userUpdateData;
  setUp(() {
    mockAuthRepository = MockAuthenticationRepository();
    userUpdateData = UserUpdateData(mockAuthRepository);
  });

  group('User Update Data', () {
    test('User Update Data Success', () async {
      when(
        mockAuthRepository.updateUserData(
          params: TestParams.tUserUpdateDataParams,
        ),
      ).thenAnswer((_) => Future.value(Right(TestEntities.tUser)));
      final result = await userUpdateData(params: TestParams.tUserUpdateDataParams);
      expect(result, equals(Right<Failure, User>(TestEntities.tUser)));
      verify(
        mockAuthRepository.updateUserData(
          params: TestParams.tUserUpdateDataParams,
        ),
      ).called(1);
    });
    test('User Update Data failure', () async {
      when(
        mockAuthRepository.updateUserData(
          params: TestParams.tUserUpdateDataParams,
        ),
      ).thenAnswer((_) => Future.value(Left(TestFailures.tServerFailure)));
      final result = await userUpdateData(params: TestParams.tUserUpdateDataParams);
      expect(result, equals(Left<Failure, User>(TestFailures.tServerFailure)));
    });

    test('User Update Data Repository called exactly one.', () async {
      when(
        mockAuthRepository.updateUserData(
          params: TestParams.tUserUpdateDataParams,
        ),
      ).thenAnswer((_) => Future.value(Right(TestEntities.tUser)));
      await userUpdateData(params: TestParams.tUserUpdateDataParams);
      verify(
        mockAuthRepository.updateUserData(
          params: TestParams.tUserUpdateDataParams,
        ),
      ).called(1);
    });
  });
}
