
import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class NotificationEvent extends BlocEvent {}

class NotificationEventFriendsRequest extends NotificationEvent {
  final bool value;
  NotificationEventFriendsRequest({@required this.value});
}
class NotificationEventMessages extends NotificationEvent {
  final bool value;
  NotificationEventMessages({@required this.value});
}