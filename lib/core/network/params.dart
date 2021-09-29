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
  final String? regStatus;
  final String? profilePicPath;

  const RegisterParam({
    this.name,
    this.email,
    this.password,
    this.vehicleNumber,
    this.vehicleColor,
    this.vehicleModel,
    this.referBy,
    this.contactNumber,
    this.regStatus = 'email',
    this.profilePicPath,
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
        profilePicPath,
        regStatus,
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

class DocumentParam extends Equatable {
  final int riderId;
  final String depositAmountSlipPath;
  final String licenceFrontPath;
  final String licenceBackPath;
  final String cnicFrontPath;
  final String cnicBackPath;

  const DocumentParam({
    required this.riderId,
    required this.depositAmountSlipPath,
    required this.licenceFrontPath,
    required this.licenceBackPath,
    required this.cnicFrontPath,
    required this.cnicBackPath,
  });

  @override
  List<Object?> get props => [
        riderId,
        depositAmountSlipPath,
        licenceFrontPath,
        licenceBackPath,
        cnicFrontPath,
        cnicBackPath,
      ];
}
