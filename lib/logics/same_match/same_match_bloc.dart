import 'dart:async';

import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/friend_request/friend_request_api.dart';
import 'package:privacy_of_animal/logics/same_match/same_match.dart';
import 'package:privacy_of_animal/models/same_match_model.dart';

class SameMatchBloc extends BlocEventStateBase<SameMatchEvent,SameMatchState>
{
  static final SameMatchAPI _sameMatchAPI = SameMatchAPI();
  static final FriendRequestAPI _friendRequestAPI = FriendRequestAPI();

  @override
  SameMatchState get initialState => SameMatchState.initial();

  @override
  Stream<SameMatchState> eventHandler(SameMatchEvent event, SameMatchState currentState) async*{

    if(event is SameMatchEventStateClear) {
      yield SameMatchState();
    }

    if(event is SameMatchEventAlreadyFriends) {
      yield SameMatchState.alreadyFriends();
    }

    if(event is SameMatchEventAlreadyRequest) {
      yield SameMatchState.alreadyRequest();
    }

    if(event is SameMatchEventConnectToServer) {
      _sameMatchAPI.connectToServer(sameMatchModel: event.sameMatchModel);
    }

    if(event is SameMatchEventDisconnectToServer) {
      await _sameMatchAPI.disconnectToServer();
    }

    if(event is SameMatchEventFindUser) {
      try {
        yield SameMatchState.findLoading();
        SameMatchModel sameMatchModel = await _sameMatchAPI.findUser();
        yield SameMatchState.findSucceeded(sameMatchModel);
      } catch(exception) {
        print('상대방 찾기 실패\n${exception.toString()}');
        yield SameMatchState.findFailed();
      }
    }

    if(event is SameMatchEventSendRequest) {
      try {
        yield SameMatchState.requestLoading();
        await _friendRequestAPI.requestFriend(event.uid);
        yield SameMatchState.requestSucceeded();
      } catch(exception) {
        print('친구신청 실패\n${exception.toString()}');
        yield SameMatchState.requestFailed();
      }
    }

    if(event is SameMatchEventCancelRequest) {
      try {
        yield SameMatchState.cancelLoading();
        await _friendRequestAPI.cancelRequest(event.uid);
        yield SameMatchState.cancelSucceeded();
      } catch(exception) {
        print('친구신청 취소 실패\n${exception.toString()}');
        yield SameMatchState.cancelFailed();
      }
    }
  }
}