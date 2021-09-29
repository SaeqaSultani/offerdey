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
      emit(AuthLoading(state.auth));

      final Either<Failure, Auth> result =
          await _controller.signupWithEmail(event.params);

      result.fold(
        (l) => emit(
          NoAuth(
            failure: l,
            auth: state.auth,
          ),
        ),
        (r) => emit(
          AuthRegisteredSuccess(r),
        ),
      );
    });

    on<UploadDocuments>((event, emit) async {
      emit(AuthLoading(state.auth));

      final Either<Failure, Auth> result =
          await _controller.uploadDocuments(event.params);

      result.fold(
        (l) => emit(
          UploadFailed(
            failure: l,
            auth: state.auth,
          ),
        ),
        (r) => emit(
          AuthDocumentSubmitted(
            Auth(
              method: r.method,
              riderId: r.riderId,
              token: r.token,
              documentSubmitted: r.documentSubmitted,
            ),
          ),
        ),
      );
    });
    on<LoginWithEmail>((event, emit) async {
      emit(AuthLoading(state.auth));

      final Either<Failure, Auth> result =
          await _controller.loginWithEmail(event.params, state.auth);

      result.fold(
        (l) => emit(
          NoAuth(
            failure: l,
            auth: state.auth,
          ),
        ),
        (r) => emit(
          AuthLoaded(r),
        ),
      );
    });

    on<ForgetPassword>((event, emit) async {
      emit(AuthLoading(state.auth));

      final Either<Failure, String> result =
          await _controller.forgetPassword(event.params);

      result.fold(
        (l) => emit(
          NoAuth(
            failure: l,
            auth: state.auth,
          ),
        ),
        (r) => emit(
          const AuthInitial(),
        ),
      );
    });
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    try {
      if (json['token'] != '') {
        return AuthLoaded(
          Auth(
            riderId: json['riderId'],
            method: LoginMethod.values[json['loginMethod'] as int],
            token: json['token'],
            documentSubmitted: json['documentSubmitted'] as bool,
          ),
        );
      } else if (!json['documentSubmitted'] && json['vendorId'] as int != -1) {
        return AuthRegisteredSuccess(
          Auth(
            riderId: json['riderId'],
            method: LoginMethod.values[json['loginMethod'] as int],
            token: json['token'],
            documentSubmitted: json['documentSubmitted'] as bool,
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
        'riderId': state.auth.riderId,
        'loginMethod': state.auth.method.index,
        'token': state.auth.token,
        'documentSubmitted': state.auth.documentSubmitted,
      };
    } catch (e) {
      return null;
    }
  }
}
