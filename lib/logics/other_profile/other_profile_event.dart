
import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/models/user_model.dart';

abstract class OtherProfileEvent extends BlocEvent {}

class OtherProfileEventStateClear extends OtherProfileEvent {}

class OtherProfileEventAlreadyFriends extends OtherProfileEvent {}
class OtherProfileEventAlreadyRequest extends OtherProfileEvent {}

class OtherProfileEventSendRequest extends OtherProfileEvent{
  final String uid;
  OtherProfileEventSendRequest({@required this.uid});
}

class OtherProfileEventCancelRequest extends OtherProfileEvent {
  final String uid;
  OtherProfileEventCancelRequest({@required this.uid});
}

class OtherProfileEventConnectToServer extends OtherProfileEvent {
  final UserModel otherUser;
  OtherProfileEventConnectToServer({@required this.otherUser});
}
class OtherProfileEventDisconnectToServer extends OtherProfileEvent {}