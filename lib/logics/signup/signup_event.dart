import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/models/signup_model.dart';

abstract class SignUpEvent extends BlocEvent{}

class SignUpEventInitial extends SignUpEvent {}

class SignUpEventComplete extends SignUpEvent {
  final SignUpModel data;


  SignUpEventComplete({
    @required this.data
  });
}
