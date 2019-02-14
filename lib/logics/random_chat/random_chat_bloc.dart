import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/random_chat/random_chat.dart';

class RandomChatBloc extends BlocEventStateBase<RandomChatEvent,RandomChatState>
{
  static final RandomChatAPI _api = RandomChatAPI();
  String chatRoomID = '';

  @override
  RandomChatState get initialState => RandomChatState.loading();

  @override
  Stream<RandomChatState> eventHandler(RandomChatEvent event, RandomChatState currentState) async*{

    if(event is RandomChatEventMessageSend){
      await _api.sendMessage(event.content, event.receiver, event.chatRoomID);
    }

    if(event is RandomChatEventInitial){
      yield RandomChatState.loading();
    }

    if(event is RandomChatEventMatchStart){
      yield RandomChatState.loading();
      chatRoomID = await _api.getRoomID();
      if(chatRoomID.isEmpty){
        chatRoomID = await _api.makeChatRoom();
        yield RandomChatState.madeChatRoom(chatRoomID);
      } else {
        await _api.enterChatRoom(chatRoomID);
        yield RandomChatState.matchSucceeded();
      }
    }

    if(event is RandomChatEventCancel){
      await _api.deleteChatRoom(chatRoomID);
    }
  }
}