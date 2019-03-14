import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/chat_list/chat_list.dart';

class ChatListBloc extends BlocEventStateBase<ChatListEvent,ChatListState> {

  static final ChatListAPI _api = ChatListAPI();

  @override
    ChatListState get initialState => ChatListState.fetchLoading();

  @override
  Stream<ChatListState> eventHandler(ChatListEvent event, ChatListState currentState) async*{

    if(event is ChatListEventConnectServer) {
      _api.connectToFirebase();
    }

    if(event is ChatListEventDeleteChatRoom) {
      try {
        await _api.deleteChatRoom(event.chatRoomID);
        yield ChatListState.fetchLoading();
      } catch(exception) {
        print(exception);
      }
    }
    
    if(event is ChatListEventFetch) {
      try { 
        yield ChatListState.fetchSucceeded(await _api.fetchUserData(event.newMessage));
      } catch(exception){
        print(exception);
        yield ChatListState.fetchFailed();
      }
    }
    if(event is ChatListEventStateClear) {
      yield ChatListState.initial();
    }
  }
}