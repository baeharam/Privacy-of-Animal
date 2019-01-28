import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/signup/signup.dart';

class SignUpBloc extends BlocEventStateBase<SignUpEvent,SignUpState> {

  static final SignUpAPI _api = SignUpAPI();

  @override
    SignUpState get initialState => SignUpState.notRegistered();

  @override
  Stream<SignUpState> eventHandler(SignUpEvent event, SignUpState currentState) async*{

    if(event is SignUpEventInitial){
      yield SignUpState.notRegistered();
    }

    if(event is SignUpEventAgeSelect){
      yield SignUpState.ageSelected(event.age);
    }
    
    if(event is SignUpEventComplete){
      yield SignUpState.registering();
      SIGNUP_RESULT signupResult = await _api.registerAccount(event.data);
      if(signupResult == SIGNUP_RESULT.SUCCESS){
        PROFILE_RESULT profileResult = await _api.registerProfile(event.data);
        if(profileResult == PROFILE_RESULT.SUCCESS){
          yield SignUpState.registered();
        } else if(profileResult == PROFILE_RESULT.FAILURE){
          yield SignUpState.failed();
        }
      } else if(signupResult == SIGNUP_RESULT.FAILURE){
        yield SignUpState.failed();
      }
    }
  }
}