import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class RandomLoadingEvent extends BlocEvent{}

class RandomLoadingEventStateClear extends RandomLoadingEvent {}

class RandomLoadingEventMatchStart extends RandomLoadingEvent {}

class RandomLoadingEventCancel extends RandomLoadingEvent {}

class RandomLoadingEventUserEntered extends RandomLoadingEvent {
  final String receiver;
  final String chatRoomID;

  RandomLoadingEventUserEntered({@required this.receiver,@required this.chatRoomID});
}