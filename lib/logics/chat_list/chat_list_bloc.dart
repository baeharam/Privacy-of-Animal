import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/chat_list/chat_list.dart';

class ChatListBloc extends BlocEventStateBase<ChatListEvent,ChatListState> {

  final ChatListAPI _api = ChatListAPI();

  @override
    ChatListState get initialState => ChatListState.fetchLoading();

  @override
  Stream<ChatListState> eventHandler(ChatListEvent event, ChatListState currentState) async*{
    if(event is ChatListEventFetchList) {
      yield ChatListState.fetchSucceeded(await _api.fetchUserData(event.documents));
    }
    if(event is ChatListEventStateClear) {
      yield ChatListState.initial();
    }
  }
}