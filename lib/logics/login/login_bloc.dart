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
      LOGIN_RESULT result = await _api.login(event.email, event.password);
      if(result == LOGIN_RESULT.SUCCESS){
        USER_CONDITION condition = await _api.checkUserCondition();
        switch(condition){
          case USER_CONDITION.NONE:
            yield LoginState.authenticatedNormal();
            break;
          case USER_CONDITION.TAG_SELECTED:
            yield LoginState.authenticatedTagSelected();
            break;
          case USER_CONDITION.TAG_CHATTED:
            yield LoginState.authenticatedTagChatted();
            break;
          // 모든 작업을 끝낸 경우, 데이터를 가져온 상태일 수도 있고
          // 아닌 상태일 수도 있으므로 데이터를 가져온다.
          case USER_CONDITION.FACE_ANALYZED:
            FETCH_RESULT result = await _api.fetchUserData();
            if(result==FETCH_RESULT.SUCCESS){
              yield LoginState.authenticatedFaceAnalyzed();
            }
            else {
              yield LoginState.authenticationFailed();
            }
            break;
        }
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