import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/chat_list/chat_list.dart';
import 'package:privacy_of_animal/models/chat_list_model.dart';

class ChatListBloc extends BlocEventStateBase<ChatListEvent,ChatListState> {

  final ChatListAPI _api = ChatListAPI();

  @override
    ChatListState get initialState => ChatListState.fetchLoading();

  @override
  Stream<ChatListState> eventHandler(ChatListEvent event, ChatListState currentState) async*{

    if(event is ChatListEventDeleteChatRoom) {
      try {
        await _api.deleteChatRoom(event.chatRoomID);
      } catch(exception) {
        print(exception);
      }
    }

    if(event is ChatListEventFetchList) {
      List<ChatListModel> chatListModels = List<ChatListModel>();
      try { 
        chatListModels = await _api.fetchUserData(event.documents);
      } catch(exception){
        print(exception);
        yield ChatListState.fetchFailed();
      }
      yield ChatListState.fetchSucceeded(chatListModels);
    }
    if(event is ChatListEventStateClear) {
      yield ChatListState.initial();
    }
  }
}