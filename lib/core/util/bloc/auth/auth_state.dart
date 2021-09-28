part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final Auth auth;

  const AuthState(this.auth);

  @override
  List<Object> get props => [auth];
}

class AuthInitial extends AuthState {
  const AuthInitial()
      : super(
          const Auth(
            vendorId: -1,
            method: LoginMethod.none,
          ),
        );
}

class AuthLoading extends AuthState {
  const AuthLoading()
      : super(
          const Auth(
            vendorId: -1,
            method: LoginMethod.none,
          ),
        );
}

class AuthRegisteredSuccess extends AuthState {
  const AuthRegisteredSuccess(Auth auth) : super(auth);
}

class AuthLoaded extends AuthState {
  const AuthLoaded(Auth auth) : super(auth);
}

class NoAuth extends AuthState {
  final Failure? failure;
  const NoAuth({this.failure})
      : super(
          const Auth(
            vendorId: -1,
            method: LoginMethod.none,
          ),
        );
}

class AuthAccountVerified extends AuthState {
  const AuthAccountVerified(Auth auth) : super(auth);
}
