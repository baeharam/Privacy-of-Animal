import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class AuthenticationState extends BlocState {
  final bool isAuthenticated;
  final bool isAuthenticating;
  final bool isFailed;

  AuthenticationState({
    this.isAuthenticated: false,
    this.isAuthenticating: false,
    this.isFailed: false
  });

  factory AuthenticationState.notAuthenticated() {
    return AuthenticationState(
      isAuthenticated: false,
      isAuthenticating: false,
      isFailed: false
    );
  }

  factory AuthenticationState.authenticated() {
    return AuthenticationState(
      isAuthenticated: true,
      isAuthenticating: false,
      isFailed: false
    );
  }

  factory AuthenticationState.authenticating() {
    return AuthenticationState(
      isAuthenticated: false,
      isAuthenticating: true,
      isFailed: false
    );
  }

  factory AuthenticationState.failed() {
    return AuthenticationState(
      isAuthenticated: false,
      isAuthenticating: false,
      isFailed: true
    );
  }
}