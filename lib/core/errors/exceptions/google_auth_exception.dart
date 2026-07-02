import 'package:e_commerce_app/core/resources/constants_manager.dart';

sealed class GoogleAuthException implements Exception {
  final String errorMessage;
  const GoogleAuthException({required this.errorMessage});

  @override
  String toString() => 'GoogleSignInException: $errorMessage';
}

class GoogleSignInCancelledException extends GoogleAuthException {
  const GoogleSignInCancelledException()
    : super(errorMessage: GoogleAuthErrorMessages.cancelledByUser);
}

class GoogleSignInNoIdTokenException extends GoogleAuthException {
  const GoogleSignInNoIdTokenException()
    : super(errorMessage: GoogleAuthErrorMessages.noIdToken);
}

class GoogleSignInNoUserException extends GoogleAuthException {
  const GoogleSignInNoUserException()
    : super(errorMessage: GoogleAuthErrorMessages.noUserReturned);
}
