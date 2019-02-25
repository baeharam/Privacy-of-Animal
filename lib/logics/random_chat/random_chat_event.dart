import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class RandomChatEvent extends BlocEvent{}

class RandomChatEventStateClear extends RandomChatEvent {}

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

class RandomChatEventFinished extends RandomChatEvent {}