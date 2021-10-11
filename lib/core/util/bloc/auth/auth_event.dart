part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignupWithEmail extends AuthEvent {
  final RegisterParam params;
  const SignupWithEmail(this.params);
}

class UploadDocuments extends AuthEvent {
  final DocumentParam params;
  const UploadDocuments(this.params);
}

class LoginWithEmail extends AuthEvent {
  final LoginParam params;
  const LoginWithEmail(this.params);

  @override
  List<Object> get props => [];
}

class ForgetPassword extends AuthEvent {
  final ForgotPasswordParam params;
  const ForgetPassword(this.params);
}
