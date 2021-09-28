import 'package:equatable/equatable.dart';

enum LoginMethod { facebook, google, email, none }

class Auth extends Equatable {
  final int vendorId;
  final LoginMethod method;

  const Auth({required this.vendorId, required this.method});

  @override
  List<Object?> get props => [vendorId, method];
}
