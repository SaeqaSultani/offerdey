import 'package:equatable/equatable.dart';

enum LoginMethod { facebook, google, email, none }

class Auth extends Equatable {
  final int riderId;
  final String token;
  final LoginMethod method;
  final bool documentSubmitted;

  const Auth({
    required this.riderId,
    required this.method,
    required this.token,
    required this.documentSubmitted,
  });

  @override
  List<Object?> get props => [riderId, method, token, documentSubmitted];
}
