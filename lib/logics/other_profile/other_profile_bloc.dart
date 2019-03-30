import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/other_profile/other_profile.dart';
import 'package:privacy_of_animal/logics/same_match/same_match_api.dart';

class OtherProfileBloc extends BlocEventStateBase<OtherProfileEvent,OtherProfileState> {

  static final SameMatchAPI _api = SameMatchAPI();

  @override
    OtherProfileState get initialState => OtherProfileState.initial();

  @override
  Stream<OtherProfileState> eventHandler(OtherProfileEvent event, OtherProfileState currentState) async*{

    if(event is OtherProfileEventStateClear) {
      yield OtherProfileState();
    }

    if(event is OtherProfileEventAlreadyFriends) {
      yield OtherProfileState.alreadyFriends();
    }

    if(event is OtherProfileEventAlreadyRequest) {
      yield OtherProfileState.alreadyRequest();
    }

    if(event is OtherProfileEventSendRequest) {
      try {
        yield OtherProfileState.requestLoading();
        await _api.sendRequest(event.uid);
        await _api.addToLocal(event.uid);
        yield OtherProfileState.requestSucceeded();
      } catch(exception) {
        print("친구신청 실패: ${exception.toString()}");
        yield OtherProfileState.requestFailed();
      }
    }

    if(event is OtherProfileEventCancelRequest) {
      try {
        yield OtherProfileState.cancelLoading();
        await _api.cancelRequest(event.uid);
        _api.removeFromLocal(event.uid);
        yield OtherProfileState.cancelSucceeded();
      } catch(exception) {
        print("친구신청 취소 실패: ${exception.toString()}");
        yield OtherProfileState.cancelFailed();
      }
    }
  }
}