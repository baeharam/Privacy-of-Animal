import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class ProfileEvent extends BlocEvent{}

class ProfileEventStateClear extends ProfileEvent {}

class ProfileEventResetFakeProfile extends ProfileEvent {}