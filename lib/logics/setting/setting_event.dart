import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class SettingEvent extends BlocEvent{}

class SettingEventStateClear extends SettingEvent {}

class SettingEventLogOut extends SettingEvent {}

class SettingEventGetOut extends SettingEvent {}