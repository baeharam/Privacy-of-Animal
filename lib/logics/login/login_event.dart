import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class LoginEvent extends BlocEvent{}

class LoginEventInitial extends LoginEvent {}

class LoginEventLogin extends LoginEvent {
  final String email;
  final String password;

  LoginEventLogin({
    @required this.email,
    @required this.password
  });
}

class LoginEventForgotPasswordDialog extends LoginEvent {}

class LoginEventLogout extends LoginEvent {}