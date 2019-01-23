import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class AuthenticationEvent extends BlocEvent{}

class AuthenticationEventLogin extends AuthenticationEvent {
  
  // 다른 플랫폼과 연동하지 않을 시 Firebase 활용한 이메일 인증이기 때문에 전달
  
  final String email;
  final String password;

  AuthenticationEventLogin({
    this.email,
    this.password
  });
}

class AuthenticationEventLogout extends AuthenticationEvent {}