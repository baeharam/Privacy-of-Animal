import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/login/login.dart';

class LoginBloc extends BlocEventStateBase<LoginEvent,LoginState> {

  static final LoginAPI _api = LoginAPI();

  @override
    LoginState get initialState => LoginState.notAuthenticated();

  @override
  Stream<LoginState> eventHandler(LoginEvent event, LoginState currentState) async*{
    
    yield LoginState.authenticating();
    if(event is LoginEventLogin){
      LOGIN_RESULT result = 
        await _api.loginWithFirebase(event.email, event.password);
      if(result == LOGIN_RESULT.SUCCESS){
        yield LoginState.authenticated();
      }
      else if(result == LOGIN_RESULT.FAILURE){
        yield LoginState.failed();
      }
    }

    else if(event is LoginEventLogout){
      yield LoginState.notAuthenticated();
    }
  }
}