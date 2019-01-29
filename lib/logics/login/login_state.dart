import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class LoginState extends BlocState {
  final bool isAuthenticated;
  final bool isTagSelected;
  final bool isFaceAnalyzed;
  final bool isAuthenticating;
  final bool isAuthenticationFailed;
  final bool isDialogOpenedForPassword;

  LoginState({
    this.isAuthenticated: false,
    this.isTagSelected: false,
    this.isFaceAnalyzed: false,
    this.isAuthenticating: false,
    this.isAuthenticationFailed: false,
    this.isDialogOpenedForPassword: false,
  });

  factory LoginState.notAuthenticated() {
    return LoginState(
      isAuthenticated: false
    );
  }

  factory LoginState.authenticatedNormal() {
    return LoginState(
      isAuthenticated: true
    );
  }

  factory LoginState.authenticatedTagSelected() {
    return LoginState(
      isAuthenticated: true,
      isTagSelected: true
    );
  }

  factory LoginState.authenticatedFaceAnalyzed() {
    return LoginState(
      isAuthenticated: true,
      isFaceAnalyzed: true
    );
  }

  factory LoginState.authenticating() {
    return LoginState(
      isAuthenticating: true
    );
  }

  factory LoginState.authenticationFailed() {
    return LoginState(
      isAuthenticationFailed: true
    );
  }

  factory LoginState.openDialogForPassword() {
    return LoginState(
      isDialogOpenedForPassword: true
    );
  }
}