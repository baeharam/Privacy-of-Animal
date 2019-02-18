import 'dart:async';

import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/same_match/same_match.dart';

class SameMatchBloc extends BlocEventStateBase<SameMatchEvent,SameMatchState>
{
  static final SameMatchAPI _api = SameMatchAPI();

  @override
  SameMatchState get initialState => SameMatchState.initial();

  @override
  Stream<SameMatchState> eventHandler(SameMatchEvent event, SameMatchState currentState) async*{
    if(event is SameMatchEventFindUser) {
      try {
        yield SameMatchState.findSucceeded(await _api.findUser());
      } catch(exception) {
        print(exception);
        yield SameMatchState.findFailed();
      }
    }
  }
}