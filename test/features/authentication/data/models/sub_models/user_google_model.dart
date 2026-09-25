import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserGoogleModel extends Equatable {
  final String? id;
  final String? name;
  final String? email;
  final String? phoneNumber;

  const UserGoogleModel({this.name, this.email, this.phoneNumber, this.id});

  factory UserGoogleModel.fromJson(UserInfo user) {
    return UserGoogleModel(
      id: user.uid,
      name: user.displayName,
      email: user.email,
      phoneNumber: user.phoneNumber,
    );
  }

  @override
  List<Object?> get props => [name, email, phoneNumber, id];
}
