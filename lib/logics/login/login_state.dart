import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class LoginState extends BlocState {
  final bool isAuthenticated;
  final bool isAuthenticating;
  final bool isAuthenticationFailed;
  final bool isDialogOpenedForPassword;

  LoginState({
    this.isAuthenticated: false,
    this.isAuthenticating: false,
    this.isAuthenticationFailed: false,
    this.isDialogOpenedForPassword: false,
  });

  factory LoginState.notAuthenticated() {
    return LoginState(
      isAuthenticated: false,
      isAuthenticating: false,
      isAuthenticationFailed: false,
      isDialogOpenedForPassword: false
    );
  }

  factory LoginState.authenticated() {
    return LoginState(
      isAuthenticated: true,
      isAuthenticating: false,
      isAuthenticationFailed: false,
      isDialogOpenedForPassword: false
    );
  }

  factory LoginState.authenticating() {
    return LoginState(
      isAuthenticated: false,
      isAuthenticating: true,
      isAuthenticationFailed: false,
      isDialogOpenedForPassword: false
    );
  }

  factory LoginState.authenticationFailed() {
    return LoginState(
      isAuthenticated: false,
      isAuthenticating: false,
      isAuthenticationFailed: true,
      isDialogOpenedForPassword: false
    );
  }

  factory LoginState.openDialogForPassword() {
    return LoginState(
      isAuthenticated: false,
      isAuthenticating: false,
      isAuthenticationFailed: false,
      isDialogOpenedForPassword: true
    );
  }
}