import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class LoginEvent extends BlocEvent{}

class LoginEventLogin extends LoginEvent {
  final String email;
  final String password;

  LoginEventLogin({
    @required this.email,
    @required this.password
  });
}

class LoginEventLogout extends LoginEvent {}