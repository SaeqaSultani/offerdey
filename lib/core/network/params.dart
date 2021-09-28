import 'package:equatable/equatable.dart';

class RegisterParam extends Equatable {
  final String? name;
  final String? email;
  final String? password;
  final String? vehicleNumber;
  final String? vehicleColor;
  final String? vehicleModel;

  final String? contactNumber;
  final String? referBy;

  const RegisterParam({
    this.name,
    this.email,
    this.password,
    this.vehicleNumber,
    this.vehicleColor,
    this.vehicleModel,
    this.referBy,
    this.contactNumber,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        vehicleNumber,
        vehicleColor,
        vehicleModel,
        referBy,
        contactNumber,
      ];
}

class LoginParam {
  final String email;
  final String password;

  LoginParam({
    required this.email,
    required this.password,
  });
}

class ForgotPasswordParam {
  final String email;

  ForgotPasswordParam({
    required this.email,
  });
}

class DocumentParam {
  final int vendorId;
  final String profilePicPath;
  final String licenceFrontPath;
  final String licenceBackPath;
  final String cnicFrontPath;
  final String cnicBackPath;

  DocumentParam({
    required this.vendorId,
    required this.profilePicPath,
    required this.licenceFrontPath,
    required this.licenceBackPath,
    required this.cnicFrontPath,
    required this.cnicBackPath,
  });
}
