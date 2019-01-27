import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class LoginState extends BlocState {
  final bool isAuthenticated;
  final bool isAuthenticating;
  final bool isFailed;

  LoginState({
    this.isAuthenticated: false,
    this.isAuthenticating: false,
    this.isFailed: false
  });

  factory LoginState.notAuthenticated() {
    return LoginState(
      isAuthenticated: false,
      isAuthenticating: false,
      isFailed: false
    );
  }

  factory LoginState.authenticated() {
    return LoginState(
      isAuthenticated: true,
      isAuthenticating: false,
      isFailed: false
    );
  }

  factory LoginState.authenticating() {
    return LoginState(
      isAuthenticated: false,
      isAuthenticating: true,
      isFailed: false
    );
  }

  factory LoginState.failed() {
    return LoginState(
      isAuthenticated: false,
      isAuthenticating: false,
      isFailed: true
    );
  }
}