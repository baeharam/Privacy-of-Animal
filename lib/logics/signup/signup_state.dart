import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class SignUpState extends BlocState {
  final bool isProfileCompleted;
  final bool isRegistering;
  final bool isRegisterd;
  final bool isFailed;

  SignUpState({
    this.isProfileCompleted: false,
    this.isRegistering: false,
    this.isRegisterd: false,
    this.isFailed: false
  });

  factory SignUpState.notProfileCompleted() {
    return SignUpState(
      isProfileCompleted: false,
      isRegistering: false,
      isRegisterd: false,
      isFailed: false
    );
  }

  factory SignUpState.profileCompleted() {
    return SignUpState(
      isProfileCompleted: true,
      isRegistering: false,
      isRegisterd: false,
      isFailed: false
    );
  }

  factory SignUpState.registering() {
    return SignUpState(
      isProfileCompleted: true,
      isRegistering: true,
      isRegisterd: false,
      isFailed: false
    );
  }

  factory SignUpState.registered() {
    return SignUpState(
      isProfileCompleted: true,
      isRegistering: false,
      isRegisterd: true,
      isFailed: false
    );
  }

  factory SignUpState.failed() {
    return SignUpState(
      isProfileCompleted: true,
      isRegistering: false,
      isRegisterd: false,
      isFailed: true
    );
  }
}