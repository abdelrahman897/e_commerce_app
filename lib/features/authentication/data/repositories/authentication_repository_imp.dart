import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/exceptions/exceptions.dart';
import 'package:e_commerce_app/core/errors/failures/failures.dart';
import 'package:e_commerce_app/core/errors/handlers/error_mapper.dart';
import 'package:e_commerce_app/core/errors/models/error_model.dart';
import 'package:e_commerce_app/core/handler/authentication_handler/auth_interface_handler.dart';
import 'package:e_commerce_app/core/network_handler/network_info.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/features/authentication/data/datasources/authentication_data_source.dart';
import 'package:e_commerce_app/features/authentication/data/mappers/address_mapper.dart';
import 'package:e_commerce_app/features/authentication/data/mappers/user_google_mapper.dart';
import 'package:e_commerce_app/features/authentication/data/mappers/user_mapper.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/address.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/user.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/user_google.dart';
import 'package:e_commerce_app/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImp implements AuthenticationRepository {
  final AuthenticationDataSource _authenticationDataSource;
  final NetworkInfo _networkInfo;
  final AuthInterfaceHandler _authInterfaceHandler;
  const AuthenticationRepositoryImp({
    required AuthenticationDataSource authenticationDataSource,
    required NetworkInfo networkInfo,
    required AuthInterfaceHandler authInterfaceHandler,
  }) : _authInterfaceHandler = authInterfaceHandler,
       _authenticationDataSource = authenticationDataSource,
       _networkInfo = networkInfo;
  @override
  Future<Either<Failure, User>> signInWithCredentials({
    required SignInParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final model = await _authenticationDataSource.signInWithCredentials(
          params: params,
        );
        if (model.token != null) {
          await _authInterfaceHandler.saveToken(model.token!);
        }
        if (model.user == null) {
          return const Left(
            ServerFailure(
              message: AppErrorMessages.errorResponse,
              statusCode: 404,
            ),
          );
        }
        return Right(model.user!.toEntity);
      } on ServerException catch (serverException) {
        return Left(ErrorMapper.mapServerExceptionToFailure(serverException));
      }
    } else {
      return const Left(ServerFailure.noInternet());
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithCredentials({
    required SignUpParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final model = await _authenticationDataSource.signUpWithCredentials(
          params: params,
        );
        if (model.token != null) {
          await _authInterfaceHandler.saveToken(model.token!);
        }
        if (model.user == null) {
          return const Left(
            ServerFailure(
              message: AppErrorMessages.errorResponse,
              statusCode: 404,
            ),
          );
        }
        return Right(model.user!.toEntity);
      } on ServerException catch (serverException) {
        return Left(ErrorMapper.mapServerExceptionToFailure(serverException));
      }
    } else {
      return const Left(ServerFailure.noInternet());
    }
  }

  @override
  Future<Either<Failure, void>> forgetPasswordWithCredentials({
    required ForgetPasswordParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        await _authenticationDataSource.forgetPasswordWithCredentials(
          params: params,
        );
        return Right(null);
      } on ServerException catch (serverException) {
        return Left(ErrorMapper.mapServerExceptionToFailure(serverException));
      }
    } else {
      return const Left(ServerFailure.noInternet());
    }
  }

  @override
  Future<Either<Failure, UserGoogle>> signInOrSignUpWithGoogle() async {
    if (await _networkInfo.isConnected) {
      try {
        final model = await _authenticationDataSource
            .signInOrSignUpWithGoogle();
        await _authInterfaceHandler.saveToken(model.token);
        return Right(model.userGoogle.toEntity);
      } on GoogleAuthException catch (error) {
        return Left(ErrorMapper.mapGoogleAuthToFailure(error));
      } on ErrorModel catch (error) {
        return Left(
          ServerFailure(message: error.errorMessage, statusCode: 404),
        );
      }
    } else {
      return const Left(ServerFailure.noInternet());
    }
  }

  @override
  Future<Either<Failure, Address>> addAddress({
    required AddressParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final model = await _authenticationDataSource.addAddress(
          params: params,
        );
        return Right(model.toEntity);
      } on ServerException catch (serverException) {
        return Left(ErrorMapper.mapServerExceptionToFailure(serverException));
      }
    } else {
      return const Left(ServerFailure.noInternet());
    }
  }

  @override
  Future<Either<Failure, void>> deleteAddress({
    required AddressParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        await _authenticationDataSource.deleteAddress(params: params);
        return Right(null);
      } on ServerException catch (serverException) {
        return Left(ErrorMapper.mapServerExceptionToFailure(serverException));
      }
    } else {
      return const Left(ServerFailure.noInternet());
    }
  }

  @override
  Future<Either<Failure, User>> updateUserData({
    required UserUpdateDataParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final model = await _authenticationDataSource.updateUserData(
          params: params,
        );
        if (model.token != null) {
          await _authInterfaceHandler.saveToken(model.token!);
        }
        if (model.user == null) {
          return const Left(
            ServerFailure(
              message: AppErrorMessages.errorResponse,
              statusCode: 404,
            ),
          );
        }
        return Right(model.user!.toEntity);
      } on ServerException catch (serverException) {
        return Left(ErrorMapper.mapServerExceptionToFailure(serverException));
      }
    } else {
      return const Left(ServerFailure.noInternet());
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _authenticationDataSource.signOut();
      return Right(null);
    } on ServerException catch (serverException) {
      return Left(ErrorMapper.mapServerExceptionToFailure(serverException));
    }
  }
}
