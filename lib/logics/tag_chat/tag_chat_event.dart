import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class TagChatEvent extends BlocEvent{}

class TagChatEventStateClear extends TagChatEvent {}

class TagChatEventBeginChat extends TagChatEvent {}

class TagChatEventUserChat extends TagChatEvent {
  final String message;
  TagChatEventUserChat({@required this.message});
}

class TagChatEventComplete extends TagChatEvent {}