import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/models/chat_list_model.dart';

class ChatListState extends BlocState {
  final bool isInitial;
  final bool isLoading;
  final bool isSucceeded;
  final bool isFailed;

  final ChatListModel chatList;

  ChatListState({
    this.isInitial: false,
    this.isLoading: false,
    this.isSucceeded: false,
    this.isFailed: false,
    this.chatList
  });

  factory ChatListState.initial() {
    return ChatListState(
      isInitial: true
    );
  }

  factory ChatListState.fetchLoading() {
    return ChatListState(
      isLoading: true
    );
  }

  factory ChatListState.fetchSucceeded(ChatListModel chatList) {
    return ChatListState(
      isSucceeded: true,
      chatList: chatList
    );
  }

  factory ChatListState.fetchFailed() {
    return ChatListState(
      isFailed: true
    );
  }
}