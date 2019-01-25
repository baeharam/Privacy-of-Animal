import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class FocusEvent extends BlocEvent {}

class FocusEventOn extends FocusEvent {}
class FocusEventOff extends FocusEvent {}