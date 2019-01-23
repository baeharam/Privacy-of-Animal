
import 'package:blind_chatting_application/authentication/authentication_event.dart';
import 'package:blind_chatting_application/authentication/authentication_state.dart';
import 'package:blind_chatting_application/bloc_helpers/bloc_event_state.dart';

class AuthenticaionBloc extends BlocEventStateBase<AuthenticationEvent,AuthenticationState> {
  @override
  Stream<AuthenticationState> eventHandler(AuthenticationEvent event, AuthenticationState currentState) async*{
    
    return null;
  }

}