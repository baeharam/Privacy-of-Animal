import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class FriendsChatState extends BlocState {
  final bool isInitial;
  final bool isSendSucceeded;
  final bool isSendFailed;

  final bool isMyMessage;
  final bool isMessageReceived;

  final bool isNotificationToggleSucceeded;
  final bool isNotificationToggleFalied;

  FriendsChatState({
    this.isInitial: false,
    this.isSendSucceeded: false,
    this.isSendFailed: false,

    this.isMyMessage: false,
    this.isMessageReceived: false,

    this.isNotificationToggleSucceeded: false,
    this.isNotificationToggleFalied: false
  });

  factory FriendsChatState.initial() => FriendsChatState(isInitial: true);

  factory FriendsChatState.sendSucceeded() => FriendsChatState(isSendSucceeded: true);
  factory FriendsChatState.sendFailed() => FriendsChatState(isSendFailed: true);

  factory FriendsChatState.myMessage() => FriendsChatState(isMyMessage: true);
  factory FriendsChatState.messageReceived() => FriendsChatState(isMessageReceived: true);

  factory FriendsChatState.notificationToggleSucceeded() 
    => FriendsChatState(isNotificationToggleSucceeded: true);
  factory FriendsChatState.notificationToggleFailed() 
    => FriendsChatState(isNotificationToggleFalied: true);
}