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

    if(event is OtherProfileEventRefreshLoading) {
      yield OtherProfileState.refreshLoading();
    }
    if(event is OtherProfileEventRefreshFriends) {
      yield OtherProfileState.refreshFriends();
    }
    if(event is OtherProfileEventRefreshRequestFrom) {
      yield OtherProfileState.refreshRequestFrom();
    }
    if(event is OtherProfileEventRefreshRequestTo) {
      yield OtherProfileState.refreshRequestTo();
    }

    if(event is OtherProfileEventConnectToServer) {
      _api.connectToServer(event.otherUserUID);
    }

    if(event is OtherProfileEventDisconnectToServer) {
      await _api.disconnectToServer();
    }

    if(event is OtherProfileEventGetOut) {
      _api.getOutOtherProfileScreen();
    }

    if(event is OtherProfileEventSendRequest) {
      try {
        yield OtherProfileState.requestLoading();
        await _api.sendRequest(event.uid);
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
        yield OtherProfileState.cancelSucceeded();
      } catch(exception) {
        print("친구신청 취소 실패: ${exception.toString()}");
        yield OtherProfileState.cancelFailed();
      }
    }
  }
}