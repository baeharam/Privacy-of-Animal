import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/current_user.dart';
import 'package:privacy_of_animal/utils/service_locator.dart';

class NotificationState extends BlocState {
  final bool isInitial;
  final bool isFriendsNotificationOnSucceeded;
  final bool isFriendsNotificationOnFailed;

  final bool isFriendsNotificationOffSucceeded;
  final bool isFriendsNotificationOffFailed;

  NotificationState({
    this.isInitial: false,
    this.isFriendsNotificationOnSucceeded: false,
    this.isFriendsNotificationOnFailed: false,

    this.isFriendsNotificationOffSucceeded: false,
    this.isFriendsNotificationOffFailed: false
  });

  factory NotificationState.initial() {
    return NotificationState(
      isInitial: true,
      isFriendsNotificationOnSucceeded: sl.get<CurrentUser>().friendsNotification,
      isFriendsNotificationOffSucceeded: sl.get<CurrentUser>().friendsNotification
    );
  }

  factory NotificationState.friendsNotificationOnSucceeded() 
    => NotificationState(isFriendsNotificationOnSucceeded: true);
  factory NotificationState.friendsNotificationOnFailed() 
    => NotificationState(isFriendsNotificationOnFailed: true);
  factory NotificationState.friendsNotificationOffSucceeded() 
    => NotificationState(isFriendsNotificationOffSucceeded: true);
  factory NotificationState.friendsNotificationOffFailed() 
    => NotificationState(isFriendsNotificationOffFailed: true);
}