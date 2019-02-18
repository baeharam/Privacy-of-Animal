import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class SettingState extends BlocState {
  final bool isInitial;
  final bool isLogoutLoading;
  final bool isLogoutSucceeded;
  final bool isLogoutFailed;

  final bool isGetoutLoading;
  final bool isGetoutSucceeded;
  final bool isGetoutFailed;

  SettingState({
    this.isInitial: false,
    this.isLogoutLoading: false,
    this.isLogoutSucceeded: false,
    this.isLogoutFailed: false,

    this.isGetoutLoading: false,
    this.isGetoutSucceeded: false,
    this.isGetoutFailed: false
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

  factory SettingState.getoutLoading() {
    return SettingState(
      isGetoutLoading: true
    );
  }

  factory SettingState.getoutSucceeded() {
    return SettingState(
      isGetoutSucceeded: true
    );
  }

  factory SettingState.getoutFailed() {
    return SettingState(
      isGetoutFailed: true
    );
  }
}