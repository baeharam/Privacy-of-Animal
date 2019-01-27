import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class SignUpEvent extends BlocEvent{}

class SignUpEventInitial extends SignUpEvent {}

class SignUpEventComplete extends SignUpEvent {
  final String email;
  final String password;

  SignUpEventComplete({
    @required this.email,
    @required this.password
  });
}
