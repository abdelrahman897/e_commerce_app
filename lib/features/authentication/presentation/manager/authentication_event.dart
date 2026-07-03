part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
  @override
  List<Object> get props => [];
}

final class LoadCachedProfileEvent extends AuthenticationEvent {
  const LoadCachedProfileEvent();
}

final class SignInEvent extends AuthenticationEvent {
  final SignInParams signInParams;
  const SignInEvent({required this.signInParams});

  @override
  List<Object> get props => [signInParams];
}

final class SignUpEvent extends AuthenticationEvent {
  final SignUpParams signUpParams;
  const SignUpEvent({required this.signUpParams});

  @override
  List<Object> get props => [signUpParams];
}

final class ForgetPasswordEvent extends AuthenticationEvent {
  final ForgetPasswordParams forgetPasswordParams;
  const ForgetPasswordEvent({required this.forgetPasswordParams});

  @override
  List<Object> get props => [forgetPasswordParams];
}

final class SignInOrSignUpEvent extends AuthenticationEvent {
  const SignInOrSignUpEvent();
}

final class AddAddressEvent extends AuthenticationEvent {
  final AddressParams addressParams;
  const AddAddressEvent({required this.addressParams});

  @override
  List<Object> get props => [addressParams];
}

final class DeleteAddressEvent extends AuthenticationEvent {
  final AddressParams addressParams;
  const DeleteAddressEvent({required this.addressParams});

  @override
  List<Object> get props => [addressParams];
}

final class UpdateUserDataEvent extends AuthenticationEvent {
  final UserUpdateDataParams updateDataParams;
  const UpdateUserDataEvent({required this.updateDataParams});

  @override
  List<Object> get props => [updateDataParams];
}

final class SignOutEvent extends AuthenticationEvent {
  const SignOutEvent();  
}