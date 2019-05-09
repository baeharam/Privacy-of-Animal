import 'dart:async';

import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/random_chat/random_chat.dart';

class RandomChatBloc extends BlocEventStateBase<RandomChatEvent,RandomChatState>
{
  static final RandomChatAPI _api = RandomChatAPI();

  @override
  RandomChatState get initialState => RandomChatState.initial();

  @override
  Stream<RandomChatState> eventHandler(RandomChatEvent event, RandomChatState currentState) async*{
    
    if(event is RandomChatEventStateClear) {
      yield RandomChatState.initial();
    }

    if(event is RandomChatEventConnect) {
      _api.connectRandomChat(event.chatRoomID,event.otherUserUID);
    }

    if(event is RandomChatEventDisconnect) {
      await _api.disconnectRandomChat();
    }

    if(event is RandomChatEventMessageReceived) {
      await _api.processChatSnapshot(event.chatSnapshot);
      yield RandomChatState.messageReceived();
    }

    if(event is RandomChatEventMessageSend){
      try {
        _api.addChatDirectly(event.chatModel.to, event.chatModel);
        await _api.sendMessage(event.chatModel.content,event.chatModel.to,event.chatRoomID);
        yield RandomChatState.sendMessageSucceeded();
      } catch(exception) {
        print('메시지 전송 실패\n${exception.toString()}');
        yield RandomChatState.sendMessageFailed();
      }
    }

    if(event is RandomChatEventOut) {
      try {
        await _api.getOutChatRoom(event.chatRoomID);
        yield RandomChatState.getOutSucceeded();
      } catch(exception) {
        print('채팅방 나가기 실패\n${exception.toString()}');
        yield RandomChatState.getOutFailed();
      }
    }

    if(event is RandomChatEventRestart) {
      try {
        await _api.getOutChatRoom(event.chatRoomID);
        yield RandomChatState.restartSucceeded();
      } catch(exception) {
        print('채팅방 갱신 실패\n${exception.toString()}');
        yield RandomChatState.restartFailed();
      }
    }

    if(event is RandomChatEventFinished) {
      yield RandomChatState.chatFinished();
    }
  }
}