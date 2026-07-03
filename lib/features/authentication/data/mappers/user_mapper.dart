import 'package:e_commerce_app/features/authentication/data/models/sub_models/user_model.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/user.dart';

extension UserMapper on UserModel {
  User get toEntity => User(name: name, email: email, role: role);
}
