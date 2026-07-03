import 'dart:async';
import 'package:e_commerce_app/core/params/params.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/services/profile_cached_service.dart';
import 'package:e_commerce_app/features/authentication/data/mappers/profile_google_mapper.dart';
import 'package:e_commerce_app/features/authentication/data/mappers/profile_mapper.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/profile.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/user.dart';
import 'package:e_commerce_app/features/authentication/domain/entities/user_google.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/add_address.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/delete_address.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_forget_password.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_sign_in.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_sign_in_or_sign_up_with_google.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_sign_out.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_sign_up.dart';
import 'package:e_commerce_app/features/authentication/domain/usecases/user_update_data.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  final UserSignIn _userSignIn;
  final UserSignUp _userSignUp;
  final UserSignOut _userSignOut;
  final UserForgetPassword _userForgetPassword;
  final DeleteAddress _deleteAddress;
  final AddAddress _addAddress;
  final UserUpdateData _userUpdateData;
  final UserSignInOrSignUpWithGoogle _userSignInOrSignUpWithGoogle;
  final ProfileCacheService _profileCacheService;
  Profile profile = const Profile(name: '', email: '');
  bool isSignIn = false;

  AuthenticationBloc({
    required UserSignIn userSignIn,
    required UserSignUp userSignUp,
    required UserForgetPassword userForgetPassword,
    required UserSignInOrSignUpWithGoogle userSignInOrSignUpWithGoogle,
    required DeleteAddress deleteAddress,
    required AddAddress addAddress,
    required UserUpdateData userUpdateData,
    required ProfileCacheService profileCacheService,
    required UserSignOut userSignOut,
  }) : _userSignOut = userSignOut,
       _deleteAddress = deleteAddress,
       _addAddress = addAddress,
       _userUpdateData = userUpdateData,
       _userSignInOrSignUpWithGoogle = userSignInOrSignUpWithGoogle,
       _userSignIn = userSignIn,
       _userSignUp = userSignUp,
       _userForgetPassword = userForgetPassword,
       _profileCacheService = profileCacheService,
       super(const AuthenticationInitialState()) {
    on<SignInEvent>(_onSignInEvent);
    on<SignUpEvent>(_onSignUpEvent);
    on<SignOutEvent>(_onSignOutEvent);
    on<ForgetPasswordEvent>(_onForgetPasswordEvent);
    on<SignInOrSignUpEvent>(_onSignInOrSignUpEvent);
    on<DeleteAddressEvent>(_onDeleteAddressEvent);
    on<AddAddressEvent>(_onAddAddressEvent);
    on<UpdateUserDataEvent>(_onUpdateUserDataEvent);
    on<LoadCachedProfileEvent>(_onLoadCachedProfileEvent);

    add(const LoadCachedProfileEvent());
  }
  FutureOr<void> _onLoadCachedProfileEvent(
    LoadCachedProfileEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    final cached = await _profileCacheService.getCachedProfile();
    if (cached != null) {
      isSignIn = true;
      profile = cached;
      emit(ProfileCachedState(profile: cached));
    }
  }

  FutureOr<void> _onSignInEvent(
    SignInEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoadingState());
    final result = await _userSignIn.call(params: event.signInParams);
    result.fold(
      (failure) {
        emit(AuthenticationFailureState(failureMessage: failure.message));
      },
      (success) {
        isSignIn = true;
        emit(SignInSuccessState(user: success));
      },
    );
  }

  FutureOr<void> _onSignUpEvent(
    SignUpEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoadingState());
    final result = await _userSignUp.call(params: event.signUpParams);
    result.fold(
      (failure) =>
          emit(AuthenticationFailureState(failureMessage: failure.message)),
      (success) {
        profile = event.signUpParams.toEntity;

        emit(SignUpSuccessState(user: success));
      },
    );
    if (result.isRight()) {
      _profileCacheService.saveData(profile: profile);
    }
  }

  FutureOr<void> _onSignOutEvent(
    SignOutEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoadingState());
    final result = await _userSignOut();
    result.fold(
      (failure) {
        emit(AuthenticationFailureState(failureMessage: failure.message));
      },
      (success) {
        isSignIn = false;
        emit(SignOutSuccessState());
      },
    );
  }

  FutureOr<void> _onForgetPasswordEvent(
    ForgetPasswordEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoadingState());
    final result = await _userForgetPassword.call(
      params: event.forgetPasswordParams,
    );
    result.fold(
      (failure) {
        emit(AuthenticationFailureState(failureMessage: failure.message));
      },
      (success) {
        emit(ForgetPasswordSuccessState());
      },
    );
  }

  FutureOr<void> _onSignInOrSignUpEvent(
    SignInOrSignUpEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoadingState());
    final result = await _userSignInOrSignUpWithGoogle.call();
    result.fold(
      (failure) {
        emit(AuthenticationFailureState(failureMessage: failure.message));
      },
      (success) {
        profile = success.toEntity;
        isSignIn = true;
        emit(SignInOrSignUpWithGoogleSuccessState(user: success));
      },
    );
    if (result.isRight()) {
      _profileCacheService.saveData(profile: profile);
    }
  }

  FutureOr<void> _onDeleteAddressEvent(
    DeleteAddressEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoadingState());
    final result = await _deleteAddress.call(params: event.addressParams);
    result.fold(
      (failure) =>
          emit(AuthenticationFailureState(failureMessage: failure.message)),
      (success) {
        profile = profile.copyWith(address: null);
        emit(const DeleteAddressSuccessState());
      },
    );
    if (result.isRight()) {
      _profileCacheService.clearField(key: AppStorageKeys.address);
    }
  }

  FutureOr<void> _onAddAddressEvent(
    AddAddressEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoadingState());
    final result = await _addAddress.call(params: event.addressParams);
    result.fold(
      (failure) =>
          emit(AuthenticationFailureState(failureMessage: failure.message)),
      (success) {
        profile = profile.copyWith(address: success.addresses.first);
        emit(const UpdateProfileSuccessState());
      },
    );
    if (result.isRight()) {
      _profileCacheService.saveData(profile: profile);
    }
  }

  FutureOr<void> _onUpdateUserDataEvent(
    UpdateUserDataEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoadingState());
    final result = await _userUpdateData.call(params: event.updateDataParams);
    result.fold(
      (failure) =>
          emit(AuthenticationFailureState(failureMessage: failure.message)),
      (success) {
        profile = profile.copyWith(
          email: event.updateDataParams.email,
          name: event.updateDataParams.name,
          phoneNumber: event.updateDataParams.phone,
        );
        emit(const UpdateProfileSuccessState());
      },
    );
    if (result.isRight()) {
      _profileCacheService.saveData(profile: profile);
    }
  }

  @override
  AuthenticationState? fromJson(Map<String, dynamic> json) {
    try {
      isSignIn = json[AppStorageKeys.isSignIn] as bool? ?? false;
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthenticationState state) {
    return {AppStorageKeys.isSignIn: isSignIn};
  }
}
