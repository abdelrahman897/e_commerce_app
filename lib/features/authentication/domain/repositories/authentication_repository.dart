import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failures.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/address.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/user.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/user_google.dart';

abstract interface class AuthenticationRepository {
  // sign-in
  Future<Either<Failure, User>> signInWithCredentials({
    required SignInParams params,
  });
  // sign-up
  Future<Either<Failure, User>> signUpWithCredentials({
    required SignUpParams params,
  });
  // forget-password
  Future<Either<Failure, void>> forgetPasswordWithCredentials({
    required ForgetPasswordParams params,
  });

  // update profile
  Future<Either<Failure, User>> updateUserData({
    required UserUpdateDataParams params,
  });

  // address
  Future<Either<Failure, Address>> addAddress({required AddressParams params});

  Future<Either<Failure, void>> deleteAddress({required AddressParams params});
  // sign-in or up with google
  Future<Either<Failure, UserGoogle>> signInOrSignUpWithGoogle();

  // sign-out
  Future<Either<Failure, void>> signOut();
}
