import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class FriendsChatState extends BlocState {
  final bool isInitial;
  final bool isSendSucceeded;
  final bool isSendFailed;

  final bool isStoreSucceeded;
  final bool isStoreFailed;

  FriendsChatState({
    this.isInitial: false,
    this.isSendSucceeded: false,
    this.isSendFailed: false,
    this.isStoreSucceeded: false,
    this.isStoreFailed
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

  factory FriendsChatState.storeSucceeded() {
    return FriendsChatState(
      isStoreSucceeded: true
    );
  }

  factory FriendsChatState.storeFailed() {
    return FriendsChatState(
      isStoreFailed: true
    );
  }
}