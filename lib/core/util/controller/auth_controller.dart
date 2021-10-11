import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../error/exceptions.dart';
import '../../error/failures.dart';
import '../../network/api_service.dart';
import '../../network/network_client.dart';
import '../../network/params.dart';
import '../constants.dart';
import '../model/auth.dart';

class AuthController {
  static final AuthController _controller = AuthController._internal();

  final ApiService _apiService =
      ApiService(networkClient: NetworkClient(DAWAI_HAZIR_API));

  factory AuthController() {
    return _controller;
  }
  AuthController._internal();

  Future<Either<Failure, Auth>> loginWithEmail(
      LoginParam params, Auth auth) async {
    try {
      final Response<dynamic> loginResponse = await _apiService.loginRider(
          LoginParam(email: params.email, password: params.password));

      if (loginResponse.statusCode == 200) {
        return Right(
          Auth(
            riderId: auth.riderId,
            token: loginResponse.data['success']['token'],
            method: auth.method,
            documentSubmitted: auth.documentSubmitted,
          ),
        );
      } else {
        return Left(AuthFailure(loginResponse.data.toString()));
      }
    } on RemoteException catch (e) {
      return Left(RemoteFailure(
          message: e.dioError.response!.data['error'].toString(),
          errorType: e.dioError.type));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  Future<Either<Failure, Auth>> signupWithEmail(RegisterParam params) async {
    try {
      final Response<dynamic> response =
          await _apiService.registerRider(params);

      if (response.statusCode == 200) {
        return Right(
          Auth(
            riderId: response.data['success']['rider_id'],
            method: LoginMethod.email,
            token: '',
            documentSubmitted: false,
          ),
        );
      } else {
        return Left(AuthFailure(response.data.toString()));
      }
    } on RemoteException catch (e) {
      return Left(RemoteFailure(
          message: e.dioError.response!.data['error'].toString(),
          errorType: e.dioError.type));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  Future<Either<Failure, Auth>> uploadDocuments(DocumentParam params) async {
    try {
      final Response<dynamic> response =
          await _apiService.uploadDocuments(params);

      if (response.statusCode == 200) {
        return Right(
          Auth(
            riderId: params.riderId,
            method: LoginMethod.email,
            token: '',
            documentSubmitted: true,
          ),
        );
      } else {
        return Left(AuthFailure(response.data.toString()));
      }
    } on RemoteException catch (e) {
      return Left(RemoteFailure(
          message: e.dioError.response!.data['error'].toString(),
          errorType: e.dioError.type));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  Future<Either<Failure, String>> forgetPassword(
      ForgotPasswordParam params) async {
    try {
      final Response<dynamic> response =
          await _apiService.forgotPassword(params);
      if (response.statusCode == 200) {
        return Right(response.data['success']['key']);
      } else {
        return Left(AuthFailure(response.data));
      }
    } on RemoteException catch (e) {
      return Left(RemoteFailure(
          message: e.dioError.response!.data['error'].toString(),
          errorType: e.dioError.type));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }
}
