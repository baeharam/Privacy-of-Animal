import 'dart:async';

import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/same_match/same_match.dart';
import 'package:privacy_of_animal/models/same_match_model.dart';

class SameMatchBloc extends BlocEventStateBase<SameMatchEvent,SameMatchState>
{
  static final SameMatchAPI _api = SameMatchAPI();

  @override
  SameMatchState get initialState => SameMatchState.initial();

  @override
  Stream<SameMatchState> eventHandler(SameMatchEvent event, SameMatchState currentState) async*{

    if(event is SameMatchEventStateClear) {
      yield SameMatchState.initial();
    }

    if(event is SameMatchEventRefreshLoading) {
      yield SameMatchState.refreshLoading();
    }
    if(event is SameMatchEventRefreshFriends) {
      yield SameMatchState.refreshFriends();
    }
    if(event is SameMatchEventRefreshRequestFrom) {
      yield SameMatchState.refreshRequestFrom();
    }
    if(event is SameMatchEventRefreshRequestTo) {
      yield SameMatchState.refreshRequestTo();
    }

    if(event is SameMatchEventConnectToServer) {
      _api.connectToServer(event.otherUserUID);
    }

    if(event is SameMatchEventDisconnectToServer) {
      await _api.disconnectToServer(event.otherUserUID);
    }

    if(event is SameMatchEventEnterOtherProfileScreen) {
      _api.enterOtherProfileScreen();
    }

    if(event is SameMatchEventFindUser) {
      try {
        yield SameMatchState.findLoading();
        SameMatchModel sameMatchModel = await _api.findUser();
        yield SameMatchState.findSucceeded(sameMatchModel);
      } catch(exception) {
        print('상대방 찾기 실패\n${exception.toString()}');
        yield SameMatchState.findFailed();
      }
    }

    if(event is SameMatchEventSendRequest) {
      try {
        yield SameMatchState.requestLoading();
        await _api.sendRequest(event.uid);
        yield SameMatchState.requestSucceeded();
      } catch(exception) {
        print('친구신청 실패\n${exception.toString()}');
        yield SameMatchState.requestFailed();
      }
    }

    if(event is SameMatchEventCancelRequest) {
      try {
        yield SameMatchState.cancelLoading();
        await _api.cancelRequest(event.uid);
        yield SameMatchState.cancelSucceeded();
      } catch(exception) {
        print('친구신청 취소 실패\n${exception.toString()}');
        yield SameMatchState.cancelFailed();
      }
    }
  }
}