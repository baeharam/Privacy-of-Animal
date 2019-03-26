import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class ChatListState extends BlocState {
  final bool isInitial;

  final bool isDeleteLoading;
  final bool isDeleteSucceeded;
  final bool isDeleteFailed;

  final bool isFriendsDeleted;
  final bool isNewMessage;

  ChatListState({
    this.isInitial: false,

    this.isDeleteLoading: false,
    this.isDeleteSucceeded: false,
    this.isDeleteFailed: false,

    this.isFriendsDeleted: false,
    this.isNewMessage: false,
  });

  factory ChatListState.initial() => ChatListState(isInitial: true);

  factory ChatListState.deleteLoading() => ChatListState(isDeleteLoading: true);
  factory ChatListState.deleteSucceeded() => ChatListState(isDeleteSucceeded: true);
  factory ChatListState.deleteFailed() => ChatListState(isDeleteFailed: true);

  factory ChatListState.friendsDeleted() => ChatListState(isFriendsDeleted: true);

  factory ChatListState.newMessage() => ChatListState(isNewMessage: true);
}