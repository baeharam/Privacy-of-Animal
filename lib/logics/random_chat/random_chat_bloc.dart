import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/random_chat/random_chat.dart';

class RandomChatBloc extends BlocEventStateBase<RandomChatEvent,RandomChatState>
{
  static final RandomChatAPI _api = RandomChatAPI();

  @override
  RandomChatState get initialState => RandomChatState.loading();

  @override
  Stream<RandomChatState> eventHandler(RandomChatEvent event, RandomChatState currentState) async*{

    if(event is RandomChatEventMessageSend){
      await _api.sendMessage(event.content, event.receiver, event.chatRoomID);
    }

    if(event is RandomChatEventInitial){
      yield RandomChatState.initial();
    }

    if(event is RandomChatEventMatchStart){
      await _api.setRandomUser();
      yield RandomChatState.loading();
      String receiver = await _api.findUser();
      String chatRoomID = _api.getChatRoomID(receiver);
      yield RandomChatState.matchSucceeded(
        receiver: receiver,
        chatRoomID: chatRoomID
      );
      await _api.updateUsers(receiver);
    }
    if(event is RandomChatEventMatchUsers){
      await _api.updateUsers(event.user);
    }
    if(event is RandomChatEventCancel){
      yield RandomChatState.cancel();
      await _api.deleteUser();
    }
  }
}