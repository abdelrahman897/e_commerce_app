import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failures.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/address.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/user.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/add_address.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mocks/mock_auth.mocks.dart';
import '../../../../helpers/test_data/test_entities.dart';
import '../../../../helpers/test_data/test_failures.dart';
import '../../../../helpers/test_data/test_params.dart';

void main() {
  late MockAuthenticationRepository mockAuthRepository;
  late AddAddress userAddAddress;
  setUp(() {
    mockAuthRepository = MockAuthenticationRepository();
    userAddAddress = AddAddress(mockAuthRepository);
  });

  group('User Add Address', () {
    test('User Add Address Success', () async {
      when(
        mockAuthRepository.addAddress(params: TestParams.tAddressParams),
      ).thenAnswer((_) => Future.value(Right(TestEntities.tAddress)));
      final result = await userAddAddress(params: TestParams.tAddressParams);
      expect(result, equals(Right<Failure, Address>(TestEntities.tAddress)));
      verify(
        mockAuthRepository.addAddress(
          params: TestParams.tAddressParams,
        ),
      ).called(1);
    });
    test('User Add Address failure', () async {
      when(
        mockAuthRepository.addAddress(params: TestParams.tAddressParams),
      ).thenAnswer((_) => Future.value(Left(TestFailures.tServerFailure)));
      final result = await userAddAddress(params: TestParams.tAddressParams);
      expect(result, equals(Left<Failure, User>(TestFailures.tServerFailure)));
    });

    test('User Add Address called excatly one.', () async {
      when(
        mockAuthRepository.addAddress(params: TestParams.tAddressParams),
      ).thenAnswer((_) => Future.value(Right(TestEntities.tAddress)));
      await userAddAddress(params: TestParams.tAddressParams);
      verify(
        mockAuthRepository.addAddress(params: TestParams.tAddressParams),
      ).called(1);
    });
  });
}
