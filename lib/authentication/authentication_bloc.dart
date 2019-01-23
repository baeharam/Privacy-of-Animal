import 'package:firebase_auth/firebase_auth.dart';
import 'package:privacy_of_animal/authentication/authentication.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class AuthenticaionBloc extends BlocEventStateBase<AuthenticationEvent,AuthenticationState> {

  static final AuthenticationAPI _api = AuthenticationAPI();

  @override
  Stream<AuthenticationState> eventHandler(AuthenticationEvent event, AuthenticationState currentState) async*{
    
    if(event is AuthenticationEventLogin){
      FirebaseUser loginResult = 
        await _api.loginWithFirebase(event.email, event.password);
    }

    return null;
  }
}