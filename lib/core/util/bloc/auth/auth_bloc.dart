import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../error/failures.dart';
import '../../../network/params.dart';
import '../../controller/auth_controller.dart';
import '../../model/auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  final AuthController _controller = AuthController();

  AuthBloc() : super(const AuthInitial()) {
    on<SignupWithEmail>((event, emit) async {
      emit(const AuthLoading());

      final Either<Failure, Auth> result =
          await _controller.signupWithEmail(event.params);

      result.fold(
        (l) => emit(NoAuth(failure: l)),
        (r) => emit(
          AuthRegisteredSuccess(
            Auth(
              method: r.method,
              vendorId: r.vendorId,
            ),
          ),
        ),
      );
    });

    on<UploadDocuments>((event, emit) async {
      emit(const AuthLoading());

      final Either<Failure, Auth> result =
          await _controller.uploadDocuments(event.params);

      result.fold(
        (l) => emit(NoAuth(failure: l)),
        (r) => emit(
          AuthAccountVerified(
            Auth(
              method: r.method,
              vendorId: r.vendorId,
            ),
          ),
        ),
      );
    });
    // on<LoginWithEmail>((event, emit) async {
    //   emit(const AuthLoading());

    //   final Either<Failure, Auth> result =
    //       await _controller.loginWithEmail(event.params);

    //   result.fold(
    //     (l) => emit(NoAuth(failure: l)),
    //     (r) => emit(
    //       AuthLoaded(
    //         Auth(
    //           method: r.method,
    //           token: r.token,
    //         ),
    //       ),
    //     ),
    //   );
    // });

    on<ForgetPassword>((event, emit) async {
      emit(const AuthLoading());

      final Either<Failure, String> result =
          await _controller.forgetPassword(event.params);

      result.fold(
        (l) => emit(NoAuth(failure: l)),
        (r) => emit(
          const AuthInitial(),
        ),
      );
    });
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    try {
      if (json['vendorId'] as int != -1) {
        return AuthLoaded(
          Auth(
            vendorId: json['vendorId'],
            method: LoginMethod.values[json['loginMethod'] as int],
          ),
        );
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    try {
      return {
        'vendorId': state.auth.vendorId,
        'loginMethod': state.auth.method.index
      };
    } catch (e) {
      return null;
    }
  }
}
