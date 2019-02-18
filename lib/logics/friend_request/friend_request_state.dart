
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class FriendRequestState extends BlocState {
  final bool isInitial;
  final bool isSucceeded;
  final bool isFailed;

  FriendRequestState({
    this.isInitial: false,
    this.isSucceeded: false,
    this.isFailed: false
  });

  factory FriendRequestState.initial() {
    return FriendRequestState(
      isInitial: true
    );
  }

  factory FriendRequestState.requestSucceeded() {
    return FriendRequestState(
      isSucceeded: true
    );
  }

  factory FriendRequestState.requestFailed() {
    return FriendRequestState(
      isFailed: true
    );
  }
}