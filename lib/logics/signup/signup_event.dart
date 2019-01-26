import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class SignUpEvent extends BlocEvent{}

class SignUpEventProfileComplete extends SignUpEvent {
  final String name;
  final String age;
  final String job;
  final String gender;

  SignUpEventProfileComplete({
    @required this.name,
    @required this.age,
    @required this.job,
    @required this.gender
  });
}

class SignUpEventEmailPasswordComplete extends SignUpEvent {
  final String email;
  final String password;

  SignUpEventEmailPasswordComplete({
    @required this.email,
    @required this.password
  });
}
