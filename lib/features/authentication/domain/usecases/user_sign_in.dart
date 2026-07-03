import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failure.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/core/usecases/base_usecase.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/user.dart';
import 'package:e_commerce_app/features/authentication/domain/repositories/authentication_repository.dart';

class UserSignIn implements BaseUsecase<User, SignInParams> {
  final AuthenticationRepository _authenticationRepository;
  const UserSignIn(this._authenticationRepository);

  @override
  Future<Either<Failure, User>> call({required SignInParams params}) async {
    return await _authenticationRepository.signInWithCredentials(
      params: params,
    );
  }
}
