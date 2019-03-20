import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class FriendsChatEvent extends BlocEvent{}

class FriendsChatEventStateClear extends FriendsChatEvent {}

class FriendsChatEventFetchTimestamp extends FriendsChatEvent {
  final String chatRoomID;
  FriendsChatEventFetchTimestamp({@required this.chatRoomID});
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

class FriendsChatEventStoreMessages extends FriendsChatEvent {
  final String from;
  final String to;
  final int timestamp;
  final String content;

  FriendsChatEventStoreMessages({
    @required this.from,
    @required this.to,
    @required this.timestamp,
    @required this.content
  });
}

class FriendsChatEventNotification extends FriendsChatEvent {
  final String chatRoomID;
  FriendsChatEventNotification({@required this.chatRoomID});
}