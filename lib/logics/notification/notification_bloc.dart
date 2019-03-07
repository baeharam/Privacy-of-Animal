import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/notification/notification.dart';

class NotificationBloc extends BlocEventStateBase<NotificationEvent,NotificationState> {

  static final NotificationAPI _api = NotificationAPI();

  @override
    NotificationState get initialState => NotificationState.initial();

  @override
  Stream<NotificationState> eventHandler(NotificationEvent event, NotificationState currentState) async*{
    if(event is NotificationEventFriends){
      try {
        await _api.setFriendsNotification(event.value);
        yield event.value 
          ? NotificationState.friendsNotificationOnSucceeded()
          : NotificationState.friendsNotificationOffSucceeded();
      } catch (exception) {
        print(exception);
      }
    }
  }
}