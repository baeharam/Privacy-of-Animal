import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/signup/signup.dart';
import 'package:privacy_of_animal/model/real_profile_table_model.dart';

class SignUpBloc extends BlocEventStateBase<SignUpEvent,SignUpState> {

  static final SignUpAPI _api = SignUpAPI();
  static RealProfileTableModel _data = RealProfileTableModel();

  @override
    SignUpState get initialState => SignUpState.notProfileCompleted();

  @override
  Stream<SignUpState> eventHandler(SignUpEvent event, SignUpState currentState) async*{
    
    if(event is SignUpEventProfileComplete){
      _data.name = event.name;
      _data.age = int.parse(event.age);
      _data.job = event.job;
      yield SignUpState.profileCompleted();
    }
    if(event is SignUpEventEmailPasswordComplete){
      yield SignUpState.registering();
      SIGNUP_RESULT result = await _api.signUpWithFirebase(event.email, event.password, _data);
      if(result == SIGNUP_RESULT.SUCCESS){
        yield SignUpState.registered();
      } else if(result == SIGNUP_RESULT.FAILURE){
        yield SignUpState.failed();
      }
    }
  }
}