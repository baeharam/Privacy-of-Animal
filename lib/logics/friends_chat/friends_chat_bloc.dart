import 'dart:async';

import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/friends_chat/friends_chat.dart';

class FriendsChatBloc extends BlocEventStateBase<FriendsChatEvent,FriendsChatState>
{
  static final FriendsChatAPI _api = FriendsChatAPI();

  @override
  FriendsChatState get initialState => FriendsChatState.initial();

  @override
  Stream<FriendsChatState> eventHandler(FriendsChatEvent event, FriendsChatState currentState) async*{
    if(event is FriendsChatEventMessageSend) {
      try {
        await _api.sendMessage(event.content, event.receiver, event.chatRoomID);
        yield FriendsChatState.sendSucceeded();
      } catch(exception) {
        print(exception);
        yield FriendsChatState.sendFailed();
      }
    }

    if(event is FriendsChatEventStoreMessages) {
      try {
        await _api.storeIntoLocalDB(event.from, event.to, event.timestamp, event.content);
        yield FriendsChatState.storeSucceeded();
      } catch(exception) {
        print(exception);
        yield FriendsChatState.storeFailed();
      }
    }
  }
}