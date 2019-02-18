import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class FriendsChatState extends BlocState {
  final bool isInitial;
  final bool isSendSucceeded;
  final bool isSendFailed;

  final bool isStoreSucceeded;
  final bool isStoreFailed;

  final bool isTimestampFetchSucceeded;
  final bool isTimestampFetchFailed;
  final Timestamp timestamp;

  FriendsChatState({
    this.isInitial: false,
    this.isSendSucceeded: false,
    this.isSendFailed: false,
    this.isStoreSucceeded: false,
    this.isStoreFailed: false,
    this.isTimestampFetchSucceeded: false,
    this.isTimestampFetchFailed: false,
    this.timestamp
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

  factory FriendsChatState.timeStampFetchSucceeded(Timestamp timestamp) {
    return FriendsChatState(
      isTimestampFetchSucceeded: true,
      timestamp: timestamp
    );
  }

  factory FriendsChatState.timeStampFetchFailed() {
    return FriendsChatState(
      isTimestampFetchFailed: true
    );
  }
}