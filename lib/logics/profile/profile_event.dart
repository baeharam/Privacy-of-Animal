import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class ProfileEvent extends BlocEvent{}

class ProfileEventResetFakeProfile extends ProfileEvent {}

class ProfileEventInitial extends ProfileEvent {}