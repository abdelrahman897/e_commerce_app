import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failure.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/core/usecases/base_usecase.dart';
import 'package:e_commerce_app/features/wishlist/domain/repositories/wishlist_repository.dart';

class AddProductToWishlist implements BaseUsecase<void, WishlistParams> {
  final WishlistRepository _wishlistRepository;
  const AddProductToWishlist(this._wishlistRepository);
  @override
  Future<Either<Failure, void>> call({required WishlistParams params}) async {
    return await _wishlistRepository.addProduct(params: params);
  }
}
