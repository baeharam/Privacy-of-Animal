import 'dart:async';

import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/random_chat/random_chat.dart';

class RandomChatBloc extends BlocEventStateBase<RandomChatEvent,RandomChatState>
{
  static final RandomChatAPI _api = RandomChatAPI();
  String chatRoomID = '';

  @override
  RandomChatState get initialState => RandomChatState.initial();

  @override
  Stream<RandomChatState> eventHandler(RandomChatEvent event, RandomChatState currentState) async*{

    if(event is RandomChatEventMessageSend){
      try {
        await _api.sendMessage(event.content, event.receiver, event.chatRoomID);
      } catch(exception) {
        yield RandomChatState.apiFailed(exception.toString());
      }
    }

    if(event is RandomChatEventInitial){
      yield RandomChatState.loading();
    }

    if(event is RandomChatEventMatchStart){
      yield RandomChatState.loading();
      try {
        chatRoomID = await _api.getRoomID();
        if(chatRoomID.isEmpty){
          chatRoomID = await _api.makeChatRoom();
          yield RandomChatState.madeChatRoom(chatRoomID);
        } else {
          await _api.enterChatRoom(chatRoomID);
          yield RandomChatState.matchSucceeded();
        }
      } catch(exception) {
        yield RandomChatState.apiFailed(exception.toString());
      }
    }

    if(event is RandomChatEventCancel){
      try {
        await _api.deleteChatRoom(chatRoomID);
      } catch(exception) {
        yield RandomChatState.apiFailed(exception.toString());
      }
    }
  }
}