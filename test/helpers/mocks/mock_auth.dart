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
import 'package:e_commerce_app/features/authentication/domain/usecases/user_sign_out.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_sign_up.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_update_data.dart';
import 'package:e_commerce_app/core/services/profile_cached_service.dart';
import 'package:e_commerce_app/features/authentication/presentation/manager/authentication_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  // ── Infrastructure ────────────────────────────────────────────────────────
  ApiInterface,
  NetworkInfo,
  AuthInterfaceHandler,
  UserInfo,

  // ── Authentication Feature ────────────────────────────────────────────────
  AuthenticationDataSource,
  AuthenticationRepository,
  NavigatorObserver,
  // ── Use Cases ─────────────────────────────────────────────────────────────
  UserSignIn,
  UserSignUp,
  UserForgetPassword,
  UserSignInOrSignUpWithGoogle,
  AddAddress,
  DeleteAddress,
  UserUpdateData,
  UserSignOut,
  ProfileCacheService,
  // Bloc
  AuthenticationBloc,
])
void main() {}
