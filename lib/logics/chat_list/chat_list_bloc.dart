import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/chat_list/chat_list.dart';

class ChatListBloc extends BlocEventStateBase<ChatListEvent,ChatListState> {

  static final ChatListAPI _api = ChatListAPI();

  @override
    ChatListState get initialState => ChatListState.initial();

  @override
  Stream<ChatListState> eventHandler(ChatListEvent event, ChatListState currentState) async*{

    if(event is ChatListEventStateClear) {
      yield ChatListState();
    }

    if(event is ChatListEventRefresh) {
      yield ChatListState.refresh();
    }

    if(event is ChatListEventDeleteChatRoom) {
      try {
        yield ChatListState.deleteLoading();
        await _api.deleteChatRoom(event.chatRoomID);
        _api.deleteChatHistory(event.friends);
        yield ChatListState.deleteSucceeded();
      } catch(exception) {
        print('채팅삭제 실패: ${exception.toString()}');
        yield ChatListState.deleteFailed();
      }
    }
    
    if(event is ChatListEventNew) {
      _api.addChatHistory(event.newMessage);
      yield ChatListState.newMessage();
    }
    if(event is ChatListEventStateClear) {
      yield ChatListState.initial();
    }
  }
}