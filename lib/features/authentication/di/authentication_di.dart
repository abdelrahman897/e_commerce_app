import 'package:e_commerce_app/core/di_core/app_di_core.dart';
import 'package:e_commerce_app/core/handler/authentication_handler/auth_interface_handler.dart';
import 'package:e_commerce_app/core/network_handler/api_interface.dart';
import 'package:e_commerce_app/core/network_handler/network_info.dart';
import 'package:e_commerce_app/core/services/profile_cached_service.dart';
import 'package:e_commerce_app/core/storage_handler/local_storage_handler_interface.dart';
import 'package:e_commerce_app/features/authentication/data/datasources/authentication_data_source.dart';
import 'package:e_commerce_app/features/authentication/data/repositories/authentication_repository_imp.dart';
import 'package:e_commerce_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/add_address.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/delete_address.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_forget_password.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_sign_in.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_sign_in_or_sign_up_with_google.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_sign_out.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_sign_up.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_update_data.dart';
import 'package:e_commerce_app/features/authentication/presentation/manager/authentication_bloc.dart';

class AuthenticationDi {
  static void setup() {
    getIt
      // ── Data Source ────────────────────────────────────────────────────
      ..registerLazySingleton<AuthenticationDataSource>(
        () =>
            RemoteAuthenticationDataSource(apiInterface: getIt<ApiInterface>()),
      )
      // ── Repository ─────────────────────────────────────────────────────
      ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImp(
          authenticationDataSource: getIt<AuthenticationDataSource>(),
          networkInfo: getIt<NetworkInfo>(),
          authInterfaceHandler: getIt<AuthInterfaceHandler>(),
        ),
      )
      ..registerLazySingleton<ProfileCacheService>(
        () => ProfileCacheService(
          localStorage: getIt<LocalStorageHandlerInterface>(),
        ),
      )
      // ── Use Cases ──────────────────────────────────────────────────────
      ..registerLazySingleton<UserSignIn>(
        () => UserSignIn(getIt<AuthenticationRepository>()),
      )
      ..registerLazySingleton<UserSignUp>(
        () => UserSignUp(getIt<AuthenticationRepository>()),
      )
      ..registerLazySingleton<UserSignOut>(
        () => UserSignOut(getIt<AuthenticationRepository>()),
      )
      ..registerLazySingleton<UserForgetPassword>(
        () => UserForgetPassword(getIt<AuthenticationRepository>()),
      )
      ..registerLazySingleton<UserSignInOrSignUpWithGoogle>(
        () => UserSignInOrSignUpWithGoogle(getIt<AuthenticationRepository>()),
      )
      ..registerLazySingleton<AddAddress>(
        () => AddAddress(getIt<AuthenticationRepository>()),
      )
      ..registerLazySingleton<DeleteAddress>(
        () => DeleteAddress(getIt<AuthenticationRepository>()),
      )
      ..registerLazySingleton<UserUpdateData>(
        () => UserUpdateData(getIt<AuthenticationRepository>()),
      )
      // ── BLoC ───────────────────────────────────────────────────────────
      ..registerFactory<AuthenticationBloc>(
        () => AuthenticationBloc(
          profileCacheService: getIt<ProfileCacheService>(),
          userSignIn: getIt<UserSignIn>(),
          userSignUp: getIt<UserSignUp>(),
          userForgetPassword: getIt<UserForgetPassword>(),
          userSignInOrSignUpWithGoogle: getIt<UserSignInOrSignUpWithGoogle>(),
          addAddress: getIt<AddAddress>(),
          deleteAddress: getIt<DeleteAddress>(),
          userUpdateData: getIt<UserUpdateData>(),
          userSignOut: getIt<UserSignOut>(),
        ),
      );
  }
}
