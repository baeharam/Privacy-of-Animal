import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/models/user_model.dart';

abstract class FriendsEvent extends BlocEvent {}

class FriendsEventStateClear extends FriendsEvent {}

class FriendsEventRefreshFriends extends FriendsEvent {
  final List<dynamic> friends;
  FriendsEventRefreshFriends({@required this.friends});
}

class FriendsEventRefreshRequest extends FriendsEvent {
  final List<dynamic> friendsRequest;
  FriendsEventRefreshRequest({@required this.friendsRequest});
}

class FriendsEventChat extends FriendsEvent {
  final UserModel user;
  FriendsEventChat({@required this.user});
}

class FriendsEventBlockFromLocal extends FriendsEvent {
  final UserModel user;
  FriendsEventBlockFromLocal({@required this.user});
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
