import 'package:e_commerce_app/core/di_core/app_di_core.dart';
import 'package:e_commerce_app/core/network_handler/api_interface.dart';
import 'package:e_commerce_app/core/network_handler/network_info.dart';
import 'package:e_commerce_app/features/cart/data/datasources/cart_data_source.dart';
import 'package:e_commerce_app/features/cart/data/datasources/remote_cart_data_source.dart';
import 'package:e_commerce_app/features/cart/data/repositories/cart_repository_imp.dart';
import 'package:e_commerce_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/add_product_to_cart.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/delete_product_from_cart.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/get_cart.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/update_product_quantity.dart';
import 'package:e_commerce_app/features/cart/presentation/manager/cart_bloc.dart';

class CartDi {
  static void setup() {
    getIt
      // datasource
      ..registerLazySingleton<CartDataSource>(
        () => RemoteCartDataSource(apiInterface: getIt<ApiInterface>()),
      )
      //repository
      ..registerLazySingleton<CartRepository>(
        () => CartRepositoryImp(
          cartDataSource: getIt<CartDataSource>(),
          networkInfo: getIt<NetworkInfo>(),
        ),
      )
      // usecases
      ..registerLazySingleton<AddProductToCart>(
        () => AddProductToCart(getIt<CartRepository>()),
      )
      ..registerLazySingleton<DeleteProductFromCart>(
        () => DeleteProductFromCart(getIt<CartRepository>()),
      )
      ..registerLazySingleton<GetCart>(() => GetCart(getIt<CartRepository>()))
      ..registerLazySingleton<UpdateProductQuantity>(
        () => UpdateProductQuantity(getIt<CartRepository>()),
      )
      // bloc
      ..registerLazySingleton<CartBloc>(
        () => CartBloc(
          getCart: getIt<GetCart>(),
          deleteProductFromCart: getIt<DeleteProductFromCart>(),
          updateProductQuantity: getIt<UpdateProductQuantity>(),
          addProductToCart: getIt<AddProductToCart>(),
        ),
      );
  }
}
