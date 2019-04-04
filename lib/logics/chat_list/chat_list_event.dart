import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/models/user_model.dart';

abstract class ChatListEvent extends BlocEvent {}

class ChatListEventStateClear extends ChatListEvent {}

class ChatListEventNew extends ChatListEvent{
  final UserModel otherUser;
  final List<DocumentChange> newMessages;
  final String chatRoomID;

  ChatListEventNew({
    @required this.newMessages,
    @required this.otherUser,
    @required this.chatRoomID
  });
}

class ChatListEventDeleteChatRoom extends ChatListEvent {
  final String friends;
  final String chatRoomID;

  ChatListEventDeleteChatRoom({
    @required this.friends,
    @required this.chatRoomID
  });
}

class ChatListEventRefresh extends ChatListEvent {}