part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class InitUser extends UserEvent {
  const InitUser();
}

class LoginWithFacebook extends UserEvent {
  const LoginWithFacebook();
}

class LoginWithGoogle extends UserEvent {
  const LoginWithGoogle();
}

class LoginWithEmail extends UserEvent {
  const LoginWithEmail();
}

class LogoutWithFacebook extends UserEvent {
  const LogoutWithFacebook();
}

class LogoutWithGoogle extends UserEvent {
  const LogoutWithGoogle();
}

class LogoutWithEmail extends UserEvent {
  const LogoutWithEmail();
}

class SignupWithEmail extends UserEvent {
  const SignupWithEmail();
}
