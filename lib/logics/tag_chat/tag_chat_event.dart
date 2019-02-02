import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class TagChatEvent extends BlocEvent{}

class TagChatEventUser extends TagChatEvent {
  final String message;
  TagChatEventUser({
    @required this.message,
  });
}

class TagChatEventComplete extends TagChatEvent {}

class TagChatEventNPC extends TagChatEvent {
  final bool isInitial;

  TagChatEventNPC({
    @required this.isInitial,
  });
}

class TagChatEvnetNothing extends TagChatEvent {}