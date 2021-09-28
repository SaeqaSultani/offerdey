import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../error/failures.dart';
import '../../controller/auth_controller.dart';
import '../../model/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthController _controller = AuthController();

  UserBloc() : super(const UserInitial()) {
    // on<LoginWithFacebook>((event, emit) async {
    //   emit(const UserLoading());

    //   final Either<AuthFailure, User?> result =
    //       await _controller.loginWithFacebook();

    //   result.fold((failure) {
    //     emit(NoUser(failure: failure));
    //   }, (user) {
    //     if (user == null) {
    //       emit(const NoUser());
    //     } else {
    //       emit(UserLoaded(user));
    //     }
    //   });
    // });
    // on<LoginWithGoogle>((event, emit) async {
    //   emit(const UserLoading());

    //   final Either<AuthFailure, User?> result =
    //       await _controller.loginWithGoogle();

    //   result.fold((failure) {
    //     emit(NoUser(failure: failure));
    //   }, (user) {
    //     if (user == null) {
    //       emit(const NoUser());
    //     } else {
    //       emit(UserLoaded(user));
    //     }
    //   });
    // });
    // on<LogoutWithFacebook>((event, emit) async {
    //   emit(const UserLoading());
    //   await _controller.logOutFacebook();
    //   emit(const NoUser());
    // });
    // on<LogoutWithGoogle>((event, emit) async {
    //   emit(const UserLoading());
    //   await _controller.logOutGoogle();
    //   emit(const NoUser());
    // });
  }
}
