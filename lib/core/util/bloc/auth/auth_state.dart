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
            riderId: -1,
            method: LoginMethod.none,
            token: '',
            documentSubmitted: false,
          ),
        );
}

class AuthLoading extends AuthState {
  const AuthLoading(Auth auth) : super(auth);
}

class AuthRegisteredSuccess extends AuthState {
  const AuthRegisteredSuccess(Auth auth) : super(auth);
}

class AuthLoaded extends AuthState {
  const AuthLoaded(Auth auth) : super(auth);
}

class NoAuth extends AuthState {
  final Failure? failure;
  const NoAuth({this.failure, required Auth auth}) : super(auth);
}

class AuthDocumentSubmitted extends AuthState {
  const AuthDocumentSubmitted(Auth auth) : super(auth);
}

class UploadFailed extends AuthState {
  final Failure? failure;
  const UploadFailed({this.failure, required Auth auth}) : super(auth);
}
