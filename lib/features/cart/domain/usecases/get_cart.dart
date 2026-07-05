import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failure.dart';
import 'package:e_commerce_app/core/usecases/base_usecase_without_params.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart.dart';
import 'package:e_commerce_app/features/cart/domain/repositories/cart_repository.dart';

class GetCart implements BaseUsecaseWithoutParams<Cart> {
  final CartRepository _cartRepository;
  GetCart(this._cartRepository);
  @override
  Future<Either<Failure, Cart>> call() async {
    return await _cartRepository.getCart();
  }
}
