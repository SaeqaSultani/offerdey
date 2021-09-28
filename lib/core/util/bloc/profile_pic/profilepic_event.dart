part of 'profilepic_bloc.dart';

abstract class ProfilePicEvent extends Equatable {
  const ProfilePicEvent();

  @override
  List<Object> get props => [];
}

class SetProfilePic extends ProfilePicEvent {
  final String profilePicUrl;

  const SetProfilePic(this.profilePicUrl);

  @override
  List<Object> get props => [profilePicUrl];
}

class ResetProfilePic extends ProfilePicEvent {}
