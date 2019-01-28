import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class SignUpState extends BlocState {
  final bool isRegistered;
  final bool isRegistering;
  final bool isFailed;
  final bool isAgeSelected;
  final int age;

  SignUpState({
    this.isRegistered: false,
    this.isRegistering: false,
    this.isFailed: false,
    this.isAgeSelected: false,
    this.age: -1
  });

  factory SignUpState.notRegistered() {
    return SignUpState(
      isRegistered: false,
      isRegistering: false,
      isFailed: false,
      isAgeSelected: false
    );
  }

  factory SignUpState.registered() {
    return SignUpState(
      isRegistered: true,
      isRegistering: false,
      isFailed: false,
      isAgeSelected: false
    );
  }

  factory SignUpState.registering() {
    return SignUpState(
      isRegistered: false,
      isRegistering: true,
      isFailed: false,
      isAgeSelected: false
    );
  }

  factory SignUpState.failed() {
    return SignUpState(
      isRegistered: false,
      isRegistering: false,
      isFailed: true,
      isAgeSelected: false
    );
  }

  factory SignUpState.ageSelected(int age) {
    return SignUpState(
      isRegistered: false,
      isRegistering: false,
      isFailed: false,
      isAgeSelected: true,
      age: age
    );
  }
}