import 'dart:async';

import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/random_chat/random_chat.dart';

class RandomChatBloc extends BlocEventStateBase<RandomChatEvent,RandomChatState>
{
  static final RandomChatAPI _api = RandomChatAPI();
  String _chatRoomID = '';

  @override
  RandomChatState get initialState => RandomChatState.initial();

  @override
  Stream<RandomChatState> eventHandler(RandomChatEvent event, RandomChatState currentState) async*{

    if(event is RandomChatEventInitial){
      yield RandomChatState.initial();
    }
    
    if(event is RandomChatEventMessageSend){
      try {
        await _api.sendMessage(event.content, event.receiver, event.chatRoomID);
      } catch(exception) {
        print(exception);
        yield RandomChatState.apiFailed();
      }
    }

    if(event is RandomChatEventMatchStart){
      try {
        _chatRoomID = await _api.getRoomID();
        if(_chatRoomID.isEmpty){
          _chatRoomID = await _api.makeChatRoom();
          yield RandomChatState.madeChatRoom(_chatRoomID);
        } else {
          await _api.enterChatRoom(_chatRoomID);
          yield RandomChatState.matchSucceeded();
        }
      } catch(exception) {
        print(exception);
        yield RandomChatState.apiFailed();
      }
    }

    if(event is RandomChatEventCancel){
      try {
        await _api.deleteChatRoom(_chatRoomID);
      } catch(exception) {
        print(exception);
        yield RandomChatState.apiFailed();
      }
    }
  }
}