
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class FriendRequestEvent extends BlocEvent {}

class FriendRequestEventStateClear extends FriendRequestEvent {}

class FriendRequestEventSendRequest extends FriendRequestEvent{
  final String uid;

  FriendRequestEventSendRequest({
    this.uid
  });
}