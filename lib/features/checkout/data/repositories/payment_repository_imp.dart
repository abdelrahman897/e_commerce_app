import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/exceptions/server_exception.dart';
import 'package:e_commerce_app/core/errors/failures/failure.dart';
import 'package:e_commerce_app/core/errors/failures/server_failure.dart';
import 'package:e_commerce_app/core/errors/handlers/error_mapper.dart';
import 'package:e_commerce_app/core/network_handler/network_info.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/features/checkout/data/datasources/payment_data_source.dart';
import 'package:e_commerce_app/features/checkout/data/mappers/payment_mapper.dart';
import 'package:e_commerce_app/features/checkout/domain/entities/payment.dart';
import 'package:e_commerce_app/features/checkout/domain/repositories/payment_repository.dart';

class PaymentRepositoryImp implements PaymentRepository {
  final PaymentDataSource _paymentDataSource;
  final NetworkInfo _networkInfo;
  const PaymentRepositoryImp({
    required PaymentDataSource paymentDataSource,
    required NetworkInfo networkInfo,
  }) : _paymentDataSource = paymentDataSource,
       _networkInfo = networkInfo;
  @override
  Future<Either<Failure, Payment>> createPaymentIntent({
    required PaymentParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final model = await _paymentDataSource.createPaymentIntent(
          params: params,
        );
        return Right(model.toEntity);
      } on ServerException catch (serverException) {
        return Left(ErrorMapper.mapServerExceptionToFailure(serverException));
      }
    } else {
      return const Left(ServerFailure.noInternet());
    }
  }
}
