import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/models/user_model.dart';

abstract class FriendsEvent extends BlocEvent {}

class FriendsEventStateClear extends FriendsEvent {}

class FriendsEventFetchFriendsList extends FriendsEvent {
  final List<dynamic> friends;
  FriendsEventFetchFriendsList({@required this.friends});
}

class FriendsEventFetchFriendsRequestList extends FriendsEvent {
  final List<dynamic> friendsRequest;
  FriendsEventFetchFriendsRequestList({@required this.friendsRequest});
}

class FriendsEventChat extends FriendsEvent {
  final UserModel user;
  FriendsEventChat({@required this.user});
}

class FriendsEventBlock extends FriendsEvent {
  final UserModel user;
  FriendsEventBlock({@required this.user});
}

class FriendsEventRequestAccept extends FriendsEvent {
  final UserModel user;
  FriendsEventRequestAccept({@required this.user});
}

class FriendsEventRequestReject extends FriendsEvent {
  final UserModel user;
  FriendsEventRequestReject({@required this.user});
}

class FriendsEventFriendsAccepted extends FriendsEvent {}

class FriendsEventNewFriends extends FriendsEvent {
  final int newFriendsNum;
  FriendsEventNewFriends({@required this.newFriendsNum});
}
