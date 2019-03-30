import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/models/user_model.dart';

abstract class FriendsEvent extends BlocEvent {}

class FriendsEventStateClear extends FriendsEvent {}

class FriendsEventFriendsIncreased extends FriendsEvent {
  final List<DocumentChange> friends;
  FriendsEventFriendsIncreased({@required this.friends});
}

class FriendsEventFriendsDecreased extends FriendsEvent {
  final List<DocumentChange> friends;
  FriendsEventFriendsDecreased({@required this.friends});
}

class FriendsEventRequestIncreased extends FriendsEvent {
  final List<DocumentChange> request;
  FriendsEventRequestIncreased({@required this.request});
}

class FriendsEventRequestDecreased extends FriendsEvent {
  final List<DocumentChange> request;
  FriendsEventRequestDecreased({@required this.request});
}

class FriendsEventChat extends FriendsEvent {
  final UserModel user;
  FriendsEventChat({@required this.user});
}

class FriendsEventBlockFromLocal extends FriendsEvent {
  final UserModel userToBlock;
  FriendsEventBlockFromLocal({@required this.userToBlock});
}

class FriendsEventBlockFromServer extends FriendsEvent {
  final UserModel userToBlock;
  FriendsEventBlockFromServer({@required this.userToBlock});
}

class FriendsEventAcceptFromServer extends FriendsEvent {
  final UserModel userToAccept;
  FriendsEventAcceptFromServer({@required this.userToAccept});
}

class FriendsEventAcceptFromLocal extends FriendsEvent {
  final UserModel userToAccept;
  FriendsEventAcceptFromLocal({@required this.userToAccept});
}

class FriendsEventRejectFromLocal extends FriendsEvent {
  final UserModel userToReject;
  FriendsEventRejectFromLocal({@required this.userToReject});
}

class FriendsEventRejectFromServer extends FriendsEvent {
  final UserModel userToReject;
  FriendsEventRejectFromServer({@required this.userToReject});
}

class FriendsEventFriendsAccepted extends FriendsEvent {}

class FriendsEventNewFriends extends FriendsEvent {
  final int newFriendsNum;
  FriendsEventNewFriends({@required this.newFriendsNum});
}

class FriendsEventFriendsNotification extends FriendsEvent {}
