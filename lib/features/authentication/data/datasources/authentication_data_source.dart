import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/errors/exceptions/google_auth_exception.dart';
import 'package:e_commerce_app/core/errors/handlers/dio_exception_handler.dart';
import 'package:e_commerce_app/core/errors/models/error_model.dart';
import 'package:e_commerce_app/core/network_handler/api_interface.dart';
import 'package:e_commerce_app/core/network_handler/end_point.dart';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/features/authentication/data/models/address_model.dart';
import 'package:e_commerce_app/features/authentication/data/models/user_google_response.dart';
import 'package:e_commerce_app/features/authentication/data/models/authentication_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract interface class AuthenticationDataSource {
  // sign-in
  Future<AuthenticatedUserModel> signInWithCredentials({
    required SignInParams params,
  });

  // sign-up
  Future<AuthenticatedUserModel> signUpWithCredentials({
    required SignUpParams params,
  });

  // forget-password
  Future<AuthenticatedUserModel> forgetPasswordWithCredentials({
    required ForgetPasswordParams params,
  });

  // update profile
  Future<AuthenticatedUserModel> updateUserData({
    required UserUpdateDataParams params,
  });

  // address
  Future<AddressModel> addAddress({required AddressParams params});

  Future<void> deleteAddress({required AddressParams params});

  // sign-in or up with google
  Future<UserGoogleResponse> signInOrSignUpWithGoogle();
  // sign-out
  Future<void> signOut();
}

class RemoteAuthenticationDataSource implements AuthenticationDataSource {
  const RemoteAuthenticationDataSource({required ApiInterface apiInterface})
    : _apiInterface = apiInterface;

  final ApiInterface _apiInterface;

  @override
  Future<AuthenticatedUserModel> signInWithCredentials({
    required SignInParams params,
  }) async {
    try {
      final response = await _apiInterface.post(
        EndPoint.signIn,
        body: params.toJson(),
      );
      return AuthenticatedUserModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (dioException) {
      throw DioExceptionHandler.handle(dioException);
    }
  }

  @override
  Future<AuthenticatedUserModel> signUpWithCredentials({
    required SignUpParams params,
  }) async {
    try {
      final response = await _apiInterface.post(
        EndPoint.signUp,
        body: params.toJson(),
      );
      return AuthenticatedUserModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (dioException) {
      throw DioExceptionHandler.handle(dioException);
    }
  }

  @override
  Future<AuthenticatedUserModel> forgetPasswordWithCredentials({
    required ForgetPasswordParams params,
  }) async {
    try {
      final response = await _apiInterface.post(
        EndPoint.forgotPassword,
        body: params.toJson(),
      );
      return AuthenticatedUserModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (dioException) {
      throw DioExceptionHandler.handle(dioException);
    }
  }

  @override
  Future<UserGoogleResponse> signInOrSignUpWithGoogle() async {
    try {
      GoogleSignIn.instance.initialize(
        serverClientId: EnvKeys.googleClientId,
      );
      final GoogleSignInAccount? googleUser = await GoogleSignIn.instance
          .authenticate();

      if (googleUser == null) {
        throw const GoogleSignInCancelledException();
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final String? idToken = googleAuth.idToken;

      if (idToken == null) {
        throw const GoogleSignInNoIdTokenException();
      }

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final UserCredential model = await FirebaseAuth.instance
          .signInWithCredential(credential);

      

      final userInfo = model.user!.providerData.single;
      return UserGoogleResponse.fromFirebaseCredential(
        userInfo: userInfo,
        token: idToken,
      );
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        throw const GoogleSignInCancelledException();
      }
      throw GoogleSignInNoIdTokenException();
    } on FirebaseAuthException catch (error) {
      throw ErrorModel(
        statusCode: 0,
        errorMessage: error.message ?? 'Google authentication failed',
      );
    }
  }

  @override
  Future<AddressModel> addAddress({required AddressParams params}) async {
    try {
      final response = await _apiInterface.post(
        EndPoint.addresses,
        body: params.toJson(),
      );
      return AddressModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (dioException) {
      throw DioExceptionHandler.handle(dioException);
    }
  }

  @override
  Future<void> deleteAddress({required AddressParams params}) async {
    try {
      await _apiInterface.delete('${EndPoint.addresses}/${params.userId}');
    } on DioException catch (dioException) {
      throw DioExceptionHandler.handle(dioException);
    }
  }

  @override
  Future<AuthenticatedUserModel> updateUserData({
    required UserUpdateDataParams params,
  }) async {
    try {
      final response = await _apiInterface.put(
        EndPoint.updateUserData,
        body: params.toJson(),
      );
      return AuthenticatedUserModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (dioException) {
      throw DioExceptionHandler.handle(dioException);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (error) {
      throw ErrorModel(
        statusCode: 0,
        errorMessage: error.message ?? 'Google authentication failed',
      );
    }
  }
}
