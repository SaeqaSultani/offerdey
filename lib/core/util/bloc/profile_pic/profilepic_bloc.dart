import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'profilepic_event.dart';
part 'profilepic_state.dart';

class ProfilePicBloc extends HydratedBloc<ProfilePicEvent, ProfilePicState> {
  ProfilePicBloc() : super(const ProfilePicInitial(null)) {
    on<SetProfilePic>((event, emit) {
      emit(const ProfilePicInitial(null));
      emit(ProfilePicSet(event.profilePicUrl));
    });

    on<ResetProfilePic>((event, emit) {
      emit(const ProfilePicInitial(null));
    });
  }

  @override
  ProfilePicState? fromJson(Map<String, dynamic> json) {
    try {
      if (json['profilePicUrl'] != null) {
        return ProfilePicSet(json['profilePicUrl']);
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(ProfilePicState state) {
    try {
      return {
        'profilePicUrl': state.profilePictureUrl,
      };
    } catch (e) {
      return null;
    }
  }
}
