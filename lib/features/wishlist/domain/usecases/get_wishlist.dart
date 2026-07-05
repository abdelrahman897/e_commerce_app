import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures/failure.dart';
import 'package:e_commerce_app/core/usecases/base_usecase_without_params.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_item.dart';
import 'package:e_commerce_app/features/wishlist/domain/repositories/wishlist_repository.dart';

class GetWishlist implements BaseUsecaseWithoutParams<List<ProductItem>> {
  final WishlistRepository _wishlistRepository;
  const GetWishlist(this._wishlistRepository);
  @override
  Future<Either<Failure, List<ProductItem>>> call() async {
    return await _wishlistRepository.getWishlist();
  }
}
