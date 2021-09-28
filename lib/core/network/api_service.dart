import 'package:dio/dio.dart';

import 'network_client.dart';
import 'params.dart';

class ApiService {
  final NetworkClient networkClient;

  ApiService({required this.networkClient});

  Future<Response> registerVendor(RegisterParam params) async {
    final Map<String, Object> paramsInMap = {
      'name': params.name ?? '',
      'email': params.email ?? '',
      'password': params.password ?? '',
      'contact_number': params.contactNumber ?? '',
      'vehicle_number': params.vehicleNumber ?? '',
      'vehicle_color': params.vehicleColor ?? '',
      'vehicle_model': params.vehicleModel ?? '',
      'refer_by': params.referBy ?? ''
    };

    return await networkClient.post('/rider/register', paramsInMap);
  }

  Future<Response> loginVendor(LoginParam params) async {
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
    print(
      params.profilePicPath,
    );
    print(
      params.cnicBackPath,
    );
    print(params.cnicFrontPath);

    final FormData formData = FormData.fromMap({
      'vendor_id': params.vendorId,
      'license_front': await MultipartFile.fromFile(params.licenceFrontPath),
      'license_back': await MultipartFile.fromFile(params.licenceBackPath),
      'cnic_front': await MultipartFile.fromFile(params.cnicFrontPath),
      'cnic_back': await MultipartFile.fromFile(params.cnicBackPath),
      'vendor_picture': await MultipartFile.fromFile(params.profilePicPath),
    });

    return await networkClient.fileUpload('/vendor/upload-documents', formData);
  }
}
