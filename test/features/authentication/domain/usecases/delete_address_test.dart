import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failures.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/user.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/delete_address.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mocks/mock_auth.mocks.dart';

import '../../../../helpers/test_data/test_failures.dart';
import '../../../../helpers/test_data/test_params.dart';

void main() {
  late MockAuthenticationRepository mockAuthRepository;
  late DeleteAddress userDeleteAddress;
  setUp(() {
    mockAuthRepository = MockAuthenticationRepository();
    userDeleteAddress = DeleteAddress(mockAuthRepository);
  });

  group('User Delete Address', () {
    test('User Delete Address Success', () async {
      when(
        mockAuthRepository.deleteAddress(params: TestParams.tAddressParams),
      ).thenAnswer((_) => Future.value(Right(null)));
      final result = await userDeleteAddress(params: TestParams.tAddressParams);
      expect(result, equals(Right<Failure, void>(null)));
      verify(
        mockAuthRepository.deleteAddress(
          params: TestParams.tAddressParams,
        ),
      ).called(1);
    });
    test('User Delete Address failure', () async {
      when(
        mockAuthRepository.deleteAddress(params: TestParams.tAddressParams),
      ).thenAnswer((_) => Future.value(Left(TestFailures.tServerFailure)));
      final result = await userDeleteAddress(params: TestParams.tAddressParams);
      expect(result, equals(Left<Failure, User>(TestFailures.tServerFailure)));
    });

    test('User Delete Address called excatly one.', () async {
      when(
        mockAuthRepository.deleteAddress(params: TestParams.tAddressParams),
      ).thenAnswer((_) => Future.value(Right(null)));
      await userDeleteAddress(params: TestParams.tAddressParams);
      verify(
        mockAuthRepository.deleteAddress(params: TestParams.tAddressParams),
      ).called(1);
    });
  });
}
