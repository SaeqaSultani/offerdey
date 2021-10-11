part of 'profilepic_bloc.dart';

abstract class ProfilePicState extends Equatable {
  final String? profilePictureUrl;
  const ProfilePicState(this.profilePictureUrl);

  @override
  List<Object> get props => [];
}

class ProfilePicInitial extends ProfilePicState {
  const ProfilePicInitial(String? profilePictureUrl) : super(profilePictureUrl);

  @override
  List<Object> get props => [];
}

class ProfilePicSet extends ProfilePicState {
  const ProfilePicSet(String profilePictureUrl) : super(profilePictureUrl);

  @override
  List<Object> get props => [];
}
