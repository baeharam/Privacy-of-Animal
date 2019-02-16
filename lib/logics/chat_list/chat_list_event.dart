import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class ChatListEvent extends BlocEvent {}

class ChatListEventStateClear extends ChatListEvent {}

class ChatListEventFetchList extends ChatListEvent{
  final List<DocumentSnapshot> documents;

  ChatListEventFetchList({@required this.documents });
}

class ChatListEventDeleteChatRoom extends ChatListEvent {
  final String chatRoomID;

  ChatListEventDeleteChatRoom({@required this.chatRoomID});
}