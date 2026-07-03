import 'package:e_commerce_app/core/network_handler/api_constants.dart';
import 'package:e_commerce_app/features/authentication/data/models/sub_models/user_model.dart';
import 'package:equatable/equatable.dart';

class AuthenticatedUserModel extends Equatable {
  final String message;
  final UserModel? user;
  final String? statusMsg;
  final String? token;

  const AuthenticatedUserModel({
    required this.message,
    this.user,
    this.token,
    this.statusMsg,
  });

  factory AuthenticatedUserModel.fromJson(Map<String, dynamic> json) {
    return AuthenticatedUserModel(
      message: json[ApiKeys.message] as String,
      user: json[ApiKeys.user] == null
          ? null
          : UserModel.fromJson(json[ApiKeys.user] as Map<String, dynamic>),
      token: json[ApiKeys.token] as String?,
      statusMsg: json[ApiKeys.statusMsg] as String?,
    );
  }

  @override
  List<Object?> get props => [message, user, token, statusMsg];
}
