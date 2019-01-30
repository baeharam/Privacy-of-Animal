import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class TagChatEvent extends BlocEvent{}

class TagChatEventChat1 extends TagChatEvent {
  final String message;
  TagChatEventChat1({
    @required this.message
  });
}

class TagChatEventChat2 extends TagChatEvent {
  final String message;
  TagChatEventChat2({
    @required this.message
  });
}

class TagChatEventChat3 extends TagChatEvent {
  final String message;
  TagChatEventChat3({
    @required this.message
  });
}

class TagChatEventChat4 extends TagChatEvent {
  final String message;
  TagChatEventChat4({
    @required this.message
  });
}

class TagChatEventChat5 extends TagChatEvent {
  final String message;
  TagChatEventChat5({
    @required this.message
  });
}

class TagChatEventComplete extends TagChatEvent {}

class TagChatEventBegin extends TagChatEvent {}