import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/models/chat_list_model.dart';

abstract class ChatListEvent extends BlocEvent {}

class ChatListEventStateClear extends ChatListEvent {}

class ChatListEventNew extends ChatListEvent{
  final ChatListModel newMessage;

  ChatListEventNew({@required this.newMessage});
}

class ChatListEventDeleteChatRoom extends ChatListEvent {
  final String chatRoomID;
  final String friends;

  ChatListEventDeleteChatRoom({@required this.chatRoomID, @required this.friends});
}