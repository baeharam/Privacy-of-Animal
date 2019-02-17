import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class FriendsChatState extends BlocState {
  final bool isInitial;
  final bool isSendSucceeded;
  final bool isSendFailed;

  FriendsChatState({
    this.isInitial: false,
    this.isSendSucceeded: false,
    this.isSendFailed
  });

  factory FriendsChatState.initial() {
    return FriendsChatState(
      isInitial: true
    );
  }

  factory FriendsChatState.sendSucceeded() {
    return FriendsChatState(
      isSendSucceeded: true
    );
  }

  factory FriendsChatState.sendFailed() {
    return FriendsChatState(
      isSendFailed: true
    );
  }
}