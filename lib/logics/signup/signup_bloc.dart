import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/signup/signup.dart';

class SignUpBloc extends BlocEventStateBase<SignUpEvent,SignUpState> {

  static final SignUpAPI _api = SignUpAPI();

  @override
    SignUpState get initialState => SignUpState.notEmailPasswordRegistered();

  @override
  Stream<SignUpState> eventHandler(SignUpEvent event, SignUpState currentState) async*{

    if(event is SignUpEventEmailPasswordInitial){
      yield SignUpState.notEmailPasswordRegistered();
    }
    if(event is SignUpEventProfileInitial){
      yield SignUpState.emailPasswordRegistered();
    }
    
    if(event is SignUpEventEmailPasswordComplete){
      yield SignUpState.emailPasswordRgistering();
      SIGNUP_RESULT result = await _api.registerAccount(event.email, event.password);
      if(result == SIGNUP_RESULT.SUCCESS){
        yield SignUpState.emailPasswordRegistered();
      } else if(result == SIGNUP_RESULT.FAILURE){
        yield SignUpState.emailPasswordFailed();
      }
    }
    if(event is SignUpEventProfileComplete){
      yield SignUpState.profileRegistering();
      SIGNUP_RESULT result = await _api.registerProfile(event.data);
      if(result == SIGNUP_RESULT.SUCCESS){
        yield SignUpState.profileRegistered();
      } else if(result == SIGNUP_RESULT.FAILURE){
        yield SignUpState.profileFailed();
        yield SignUpState.emailPasswordRegistered();
      }
    }
  }
}