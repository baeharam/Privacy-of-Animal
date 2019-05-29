import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/profile/profile.dart';

class ProfileBloc extends BlocEventStateBase<ProfileEvent,ProfileState>
{
  @override
  ProfileState get initialState => ProfileState.initial();

  @override
  Stream<ProfileState> eventHandler(ProfileEvent event, ProfileState currentState) async*{

    if(event is ProfileEventStateClear) {
      yield ProfileState.initial();
    }

    if(event is ProfileEventResetFakeProfile) {
      yield ProfileState.reset();
    }
  }
}