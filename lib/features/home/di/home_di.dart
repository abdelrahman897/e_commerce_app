import 'package:e_commerce_app/core/di_core/app_di_core.dart';
import 'package:e_commerce_app/core/network_handler/api_interface.dart';
import 'package:e_commerce_app/core/network_handler/network_info.dart';
import 'package:e_commerce_app/features/home/data/datasources/home_data_source.dart';
import 'package:e_commerce_app/features/home/data/datasources/remote_home_data_source.dart';
import 'package:e_commerce_app/features/home/data/repositories/home_repository_imp.dart';
import 'package:e_commerce_app/features/home/domain/repositories/home_repository.dart';
import 'package:e_commerce_app/features/home/domain/usecases/get_all_categories.dart';
import 'package:e_commerce_app/features/home/domain/usecases/get_brands.dart';
import 'package:e_commerce_app/features/home/domain/usecases/get_categories.dart';
import 'package:e_commerce_app/features/home/presentation/manager/home_bloc.dart';

class HomeDi {
  static void setup() {
    getIt
      // Data Source
      ..registerLazySingleton<HomeDataSource>(
        () => RemoteHomeDataSource(apiInterface: getIt<ApiInterface>()),
      )
      // Repository
      ..registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImp(
          homeDataSource: getIt<HomeDataSource>(),
          networkInfo: getIt<NetworkInfo>(),
        ),
      )
      // Use Cases
      ..registerLazySingleton<GetBrands>(
        () => GetBrands(homeRepository: getIt<HomeRepository>()),
      )
      ..registerLazySingleton<GetCategories>(
        () => GetCategories(homeRepository: getIt<HomeRepository>()),
      )
      ..registerLazySingleton<GetAllCategories>(
        () => GetAllCategories(homeRepository: getIt<HomeRepository>()),
      )
      // Bloc
      ..registerFactory<HomeBloc>(
        () => HomeBloc(
          getBrands: getIt<GetBrands>(),
          getCategories: getIt<GetCategories>(),
          getAllCategories: getIt<GetAllCategories>(),
        ),
      );
  }
}
