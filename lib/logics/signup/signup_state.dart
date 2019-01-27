import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class SignUpState extends BlocState {
  final bool isRegistered;
  final bool isRegistering;
  final bool isFailed;

  SignUpState({
    this.isRegistered: false,
    this.isRegistering: false,
    this.isFailed: false,
  });

  factory SignUpState.notRegistered() {
    return SignUpState(
      isRegistered: false,
      isRegistering: false,
      isFailed: false,
    );
  }

  factory SignUpState.registered() {
    return SignUpState(
      isRegistered: true,
      isRegistering: false,
      isFailed: false,
    );
  }

  factory SignUpState.registering() {
    return SignUpState(
      isRegistered: false,
      isRegistering: true,
      isFailed: false,
    );
  }

  factory SignUpState.failed() {
    return SignUpState(
      isRegistered: false,
      isRegistering: false,
      isFailed: true,
    );
  }
}