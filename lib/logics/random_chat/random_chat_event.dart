import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/models/chat_model.dart';

abstract class RandomChatEvent extends BlocEvent{}

class RandomChatEventStateClear extends RandomChatEvent {}

class RandomChatEventConnect extends RandomChatEvent {
  final String chatRoomID;
  final String otherUserUID;

  RandomChatEventConnect({@required this.chatRoomID,@required this.otherUserUID});
}

class RandomChatEventDisconnect extends RandomChatEvent {}

class RandomChatEventOut extends RandomChatEvent {
  final String chatRoomID;

  RandomChatEventOut({@required this.chatRoomID});
}

class RandomChatEventRestart extends RandomChatEvent {
  final String chatRoomID;

  RandomChatEventRestart({@required this.chatRoomID});
}

class RandomChatEventMessageReceived extends RandomChatEvent {
  final QuerySnapshot chatSnapshot;

  RandomChatEventMessageReceived({@required this.chatSnapshot});
}

class RandomChatEventMessageSend extends RandomChatEvent {
  final ChatModel chatModel;
  final String chatRoomID;

  RandomChatEventMessageSend({
    @required this.chatModel,
    @required this.chatRoomID
  });
}

class RandomChatEventFinished extends RandomChatEvent {}