import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class OtherProfileEvent extends BlocEvent {}

class OtherProfileEventStateClear extends OtherProfileEvent {}

class OtherProfileEventRefreshLoading extends OtherProfileEvent {}
class OtherProfileEventRefreshFriends extends OtherProfileEvent {}
class OtherProfileEventRefreshRequestFrom extends OtherProfileEvent {}
class OtherProfileEventRefreshRequestTo extends OtherProfileEvent {}

class OtherProfileEventSendRequest extends OtherProfileEvent{
  final String uid;
  OtherProfileEventSendRequest({@required this.uid});
}

class OtherProfileEventCancelRequest extends OtherProfileEvent {
  final String uid;
  OtherProfileEventCancelRequest({@required this.uid});
}

class OtherProfileEventConnectToServer extends OtherProfileEvent {
  final String otherUserUID;
  OtherProfileEventConnectToServer({@required this.otherUserUID});
}
class OtherProfileEventDisconnectToServer extends OtherProfileEvent {
  final String otherUserUID;
  OtherProfileEventDisconnectToServer({@required this.otherUserUID});
}

class OtherProfileEventGetOut extends OtherProfileEvent {}