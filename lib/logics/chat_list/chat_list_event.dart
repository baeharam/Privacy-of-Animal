import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class ChatListEvent extends BlocEvent {}

class ChatListEventStateClear extends ChatListEvent {}

class ChatListEventConnectServer extends ChatListEvent {}

class ChatListEventFetch extends ChatListEvent{
  final DocumentSnapshot newMessage;

  ChatListEventFetch({@required this.newMessage});
}

class ChatListEventDeleteChatRoom extends ChatListEvent {
  final String chatRoomID;

  ChatListEventDeleteChatRoom({@required this.chatRoomID});
}