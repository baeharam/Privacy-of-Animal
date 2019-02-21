import 'dart:async';

import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/friend_request/friend_request_api.dart';
import 'package:privacy_of_animal/logics/same_match/same_match.dart';

class SameMatchBloc extends BlocEventStateBase<SameMatchEvent,SameMatchState>
{
  static final SameMatchAPI _sameMatchAPI = SameMatchAPI();
  static final FriendRequestAPI _friendRequestAPI = FriendRequestAPI();

  @override
  SameMatchState get initialState => SameMatchState.initial();

  @override
  Stream<SameMatchState> eventHandler(SameMatchEvent event, SameMatchState currentState) async*{

    if(event is SameMatchEventStateClear) {
      yield SameMatchState.initial();
    }

    if(event is SameMatchEventFindUser) {
      try {
        yield SameMatchState.loading();
        yield SameMatchState.findSucceeded(await _sameMatchAPI.findUser());
      } catch(exception) {
        print(exception);
        yield SameMatchState.findFailed();
      }
    }

    if(event is SameMatchEventSendRequest) {
      try {
        await _friendRequestAPI.requestFriend(event.uid);
        yield SameMatchState.requestSucceeded();
      } catch(exception) {
        print(exception);
        yield SameMatchState.requestFailed();
      }
    }
  }
}