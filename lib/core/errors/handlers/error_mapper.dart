import 'package:e_commerce_app/core/errors/exceptions/google_auth_exception.dart';
import 'package:e_commerce_app/core/errors/exceptions/payment_exception.dart';
import 'package:e_commerce_app/core/errors/exceptions/server_exception.dart';
import 'package:e_commerce_app/core/errors/exceptions/cache_exception.dart';
import 'package:e_commerce_app/core/errors/failures/cache_failure.dart';
import 'package:e_commerce_app/core/errors/failures/failure.dart';
import 'package:e_commerce_app/core/errors/failures/google_auth_failure.dart';
import 'package:e_commerce_app/core/errors/failures/payment_failure.dart';
import 'package:e_commerce_app/core/errors/failures/server_failure.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';

class ErrorMapper {
  ErrorMapper._();

  static ServerFailure mapServerExceptionToFailure(ServerException exception) {
    return switch (exception) {
      UnauthorizedException e => ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
        errorCode: AppConstants.unauthorizedText,
      ),

      ForbiddenException e => ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
        errorCode: AppConstants.forbiddenText,
      ),

      NotFoundException e => ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
        errorCode: AppConstants.notFoundText,
      ),

      ConflictException e => ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
        errorCode: AppConstants.conflictText,
      ),

      GatewayTimeoutException e => ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
        errorCode: AppErrorMessages.gatewayTimeout,
      ),

      ConnectionErrorException _ => const ServerFailure.noInternet(),
      ConnectionTimeoutException _ => const ServerFailure.timeout(),
      ReceiveTimeoutException _ => const ServerFailure.timeout(),
      SendTimeoutException _ => const ServerFailure.timeout(),

      BadCertificateException e => ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
        errorCode: AppErrorMessages.badCertificate,
      ),

      RequestCancelledException _ => const ServerFailure(
        message: AppErrorMessages.requestCancelled,
        statusCode: 0,
      ),

      NetworkException e => ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
      ),

      UnknownServerException _ => const ServerFailure.unknown(),
    };
  }

  static CacheFailure mapCacheExceptionToFailure(CacheException exception) {
    return switch (exception) {
      CacheNotFoundException _ => const CacheFailure.notFound(),
      CacheReadException _ => const CacheFailure.readError(),
      CacheWriteException _ => const CacheFailure.writeError(),
      UnknownCacheException _ => const CacheFailure.unknown(),
    };
  }

  static GoogleAuthFailure mapGoogleAuthToFailure(
    GoogleAuthException exception,
  ) {
    return switch (exception) {
      GoogleSignInCancelledException() =>
        const GoogleAuthFailure.cancelledByUser(),
      GoogleSignInNoIdTokenException() => const GoogleAuthFailure.noIdToken(),
      GoogleSignInNoUserException() => const GoogleAuthFailure.noUser(),
    };
  }

  static PaymentFailure mapPaymentExceptionToFailure(
    PaymentException exception,
  ) {
    return switch (exception) {
      NetworkPaymentException e => NetworkPaymentFailure(message: e.message),
      StripePaymentException e => StripePaymentFailure(message: e.message),
      CancelledPaymentException _ => const CancelledPaymentFailure(),
      UnknownPaymentException _ => const UnknownPaymentFailure(),
    };
  }

  static Failure mapExceptionToFailure(Exception exception) {
    return switch (exception) {
      ServerException e => mapServerExceptionToFailure(e),
      CacheException e => mapCacheExceptionToFailure(e),
      GoogleAuthException e => mapGoogleAuthToFailure(e),
      PaymentException e => mapPaymentExceptionToFailure(e),
      _ => const ServerFailure.unknown(),
    };
  }
}
