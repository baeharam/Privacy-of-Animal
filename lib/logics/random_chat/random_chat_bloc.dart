import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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
    
    if(event is RandomChatEventStateClear) {
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
          DocumentSnapshot receiver = await _api.enterChatRoom(_chatRoomID);
          yield RandomChatState.matchSucceeded(
            chatRoomID: _chatRoomID,
            receiver: receiver
          );
        }
      } catch(exception) {
        print(exception);
        yield RandomChatState.apiFailed();
      }
    }

    if(event is RandomChatEventUserEntered) {
      yield RandomChatState.matchSucceeded(
        receiver: await _api.fetchUserData(event.receiver),
        chatRoomID: event.chatRoomID
      );
    }

    if(event is RandomChatEventOut) {
      try {
        await _api.getOutChatRoom(event.chatRoomID);
        yield RandomChatState.initial();
      } catch(exception) {
        print(exception);
        yield RandomChatState.apiFailed();
      }
    }

    if(event is RandomChatEventCancel) {
      try {
        await _api.deleteMadeChatRoom();
        yield RandomChatState.initial();
      } catch(exception) {
        print(exception);
        yield RandomChatState.apiFailed();
      }
    }

    if(event is RandomChatEventFinished) {
      yield RandomChatState.finished();
    }
  }
}