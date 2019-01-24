import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class AuthenticationState extends BlocState {
  final bool isAuthenticated;
  final bool isAuthenticating;
  final bool isFailed;

  final bool isSelectTags;
  final bool isAnalyzePhoto;

  AuthenticationState({
    this.isAuthenticated: false,
    this.isAuthenticating: false,
    this.isFailed: false,
    this.isSelectTags: false,
    this.isAnalyzePhoto: false
  });

  factory AuthenticationState.notAuthenticated() {
    return AuthenticationState(
      isAuthenticated: false,
      isAuthenticating: false,
      isFailed: false,
      isSelectTags: false,
      isAnalyzePhoto: false
    );
  }

  factory AuthenticationState.authenticatedNormal() {
    return AuthenticationState(
      isAuthenticated: true,
      isAuthenticating: false,
      isFailed: false,
      isSelectTags: false,
      isAnalyzePhoto: false
    );
  }

  factory AuthenticationState.authenticatedTagged() {
    return AuthenticationState(
      isAuthenticated: true,
      isAuthenticating: false,
      isFailed: false,
      isSelectTags: true,
      isAnalyzePhoto: false
    );
  }

  factory AuthenticationState.authenticatedAnalyzed() {
    return AuthenticationState(
      isAuthenticated: true,
      isAuthenticating: false,
      isFailed: false,
      isSelectTags: true,
      isAnalyzePhoto: true
    );
  }

  factory AuthenticationState.authenticating() {
    return AuthenticationState(
      isAuthenticated: false,
      isAuthenticating: true,
      isFailed: false,
      isSelectTags: false,
      isAnalyzePhoto: false
    );
  }

  factory AuthenticationState.failed() {
    return AuthenticationState(
      isAuthenticated: false,
      isAuthenticating: false,
      isFailed: true,
      isSelectTags: false,
      isAnalyzePhoto: false
    );
  }
}