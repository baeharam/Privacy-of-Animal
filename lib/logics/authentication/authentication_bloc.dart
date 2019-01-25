import 'package:privacy_of_animal/logics/authentication/authentication.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class AuthenticationBloc extends BlocEventStateBase<AuthenticationEvent,AuthenticationState> {

  static final AuthenticationAPI _api = AuthenticationAPI();

  @override
    AuthenticationState get initialState => AuthenticationState.notAuthenticated();

  @override
  Stream<AuthenticationState> eventHandler(AuthenticationEvent event, AuthenticationState currentState) async*{
    
    yield AuthenticationState.authenticating();
    if(event is AuthenticationEventLogin){
      AUTH_RESULT result = 
        await _api.loginWithFirebase(event.email, event.password);
      if(result == AUTH_RESULT.SUCCESS){
        yield AuthenticationState.authenticatedNormal();
      }
      else if(result == AUTH_RESULT.FAILURE){
        yield AuthenticationState.failed();
      }
    }

    else if(event is AuthenticationEventSignUp){
      AUTH_RESULT result = 
        await _api.signUpWithFirebase(event.email, event.password);
      if(result == AUTH_RESULT.SUCCESS){
        yield AuthenticationState.authenticatedNormal();
      }
      else if(result == AUTH_RESULT.FAILURE){
        yield AuthenticationState.failed();
      }
    }

    else if(event is AuthenticationEventLogout){
      yield AuthenticationState.notAuthenticated();
    }
  }
}