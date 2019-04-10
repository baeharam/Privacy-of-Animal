import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/models/chat_model.dart';

abstract class FriendsChatEvent extends BlocEvent{}

class FriendsChatEventStateClear extends FriendsChatEvent {}

class FriendsChatEventMessageRecieved extends FriendsChatEvent {
  final String otherUserUID;
  final String nickName;
  final QuerySnapshot snapshot;

  FriendsChatEventMessageRecieved({
    @required this.otherUserUID,
    @required this.nickName,
    @required this.snapshot
  });
}

class FriendsChatEventMyChatUpdate extends FriendsChatEvent {
  final String otherUserUID;
  final ChatModel chatModel;

  FriendsChatEventMyChatUpdate({
    @required this.otherUserUID,
    @required this.chatModel
  });
}

class FriendsChatEventMessageSend extends FriendsChatEvent {
  final String content;
  final String receiver;
  final String chatRoomID;

  FriendsChatEventMessageSend({
    @required this.content,
    @required this.receiver,
    @required this.chatRoomID
  });
}

class FriendsChatEventNotification extends FriendsChatEvent {
  final String chatRoomID;
  FriendsChatEventNotification({@required this.chatRoomID});
}

class FriendsChatEvnetFirstChatFetch extends FriendsChatEvent {
  final String otherUserUID;
  final List<DocumentSnapshot> chat;
  FriendsChatEvnetFirstChatFetch({@required this.otherUserUID, @required this.chat});
}