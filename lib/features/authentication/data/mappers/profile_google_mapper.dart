import 'package:e_commerce_app/features/authentication/domain/entities/profile.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/user_google.dart';

extension ProfileGoogleMapper on UserGoogle {
  Profile get toEntity => Profile(
    name: name ?? '',
    email: email ?? '',
    phoneNumber: phoneNumber ?? '',
  );
}
