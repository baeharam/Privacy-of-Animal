import 'package:meta/meta.dart';
import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';
import 'package:privacy_of_animal/model/real_profile_table_model.dart';

abstract class SignUpEvent extends BlocEvent{}

class SignUpEventEmailPasswordInitial extends SignUpEvent {}
class SignUpEventProfileInitial extends SignUpEvent {}

class SignUpEventProfileComplete extends SignUpEvent {
  final RealProfileTableModel data;

  SignUpEventProfileComplete({
    @required this.data
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
