import 'package:e_commerce_app/core/di_core/app_di_core.dart';
import 'package:e_commerce_app/core/network_handler/api_interface.dart';
import 'package:e_commerce_app/core/network_handler/network_info.dart';
import 'package:e_commerce_app/features/products/data/datasources/product_data_source.dart';
import 'package:e_commerce_app/features/products/data/datasources/remote_product_data_source.dart';
import 'package:e_commerce_app/features/products/data/repositories/product_repository_imp.dart';
import 'package:e_commerce_app/features/products/domain/repositories/product_repository.dart';
import 'package:e_commerce_app/features/products/domain/usecases/get_products.dart';
import 'package:e_commerce_app/features/products/presentation/manager/product_bloc.dart';

class ProductDi {
  static void setup() {
    getIt
      // Data Source
      ..registerLazySingleton<ProductDataSource>(
        () => RemoteProductDataSource(apiInterface: getIt<ApiInterface>()),
      )
      // Repository
      ..registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImp(
          productDataSource: getIt<ProductDataSource>(),
          networkInfo: getIt<NetworkInfo>(),
        ),
      )
      // Use Cases
      ..registerLazySingleton<GetProducts>(
        () => GetProducts(getIt<ProductRepository>()),
      )
      // Bloc
      ..registerFactory<ProductBloc>(
        () => ProductBloc(getProducts: getIt<GetProducts>()),
      );
  }
}
