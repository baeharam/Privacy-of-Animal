import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/logics/find_password/find_password.dart';

class FindPasswordBloc extends BlocEventStateBase<FindPasswordEvent,FindPasswordState> {

  static final FindPasswordAPI _api = FindPasswordAPI();

  @override
    FindPasswordState get initialState => FindPasswordState.initial();

  @override
  Stream<FindPasswordState> eventHandler(FindPasswordEvent event, FindPasswordState currentState) async*{

    if(event is FindPasswordEventInitial){
      yield FindPasswordState.initial();
    }

    if(event is FindPasswordEventForgotPasswordButton){
      yield FindPasswordState.loading();

      FIND_PASSWORD_RESULT result = await _api.findPassword(event.email);
      if(result == FIND_PASSWORD_RESULT.SUCCESS){
        yield FindPasswordState.succeeded();
      }
      else if(result == FIND_PASSWORD_RESULT.FAILURE){
        yield FindPasswordState.failed();
      }
    }
  }
}