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

    if(event is FriendsChatEventNotification) {
      try {
        await _api.setChatRoomNotification(event.chatRoomID);
        yield FriendsChatState.notificationToggleSucceeded();
      } catch(exception) {
        print("채팅방 알림설정 실패: ${exception.toString()}");
        yield FriendsChatState.notificationToggleFailed();
      }
    }

    if(event is FriendsChatEventFetchTimestamp) {
      try {
        yield FriendsChatState.timeStampFetchSucceeded(
          await _api.getDeleteTimestamp(event.chatRoomID));
      } catch(exception) {
        print("채팅 시간 가져오기 실패: ${exception.toString()}");
        yield FriendsChatState.timeStampFetchFailed();
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

    if(event is FriendsChatEventStoreMessages) {
      try {
        await _api.storeIntoLocalDB(event.from, event.to, event.timestamp, event.content);
        yield FriendsChatState.storeSucceeded();
      } catch(exception) {
        print("채팅 저장 실패: ${exception.toString()}");
        yield FriendsChatState.storeFailed();
      }
    }
  }
}