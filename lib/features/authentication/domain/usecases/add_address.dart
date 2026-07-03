import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failure.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/core/usecases/base_usecase.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/address.dart';
import 'package:e_commerce_app/features/authentication/domain/repositories/authentication_repository.dart';

class AddAddress implements BaseUsecase<Address, AddressParams> {
  final AuthenticationRepository _authenticationRepository;
  const AddAddress(this._authenticationRepository);
  @override
  Future<Either<Failure, Address>> call({required params}) async {
    return await _authenticationRepository.addAddress(params: params);
  }
}
