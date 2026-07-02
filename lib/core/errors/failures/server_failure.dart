import 'package:e_commerce_app/core/errors/failures/failure.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';

class ServerFailure extends Failure {
  final String? errorCode;

  const ServerFailure({
    required super.statusCode,
    required super.message,
    this.errorCode,
  });

  const ServerFailure.unauthorized()
    : errorCode = AppConstants.unauthorizedText,
      super(message: AppErrorMessages.unauthorized, statusCode: 401);

  const ServerFailure.notFound()
    : errorCode = AppConstants.notFoundText,
      super(message: AppErrorMessages.notFound, statusCode: 404);

  const ServerFailure.noInternet()
    : errorCode = AppConstants.noInternetText,
      super(message: AppErrorMessages.noInternet, statusCode: 0);

  const ServerFailure.timeout()
    : errorCode = AppConstants.timeOutText,
      super(message: AppErrorMessages.timeout, statusCode: 0);

  const ServerFailure.unknown()
    : errorCode = AppConstants.unknownText,
      super(message: AppErrorMessages.unknown, statusCode: 0);

  ServerFailure copyWith({
    String? message,
    int? statusCode,
    String? errorCode,
  }) {
    return ServerFailure(
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
      errorCode: errorCode ?? this.errorCode,
    );
  }

  @override
  List<Object?> get props => [message, statusCode, errorCode];
}
