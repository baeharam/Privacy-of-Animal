import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class PhotoEvent extends BlocEvent{}

class PhotoEventTaking extends PhotoEvent {}

class PhotoEventGotoAnalysis extends PhotoEvent {}