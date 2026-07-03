import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String email;
  final String role;
  const User({required this.name, required this.email, required this.role});

  @override
  List<Object> get props => [email, name, role];
}
