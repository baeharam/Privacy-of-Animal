import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class NotificationState extends BlocState {
  final bool isInitial;
  final bool isFriendsRequestToggled;
  final bool isFriendsRequestFailed;
  final bool isMessagesToggled;
  final bool isMessagesFailed;

  NotificationState({
    this.isInitial: false,
    this.isFriendsRequestToggled: false,
    this.isFriendsRequestFailed: false,
    this.isMessagesToggled: false,
    this.isMessagesFailed: false,
  });

  factory NotificationState.initial() {
    return NotificationState(
      isInitial: true
    );
  }

  factory NotificationState.friendsRequestToggled() {
    return NotificationState(
      isFriendsRequestToggled: true
    );
  }

  factory NotificationState.messagesToggled() {
    return NotificationState(
      isMessagesToggled: true
    );
  }
}