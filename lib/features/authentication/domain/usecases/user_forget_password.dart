import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failure.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/core/usecases/base_usecase.dart';
import 'package:e_commerce_app/features/authentication/domain/repositories/authentication_repository.dart';

class UserForgetPassword implements BaseUsecase<void, ForgetPasswordParams> {
  final AuthenticationRepository _authenticationRepository;
  const UserForgetPassword(this._authenticationRepository);
  @override
  Future<Either<Failure, void>> call({
    required ForgetPasswordParams params,
  }) async {
    return await _authenticationRepository.forgetPasswordWithCredentials(
      params: params,
    );
  }
}
