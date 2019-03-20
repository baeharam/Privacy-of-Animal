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

  final bool isNotificationToggleSucceeded;
  final bool isNotificationToggleFalied;

  FriendsChatState({
    this.isInitial: false,
    this.isSendSucceeded: false,
    this.isSendFailed: false,
    this.isStoreSucceeded: false,
    this.isStoreFailed: false,
    this.isTimestampFetchSucceeded: false,
    this.isTimestampFetchFailed: false,
    this.timestamp,

    this.isNotificationToggleSucceeded: false,
    this.isNotificationToggleFalied: false
  });

  factory FriendsChatState.initial() => FriendsChatState(isInitial: true);

  factory FriendsChatState.sendSucceeded() => FriendsChatState(isSendSucceeded: true);
  factory FriendsChatState.sendFailed() => FriendsChatState(isSendFailed: true);

  factory FriendsChatState.storeSucceeded() => FriendsChatState(isStoreSucceeded: true);
  factory FriendsChatState.storeFailed() => FriendsChatState(isStoreFailed: true);

  factory FriendsChatState.timeStampFetchSucceeded(Timestamp timestamp) {
    return FriendsChatState(
      isTimestampFetchSucceeded: true,
      timestamp: timestamp
    );
  }
  factory FriendsChatState.timeStampFetchFailed() => FriendsChatState(isTimestampFetchFailed: true);

  factory FriendsChatState.notificationToggleSucceeded() 
    => FriendsChatState(isNotificationToggleSucceeded: true);
  factory FriendsChatState.notificationToggleFailed() 
    => FriendsChatState(isNotificationToggleFalied: true);
}