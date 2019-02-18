import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class SameMatchEvent extends BlocEvent{}

class SameMatchEventStateClear extends SameMatchEvent {}

class SameMatchEventFindUser extends SameMatchEvent {}