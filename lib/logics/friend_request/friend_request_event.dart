
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class FriendRequestEvent extends BlocEvent{
  final String uid;

  FriendRequestEvent({
    this.uid
  });
}