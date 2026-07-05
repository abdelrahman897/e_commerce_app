import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failure.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/core/usecases/base_usecase.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart.dart';
import 'package:e_commerce_app/features/cart/domain/repositories/cart_repository.dart';

class UpdateProductQuantity implements BaseUsecase<Cart, CartParams> {
  final CartRepository _cartRepository;
  UpdateProductQuantity(this._cartRepository);
  @override
  Future<Either<Failure, Cart>> call({required CartParams params}) async {
    return await _cartRepository.updateProduct(params: params);
  }
}
