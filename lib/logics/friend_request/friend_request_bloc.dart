import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/friend_request/friend_request.dart';

class FriendRequestBloc extends BlocEventStateBase<FriendRequestEvent,FriendRequestState> {

  final FriendRequestAPI _api = FriendRequestAPI();

  @override
    FriendRequestState get initialState => FriendRequestState.initial();

  @override
  Stream<FriendRequestState> eventHandler(FriendRequestEvent event, FriendRequestState currentState) async*{
    if(event is FriendRequestEventSendRequest) {
      try {
        await _api.requestFriend(event.uid);
        yield FriendRequestState.requestSucceeded();
      } catch(exception) {
        print(exception);
        yield FriendRequestState.requestFailed();
      }
    }
    if(event is FriendRequestEventStateClear) {
      yield FriendRequestState.initial();
    }
  }
}