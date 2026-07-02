import 'package:e_commerce_app/core/errors/failures/failure.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';

class GoogleAuthFailure extends Failure {
  final String? errorCode;

  const GoogleAuthFailure({
    required super.message,
    this.errorCode,
    super.statusCode,
  });

  const GoogleAuthFailure.cancelledByUser()
    : errorCode = AppConstants.googleCancelledText,
      super(message: AppErrorMessages.googleSignInCancelled, statusCode: 0);

  const GoogleAuthFailure.noIdToken()
    : errorCode = AppConstants.googleNoIdTokenText,
      super(message: AppErrorMessages.googleNoIdToken, statusCode: 0);

  const GoogleAuthFailure.noUser()
    : errorCode = AppConstants.googleNoUserText,
      super(message: AppErrorMessages.googleNoUser, statusCode: 0);

  const GoogleAuthFailure.unknown()
    : errorCode = AppConstants.unknownText,
      super(message: AppErrorMessages.unknown, statusCode: 0);

  @override
  List<Object?> get props => [message, statusCode, errorCode];
}
