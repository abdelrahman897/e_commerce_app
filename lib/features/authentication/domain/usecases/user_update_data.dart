import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failure.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/core/usecases/base_usecase.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/user.dart';
import 'package:e_commerce_app/features/authentication/domain/repositories/authentication_repository.dart';

class UserUpdateData implements BaseUsecase<User, UserUpdateDataParams> {
  final AuthenticationRepository _authenticationRepository;
  const UserUpdateData(this._authenticationRepository);

  @override
  Future<Either<Failure, User>> call({
    required UserUpdateDataParams params,
  }) async {
    return await _authenticationRepository.updateUserData(params: params);
  }
}
