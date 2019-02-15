import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class RandomChatEvent extends BlocEvent{}

class RandomChatEventMatchStart extends RandomChatEvent {}

class RandomChatEventMatchUsers extends RandomChatEvent {
  final String user;

  RandomChatEventMatchUsers({
    @required this.user
  });
}

class RandomChatEventCancel extends RandomChatEvent {}

class RandomChatEventOut extends RandomChatEvent {
  final String chatRoomID;

  RandomChatEventOut({
    @required this.chatRoomID
  });
}

class RandomChatEventMessageSend extends RandomChatEvent {
  final String content;
  final String receiver;
  final String chatRoomID;

  RandomChatEventMessageSend({
    @required this.content,
    @required this.receiver,
    @required this.chatRoomID
  });
}