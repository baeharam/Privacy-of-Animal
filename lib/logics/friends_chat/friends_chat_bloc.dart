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

    if(event is FriendsChatEventStateClear) {
      yield FriendsChatState();
    }

    if(event is FriendsChatEventMessageRecieved) {
      yield FriendsChatState.messageReceived();
    }

    if(event is FriendsChatEventNotification) {
      try {
        await _api.setChatRoomNotification(event.chatRoomID);
        yield FriendsChatState.notificationToggleSucceeded();
      } catch(exception) {
        print("채팅방 알림설정 실패: ${exception.toString()}");
        yield FriendsChatState.notificationToggleFailed();
      }
    }

    if(event is FriendsChatEventMessageSend) {
      try {
        await _api.sendMessage(event.content, event.receiver, event.chatRoomID);
        yield FriendsChatState.sendSucceeded();
      } catch(exception) {
        print("채팅 전송 실패: ${exception.toString()}");
        yield FriendsChatState.sendFailed();
      }
    }
  }
}