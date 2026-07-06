import 'package:e_commerce_app/core/di_core/app_di_core.dart';
import 'package:e_commerce_app/core/handler/payment_handler/payment_interface_handler.dart';
import 'package:e_commerce_app/core/network_handler/network_info.dart';
import 'package:e_commerce_app/features/checkout/data/datasources/payment_data_source.dart';
import 'package:e_commerce_app/features/checkout/data/datasources/payment_remote_data_source.dart';
import 'package:e_commerce_app/features/checkout/data/repositories/payment_repository_imp.dart';
import 'package:e_commerce_app/features/checkout/domain/repositories/payment_repository.dart';
import 'package:e_commerce_app/features/checkout/domain/usecases/create_payment_intent.dart';
import 'package:e_commerce_app/features/checkout/presentation/manager/payment_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentDi {
  static void setup() {
    getIt
      // datasource
      ..registerLazySingleton<PaymentDataSource>(
        () => PaymentRemoteDataSource(
          paymentInterfaceHandler: getIt<PaymentInterfaceHandler>(),
        ),
      )
      //repository
      ..registerLazySingleton<PaymentRepository>(
        () => PaymentRepositoryImp(
          networkInfo: getIt<NetworkInfo>(),
          paymentDataSource: getIt<PaymentDataSource>(),
        ),
      )
      // usecases
      ..registerLazySingleton<CreatePaymentIntent>(
        () => CreatePaymentIntent(getIt<PaymentRepository>()),
      )
      // bloc
      ..registerFactory<PaymentBloc>(
        () => PaymentBloc(
          createPaymentIntent: getIt<CreatePaymentIntent>(),
          stripe: getIt<Stripe>(),
        ),
      );
  }
}
