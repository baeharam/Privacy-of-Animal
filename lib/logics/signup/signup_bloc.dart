import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/signup/signup.dart';

class SignUpBloc extends BlocEventStateBase<SignUpEvent,SignUpState> {

  static final SignUpAPI _api = SignUpAPI();
  
  @override
  SignUpState get initialState => SignUpState.initial();

  @override
  Stream<SignUpState> eventHandler(SignUpEvent event, SignUpState currentState) async*{

    if(event is SignUpEventStateClear){
      yield SignUpState.initial();
    }

    if(event is SignUpEventAgeSelect){
      yield SignUpState.ageSelected(event.age);
    }

    if(event is SignUpEventMaleSelect){
      yield SignUpState.maleSelected();
    }

    if(event is SignUpEventFemaleSelect){
      yield SignUpState.femaleSelected();
    }
    
    if(event is SignUpEventComplete){
      yield SignUpState.registering();
      try {
        await _api.registerAccount(event.data);
        try {
          await _api.registerProfile(event.data);
          yield SignUpState.registered();
        } catch(exception) {
          print('프로필등록 실패: ${exception.toString()}');
          try {
            await _api.deleteUser();
          } catch(exception) {
            print('프로필등록 실패로 인한 계정삭제 실패: ${exception.toString()}');
          }
          yield SignUpState.profileRegisterFailed();
        }
      } catch(exception) {
        print('계정등록 실패: ${exception.toString()}');
        yield SignUpState.accountRegisterFailed();
      }
    }
  }
}