import 'package:privacy_of_animal/authentication/authentication.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class AuthenticaionBloc extends BlocEventStateBase<AuthenticationEvent,AuthenticationState> {

  static final AuthenticationAPI _api = AuthenticationAPI();

  @override
  Stream<AuthenticationState> eventHandler(AuthenticationEvent event, AuthenticationState currentState) async*{
    
    yield AuthenticationState.authenticating();
    if(event is AuthenticationEventLogin){
      AUTH_RESULT result = 
        await _api.loginWithFirebase(event.email, event.password);
      if(result == AUTH_RESULT.SUCCESS){
        yield AuthenticationState.authenticated();
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