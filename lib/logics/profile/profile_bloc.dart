import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/logics/profile/profile.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

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
      DateTime before = DateTime.fromMillisecondsSinceEpoch(sl.get<CurrentUser>().fakeProfileModel.analyzedTime);
      DateTime now = DateTime.now();
      Duration diff = now.difference(before);

      if(diff<Duration(days: 2)){
        yield ProfileState.noReset('갱신가능까지 ${48-diff.inHours}시간 남았습니다.');
      } else {
        yield ProfileState.reset();
      }
    }
  }
}