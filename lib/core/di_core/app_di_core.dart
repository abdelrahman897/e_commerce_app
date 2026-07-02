import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_commerce_app/core/cubit/language/language_cubit.dart';
import 'package:e_commerce_app/core/cubit/onboarding/onboarding_cubit.dart';
import 'package:e_commerce_app/core/cubit/theme/theme_cubit.dart';
import 'package:e_commerce_app/core/handler/authentication_handler/auth_handler_secure_storage.dart';
import 'package:e_commerce_app/core/handler/authentication_handler/auth_interface_handler.dart';
import 'package:e_commerce_app/core/handler/payment_handler/payment_interface_handler.dart';
import 'package:e_commerce_app/core/network_handler/api_interface.dart';
import 'package:e_commerce_app/core/network_handler/dio_api_client.dart';
import 'package:e_commerce_app/core/handler/payment_handler/dio_payment_client.dart';
import 'package:e_commerce_app/core/network_handler/network_info.dart';
import 'package:e_commerce_app/core/storage_handler/hive_storage_client.dart';
import 'package:e_commerce_app/core/storage_handler/local_storage_handler_interface.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

abstract final class AppDiCore {
  AppDiCore._();
  static Future<void> setup() async {
    await _registerStorage();
    _registerAuth();
    _registerCubits();
    _registerNetwork();
    _registerPayment();
  }

  static Future<void> _registerStorage() async {
    final prefs = await SharedPreferences.getInstance();
    getIt.registerSingleton<SharedPreferences>(prefs);

    getIt.registerSingleton<FlutterSecureStorage>(
      const FlutterSecureStorage(
        aOptions: AndroidOptions(),
        iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
      ),
    );

    getIt.registerLazySingleton<LocalStorageHandlerInterface>(
      () => HiveStorageClient(),
    );
  }

  static void _registerCubits() {
    getIt
      ..registerLazySingleton<ThemeCubit>(() => ThemeCubit())
      ..registerLazySingleton<LanguageCubit>(() => LanguageCubit())
      ..registerLazySingleton<OnboardingCubit>(
        () => OnboardingCubit(prefs: getIt<SharedPreferences>()),
      );
  }

  static void _registerNetwork() {
    getIt.registerLazySingleton<Connectivity>(() => Connectivity());
    getIt.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImp(connectivity: getIt<Connectivity>()),
    );
    getIt.registerLazySingleton<ApiInterface>(() => DioApiClient());
    getIt.registerLazySingleton<PaymentInterfaceHandler>(
      () => DioPaymentClient(),
    );
  }

  static void _registerAuth() {
    getIt.registerLazySingleton<AuthInterfaceHandler>(
      () => AuthHandlerSecureStorage(
        secureStorage: getIt<FlutterSecureStorage>(),
      ),
    );
  }

  static void _registerPayment() async {
    getIt.registerLazySingleton<Stripe>(() => Stripe.instance);
  }
}
