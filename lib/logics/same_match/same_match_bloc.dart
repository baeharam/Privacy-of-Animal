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
      yield SameMatchState();
    }

    if(event is SameMatchEventAlreadyFriends) {
      yield SameMatchState.alreadyFriends();
    }

    if(event is SameMatchEventAlreadyRequestFrom) {
      yield SameMatchState.alreadyRequestFrom();
    }

    if(event is SameMatchEventAlreadyRequestTo) {
      yield SameMatchState.alreadyRequestTo();
    }

    if(event is SameMatchEventConnectToServer) {
      _api.connectToServer(otherUser: event.otherUser);
    }

    if(event is SameMatchEventDisconnectToServer) {
      await _api.disconnectToServer();
    }

    if(event is SameMatchEventEnterOtherProfile) {
      _api.enterOtherProfile();
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
        _api.addRequestToLocal(event.uid);
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
        _api.removeRequestFromLocal(event.uid);
        await _api.cancelRequest(event.uid);
        yield SameMatchState.cancelSucceeded();
      } catch(exception) {
        print('친구신청 취소 실패\n${exception.toString()}');
        yield SameMatchState.cancelFailed();
      }
    }
  }
}