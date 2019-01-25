import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class AuthenticationEvent extends BlocEvent{}

class AuthenticationEventLogin extends AuthenticationEvent {
  final String email;
  final String password;

  AuthenticationEventLogin({
    @required this.email,
    @required this.password
  });
}

class AuthenticationEventSignUp extends AuthenticationEvent {
  final String email;
  final String password;

  AuthenticationEventSignUp({
    this.email,
    this.password
  });
}

class AuthenticationEventLogout extends AuthenticationEvent {}