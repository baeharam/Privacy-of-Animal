import 'dart:async';

import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/setting/setting.dart';

class SettingBloc extends BlocEventStateBase<SettingEvent,SettingState>
{
  static final SettingAPI _api = SettingAPI();

  @override
  SettingState get initialState => SettingState.initial();

  @override
  Stream<SettingState> eventHandler(SettingEvent event, SettingState currentState) async*{
    if(event is SettingEventStateClear) {
      yield SettingState.initial();
    }

    if(event is SettingEventLogOut) {
      try {
        yield SettingState.logoutLoading();
        await _api.logout();
        yield SettingState.logoutSucceeded();
      } catch(exception) {
        print(exception);
        yield SettingState.logoutFailed();
      }
    }
  }
}