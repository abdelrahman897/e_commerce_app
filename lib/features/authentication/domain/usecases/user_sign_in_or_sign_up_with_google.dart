import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failure.dart';
import 'package:e_commerce_app/core/usecases/base_usecase_without_params.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/user_google.dart';
import 'package:e_commerce_app/features/authentication/domain/repositories/authentication_repository.dart';

class UserSignInOrSignUpWithGoogle
    implements BaseUsecaseWithoutParams<UserGoogle> {
  final AuthenticationRepository _authenticationRepository;
  UserSignInOrSignUpWithGoogle(this._authenticationRepository);

  @override
  Future<Either<Failure, UserGoogle>> call() async {
    return await _authenticationRepository.signInOrSignUpWithGoogle();
  }
}
