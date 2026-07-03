import 'package:e_commerce_app/core/network_handler/api_constants.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String name;
  final String email;
  final String role;

  const UserModel({
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json[ApiKeys.name] as String,
      email: json[ApiKeys.email] as String,
      role: json[ApiKeys.role] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {ApiKeys.name: name, ApiKeys.email: email, ApiKeys.role: role};
  }

  @override
  List<Object> get props => [name, email, role];
}
