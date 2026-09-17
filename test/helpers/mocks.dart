// 📁 test/helpers/mocks.dart
//
// كل الـ @GenerateMocks في ملف واحد.
// بعد أي تعديل → شغّل:
//   dart run build_runner build --delete-conflicting-outputs
// هيتولد ملف: test/helpers/mocks.mocks.dart

import 'package:mockito/annotations.dart';
import 'package:e_commerce_app/core/handler/authentication_handler/auth_interface_handler.dart';
import 'package:e_commerce_app/core/network_handler/api_interface.dart';
import 'package:e_commerce_app/core/network_handler/network_info.dart';
import 'package:e_commerce_app/features/authentication/data/datasources/authentication_data_source.dart';
import 'package:e_commerce_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/add_address.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/delete_address.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_forget_password.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_sign_in.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_sign_in_or_sign_up_with_google.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_sign_up.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_update_data.dart';

@GenerateMocks([
  // ── Infrastructure ────────────────────────────────────────────────────────
  ApiInterface,
  NetworkInfo,
  AuthInterfaceHandler,

  // ── Authentication Feature ────────────────────────────────────────────────
  AuthenticationDataSource,
  AuthenticationRepository,

  // ── Use Cases ─────────────────────────────────────────────────────────────
  UserSignIn,
  UserSignUp,
  UserForgetPassword,
  UserSignInOrSignUpWithGoogle,
  AddAddress,
  DeleteAddress,
  UserUpdateData,
])
void main() {}
