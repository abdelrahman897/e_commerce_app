import 'package:e_commerce_app/core/network_handler/api_constants.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';

class ErrorModel {
  final int statusCode;
  final String errorMessage;
  final String? errorParam;

  const ErrorModel({
    required this.statusCode,
    required this.errorMessage,
    this.errorParam,
  });

  factory ErrorModel.unknownError() =>
      const ErrorModel(statusCode: 0, errorMessage: AppErrorMessages.unknown);

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    final errors = json[ApiKeys.errors];
    final String errorMessage;
    final String? errorParam;

    if (errors is Map<String, dynamic>) {
      errorMessage =
          errors[ApiKeys.errorMsg] as String? ??
          json[ApiKeys.message] as String? ??
          AppErrorMessages.unknown;
      errorParam = errors[ApiKeys.errorParam] as String?;
    } else {
      errorMessage =
          json[ApiKeys.message] as String? ?? AppErrorMessages.unknown;
      errorParam = null;
    }
    return ErrorModel(
      statusCode: json[ApiKeys.status] as int? ?? 0,
      errorMessage: errorMessage,
      errorParam: errorParam,
    );
  }

  @override
  String toString() =>
      'ErrorModel(status: $statusCode, message: $errorMessage, param: $errorParam)';
}
