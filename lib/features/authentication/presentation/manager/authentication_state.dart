part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object> get props => [];
}

final class AuthenticationInitialState extends AuthenticationState {
  const AuthenticationInitialState();
}

final class AuthenticationLoadingState extends AuthenticationState {
  const AuthenticationLoadingState();
}

final class SignInSuccessState extends AuthenticationState {
  final User user;
  const SignInSuccessState({required this.user});
  @override
  List<Object> get props => [user];
}

final class SignUpSuccessState extends AuthenticationState {
  final User user;
  const SignUpSuccessState({required this.user});
  @override
  List<Object> get props => [user];
}

final class SignOutSuccessState extends AuthenticationState {
  const SignOutSuccessState();
}


final class SignInOrSignUpWithGoogleSuccessState extends AuthenticationState {
  final UserGoogle user;
  const SignInOrSignUpWithGoogleSuccessState({required this.user});
  @override
  List<Object> get props => [user];
}

final class ForgetPasswordSuccessState extends AuthenticationState {
  const ForgetPasswordSuccessState();
}

final class AuthenticationFailureState extends AuthenticationState {
  final String failureMessage;
  const AuthenticationFailureState({required this.failureMessage});
  @override
  List<Object> get props => [failureMessage];
}

final class DeleteAddressSuccessState extends AuthenticationState {
  const DeleteAddressSuccessState();
}

final class UpdateProfileSuccessState extends AuthenticationState {
  const UpdateProfileSuccessState();
}

final class ProfileCachedState extends AuthenticationState {
  final Profile profile;

  const ProfileCachedState({required this.profile});

  @override
  List<Object> get props => [profile];
}

final class ProfileEmptyState extends AuthenticationState {
  const ProfileEmptyState();
}
