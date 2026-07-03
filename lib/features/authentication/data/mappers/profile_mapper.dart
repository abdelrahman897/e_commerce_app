import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/profile.dart';

extension ProfileMapper on SignUpParams {
  Profile get toEntity => Profile(name: name, email: email, phoneNumber: phone);
}
