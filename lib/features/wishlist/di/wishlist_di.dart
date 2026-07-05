import 'package:e_commerce_app/core/di_core/app_di_core.dart';
import 'package:e_commerce_app/core/network_handler/api_interface.dart';
import 'package:e_commerce_app/core/network_handler/network_info.dart';
import 'package:e_commerce_app/core/storage_handler/local_storage_handler_interface.dart';
import 'package:e_commerce_app/features/wishlist/data/datasources/wishlist_local_data_source.dart';
import 'package:e_commerce_app/features/wishlist/data/datasources/wishlist_remote_data_source.dart';
import 'package:e_commerce_app/features/wishlist/data/repositories/wishlist_repository_imp.dart';
import 'package:e_commerce_app/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:e_commerce_app/features/wishlist/domain/usecases/add_product_to_wishlist.dart';
import 'package:e_commerce_app/features/wishlist/domain/usecases/delete_product_from_wishlist.dart';
import 'package:e_commerce_app/features/wishlist/domain/usecases/get_wishlist.dart';
import 'package:e_commerce_app/features/wishlist/presentation/manager/wishlist_bloc.dart';

class WishlistDi {

  static void setup() {
    getIt
      // datasource
      ..registerLazySingleton<WishlistRemoteDataSource>(
        () => WishlistRemoteDataSourceImp(apiInterface: getIt<ApiInterface>()),
      )
      ..registerLazySingleton<WishlistLocalDataSource>(
        () => WishlistLocalDataSourceImp(
          localStorage: getIt<LocalStorageHandlerInterface>(),
        ),
      )
      //repository
      ..registerLazySingleton<WishlistRepository>(
        () => WishlistRepositoryImp(
          networkInfo: getIt<NetworkInfo>(),
          wishlistRemoteDataSource: getIt<WishlistRemoteDataSource>(),
          wishlistLocalDataSource: getIt<WishlistLocalDataSource>(),
        ),
      )
      // usecases
      ..registerLazySingleton<AddProductToWishlist>(
        () => AddProductToWishlist(getIt<WishlistRepository>()),
      )
      ..registerLazySingleton<DeleteProductFromWishlist>(
        () => DeleteProductFromWishlist(getIt<WishlistRepository>()),
      )
      ..registerLazySingleton<GetWishlist>(
        () => GetWishlist(getIt<WishlistRepository>()),
      )
      // bloc
      ..registerLazySingleton<WishlistBloc>(
        () => WishlistBloc(
          getWishlist: getIt<GetWishlist>(),
          deleteProductFromWishlist: getIt<DeleteProductFromWishlist>(),
          addProductToWishlist: getIt<AddProductToWishlist>(),
        ),
      );
  }
}
