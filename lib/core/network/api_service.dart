import 'package:dio/dio.dart';

import 'network_client.dart';
import 'params.dart';

class ApiService {
  final NetworkClient networkClient;

  ApiService({required this.networkClient});

  Future<Response> registerRider(RegisterParam params) async {
    final FormData formData = FormData.fromMap({
      'name': params.name ?? '',
      'email': params.email ?? '',
      'password': params.password ?? '',
      'contact_number': params.contactNumber ?? '',
      'vehicle_number': params.vehicleNumber ?? '',
      'vehicle_color': params.vehicleColor ?? '',
      'vehicle_model': params.vehicleModel ?? '',
      'refer_by': params.referBy ?? '',
      'reg_status': params.regStatus,
      'profile_pic': await MultipartFile.fromFile(params.profilePicPath!),
    });

    return await networkClient.fileUpload('/rider/register', formData);
  }

  Future<Response> loginRider(LoginParam params) async {
    final Map<String, Object> paramsInMap = {
      'email': params.email,
      'password': params.password,
    };

    return await networkClient.post('/rider/login', paramsInMap);
  }

  Future<Response> forgotPassword(ForgotPasswordParam params) async {
    final Map<String, Object> paramsInMap = {
      'email': params.email,
    };

    return await networkClient.post('/rider/forgot-password', paramsInMap);
  }

  Future<Response> uploadDocuments(DocumentParam params) async {
    final FormData formData = FormData.fromMap({
      'rider_id': params.riderId,
      'deposit_amount_slip':
          await MultipartFile.fromFile(params.depositAmountSlipPath),
      'license_front': await MultipartFile.fromFile(params.licenceFrontPath),
      'license_back': await MultipartFile.fromFile(params.licenceBackPath),
      'cnic_front': await MultipartFile.fromFile(params.cnicFrontPath),
      'cnic_back': await MultipartFile.fromFile(params.cnicBackPath),
    });

    return await networkClient.fileUpload('/rider/upload-documents', formData);
  }
}
