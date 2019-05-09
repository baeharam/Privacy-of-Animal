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
      yield FriendsChatState.initial();
    }

    if(event is FriendsChatEvnetFirstChatFetch) {
      try {
        yield FriendsChatState.chatFetchLoading();
        await _api.fetchFirstChat(event.otherUserUID, event.chat);
        yield FriendsChatState.chatFetchSucceeded();
      } catch(exception) {
        print("채팅 데이터 가져오기 실패: ${exception.toString()}");
        yield FriendsChatState.chatFetchFailed();
      }
    }

    if(event is FriendsChatEventMessageRecieved) {
      _api.updateChatHistory(event.otherUserUID, event.nickName, event.snapshot);
      yield FriendsChatState.messageReceived();
    }

    if(event is FriendsChatEventMyChatUpdate) {
      _api.addChatDirectly(event.otherUserUID, event.chatModel);
      yield FriendsChatState.myMessage();

    }
  
    if(event is FriendsChatEventMessageSend) {
      try {
        await _api.sendMessage(event.content, event.receiver, event.chatRoomID);
      } catch(exception) {
        print("채팅 전송 실패: ${exception.toString()}");
        yield FriendsChatState.sendFailed();
      }
    }

    if(event is FriendsChatEventNotification) {
      try {
        await _api.setChatRoomNotification(event.otherUserUID);
        yield FriendsChatState.notificationToggleSucceeded();
      } catch(exception) {
        print("채팅방 알림설정 실패: ${exception.toString()}");
        yield FriendsChatState.notificationToggleFailed();
      }
    }
  }
}