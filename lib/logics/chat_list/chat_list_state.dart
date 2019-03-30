import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class ChatListState extends BlocState {
  final bool isInitial;

  final bool isDeleteLoading;
  final bool isDeleteSucceeded;
  final bool isDeleteFailed;

  final bool isNewMessage;

  final bool isRefresh;

  ChatListState({
    this.isInitial: false,

    this.isDeleteLoading: false,
    this.isDeleteSucceeded: false,
    this.isDeleteFailed: false,

    this.isNewMessage: false,

    this.isRefresh: false
  });

  factory ChatListState.initial() => ChatListState(isInitial: true);

  factory ChatListState.deleteLoading() => ChatListState(isDeleteLoading: true);
  factory ChatListState.deleteSucceeded() => ChatListState(isDeleteSucceeded: true);
  factory ChatListState.deleteFailed() => ChatListState(isDeleteFailed: true);

  factory ChatListState.newMessage() => ChatListState(isNewMessage: true);

  factory ChatListState.refresh() => ChatListState(isRefresh: true);
}