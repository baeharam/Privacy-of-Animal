import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class SameMatchEvent extends BlocEvent{}

class SameMatchEventStateClear extends SameMatchEvent {}

class SameMatchEventFindUser extends SameMatchEvent {}

class SameMatchEventSendRequest extends SameMatchEvent {
  final String uid;

  SameMatchEventSendRequest({@required this.uid});
}

class SameMatchEventCancelRequest extends SameMatchEvent {
  final String uid;

  SameMatchEventCancelRequest({@required this.uid});
}

class SameMatchEventRefreshLoading extends SameMatchEvent {}
class SameMatchEventRefreshFriends extends SameMatchEvent {}
class SameMatchEventRefreshRequestFrom extends SameMatchEvent {}
class SameMatchEventRefreshRequestTo extends SameMatchEvent {}

class SameMatchEventConnectToServer extends SameMatchEvent {
  final String otherUserUID;
  SameMatchEventConnectToServer({@required this.otherUserUID});
}
class SameMatchEventDisconnectToServer extends SameMatchEvent {}

class SameMatchEventEnterOtherProfileScreen extends SameMatchEvent {}