import 'package:equatable/equatable.dart';

class UserGoogle extends Equatable {
  final String? id;
  final String? name;
  final String? email;
  final String? phoneNumber;

  const UserGoogle({this.name, this.email, this.phoneNumber, this.id});

  @override
  List<Object?> get props => [name, email, phoneNumber, id];
}
