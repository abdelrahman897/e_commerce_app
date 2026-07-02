import 'package:e_commerce_app/core/errors/models/error_model.dart';

sealed class ServerException implements Exception {
  final ErrorModel errorModel;
  const ServerException(this.errorModel);

  String get message => errorModel.errorMessage;
  int get statusCode => errorModel.statusCode;
}

final class NetworkException extends ServerException {
  const NetworkException(super.errorModel);
}

final class UnauthorizedException extends ServerException {
  const UnauthorizedException(super.errorModel);
}

final class ForbiddenException extends ServerException {
  const ForbiddenException(super.errorModel);
}

final class NotFoundException extends ServerException {
  const NotFoundException(super.errorModel);
}

final class ConflictException extends ServerException {
  const ConflictException(super.errorModel);
}

final class GatewayTimeoutException extends ServerException {
  const GatewayTimeoutException(super.errorModel);
}

final class ConnectionTimeoutException extends ServerException {
  const ConnectionTimeoutException(super.errorModel);
}

final class ReceiveTimeoutException extends ServerException {
  const ReceiveTimeoutException(super.errorModel);
}

final class SendTimeoutException extends ServerException {
  const SendTimeoutException(super.errorModel);
}

final class ConnectionErrorException extends ServerException {
  const ConnectionErrorException(super.errorModel);
}

final class BadCertificateException extends ServerException {
  const BadCertificateException(super.errorModel);
}

final class RequestCancelledException extends ServerException {
  const RequestCancelledException(super.errorModel);
}

final class UnknownServerException extends ServerException {
  const UnknownServerException(super.errorModel);
}
