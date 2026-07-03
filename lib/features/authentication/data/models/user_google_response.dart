import 'package:e_commerce_app/features/authentication/data/models/sub_models/user_google_model.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserGoogleResponse extends Equatable {
  final UserGoogleModel userGoogle;
  final String token;

  const UserGoogleResponse({required this.token, required this.userGoogle});

  factory UserGoogleResponse.fromFirebaseCredential({
    required UserInfo userInfo,
    required String token,
  }) {
    return UserGoogleResponse(
      token: token,
      userGoogle: UserGoogleModel.fromJson(userInfo),
    );
  }

  @override
  List<Object> get props => [token, userGoogle];
}
