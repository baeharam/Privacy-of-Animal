import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class FriendsChatEvent extends BlocEvent{}

class FriendsChatEventStateClear extends FriendsChatEvent {}

class FriendsChatEventMessageRecieved extends FriendsChatEvent {}

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