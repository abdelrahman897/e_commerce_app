import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failure.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/core/usecases/base_usecase.dart';
import 'package:e_commerce_app/features/cart/domain/repositories/cart_repository.dart';

class AddProductToCart implements BaseUsecase<void, CartParams> {
  final CartRepository _cartRepository;
  AddProductToCart(this._cartRepository);
  @override
  Future<Either<Failure, void>> call({required CartParams params}) async {
    return await _cartRepository.addProduct(params: params);
  }
}
