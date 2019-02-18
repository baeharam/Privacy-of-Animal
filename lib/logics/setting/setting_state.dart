import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class SettingState extends BlocState {
  final bool isInitial;
  final bool isLogoutLoading;
  final bool isLogoutSucceeded;
  final bool isLogoutFailed;

  SettingState({
    this.isInitial: false,
    this.isLogoutLoading: false,
    this.isLogoutSucceeded: false,
    this.isLogoutFailed: false
  });

  factory SettingState.initial() {
    return SettingState(
      isInitial: true
    );
  }

  factory SettingState.logoutLoading() {
    return SettingState(
      isLogoutLoading: true
    );
  }

  factory SettingState.logoutSucceeded() {
    return SettingState(
      isLogoutSucceeded: true
    );
  }

  factory SettingState.logoutFailed() {
    return SettingState(
      isLogoutFailed: true
    );
  }
}