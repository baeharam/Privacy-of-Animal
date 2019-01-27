import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

abstract class FindPasswordEvent extends BlocEvent{}

class FindPasswordEventInitial extends FindPasswordEvent {}

class FindPasswordEventForgotPasswordButton extends FindPasswordEvent {
  final String email;
  FindPasswordEventForgotPasswordButton({@required this.email});
}