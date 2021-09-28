part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  final User? user;
  const UserState(this.user);

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {
  const UserInitial() : super(null);
}

class UserLoading extends UserState {
  const UserLoading() : super(null);
}

class UserLoaded extends UserState {
  const UserLoaded(User user) : super(user);
}

class NoUser extends UserState {
  final AuthFailure? failure;
  const NoUser({this.failure}) : super(null);
}
