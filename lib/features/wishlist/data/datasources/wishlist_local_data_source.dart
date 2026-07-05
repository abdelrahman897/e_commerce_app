import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/storage_handler/local_storage_handler_interface.dart';
import 'package:e_commerce_app/features/products/data/models/product_item_model.dart';
import '../../../../core/errors/exceptions/exceptions.dart';

abstract interface class WishlistLocalDataSource {
  Future<List<ProductItemModel>> getCachedWishlist();
  Future<void> deleteCachedProduct({required WishlistParams params});
  Future<void> addCachedProduct({required List<ProductItemModel> items});
}

class WishlistLocalDataSourceImp implements WishlistLocalDataSource {
  const WishlistLocalDataSourceImp({
    required LocalStorageHandlerInterface localStorage,
  }) : _localStorage = localStorage;
  final LocalStorageHandlerInterface _localStorage;
  @override
  Future<void> addCachedProduct({required List<ProductItemModel> items}) async {
    try {
      await _localStorage.clear(boxName: HiveBoxesConstant.wishlistBox);
      for (final item in items) {
        await _localStorage.put(
          boxName: HiveBoxesConstant.wishlistBox,
          key: item.id,
          value: item,
        );
      }
    } catch (error) {
      throw CacheWriteException(errorMessage: 'Cache Write operation failed');
    }
  }

  @override
  Future<void> deleteCachedProduct({required WishlistParams params}) async {
    try {
      await _localStorage.delete(
        boxName: HiveBoxesConstant.wishlistBox,
        key: params.productId,
      );
    } catch (error) {
      throw CacheWriteException(errorMessage: 'Cache Write operation failed');
    }
  }

  @override
  Future<List<ProductItemModel>> getCachedWishlist() async {
    try {
      final response = _localStorage.getAll<ProductItemModel>(
        boxName: HiveBoxesConstant.wishlistBox,
      );
      return response;
    } catch (error) {
      throw CacheReadException(errorMessage: 'Cache Read operation failed');
    }
  }
}
