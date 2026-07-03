import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failure.dart';
import 'package:e_commerce_app/core/usecases/base_usecase_without_params.dart';
import 'package:e_commerce_app/features/authentication/domain/repositories/authentication_repository.dart';

class UserSignOut implements BaseUsecaseWithoutParams<void> {
  final AuthenticationRepository _authenticationRepository;
  const UserSignOut(this._authenticationRepository);
  @override
  Future<Either<Failure, void>> call() async {
    return _authenticationRepository.signOut();
  }
}
