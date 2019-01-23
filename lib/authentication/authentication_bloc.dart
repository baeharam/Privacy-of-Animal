
import 'package:privacy_of_animal/authentication/authentication_event.dart';
import 'package:privacy_of_animal/authentication/authentication_state.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class AuthenticaionBloc extends BlocEventStateBase<AuthenticationEvent,AuthenticationState> {
  @override
  Stream<AuthenticationState> eventHandler(AuthenticationEvent event, AuthenticationState currentState) async*{
    
    return null;
  }

}