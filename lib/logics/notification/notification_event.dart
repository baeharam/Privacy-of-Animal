
import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class NotificationEvent extends BlocEvent {}

class NotificationEventFriends extends NotificationEvent {
  final bool value;
  NotificationEventFriends({@required this.value});
}