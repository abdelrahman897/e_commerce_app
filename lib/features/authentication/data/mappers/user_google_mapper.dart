import 'package:e_commerce_app/features/authentication/data/models/sub_models/user_google_model.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/user_google.dart';

extension UserGoogleMapper on UserGoogleModel {
  UserGoogle get toEntity =>
      UserGoogle(email: email, id: id, name: name, phoneNumber: phoneNumber);
}
