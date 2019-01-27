import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/login/login.dart';

class LoginBloc extends BlocEventStateBase<LoginEvent,LoginState> {

  static final LoginAPI _api = LoginAPI();

  @override
    LoginState get initialState => LoginState.notAuthenticated();

  @override
  Stream<LoginState> eventHandler(LoginEvent event, LoginState currentState) async*{

    if(event is LoginEventForgotPasswordDialog){
      yield LoginState.openDialogForPassword();
    }
    
    if(event is LoginEventInitial){
      yield LoginState.notAuthenticated();
    }
    
    if(event is LoginEventLogin){
      yield LoginState.authenticating();
      LOGIN_RESULT result = 
        await _api.login(event.email, event.password);
      if(result == LOGIN_RESULT.SUCCESS){
        yield LoginState.authenticated();
      }
      else if(result == LOGIN_RESULT.FAILURE){
        yield LoginState.authenticationFailed();
      }
    }

    else if(event is LoginEventLogout){
      yield LoginState.notAuthenticated();
    }
  }
}