import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class SignUpState extends BlocState {
  final bool isRegistered;
  final bool isRegistering;
  final bool isAccountRegisterFailed;
  final bool isProfileRegisterFailed;
  final bool isAgeSelected;
  final int age;
  final bool isMaleSelected;
  final bool isFemaleSelected;
  final String gender;
  final bool isFinished;

  SignUpState({
    this.isRegistered: false,
    this.isRegistering: false,
    this.isAccountRegisterFailed: false,
    this.isProfileRegisterFailed: false,
    this.isAgeSelected: false,
    this.age: -1,
    this.isMaleSelected: false,
    this.isFemaleSelected: false,
    this.gender: '',
    this.isFinished: false,
  });
  
  factory SignUpState.finished() {
    return SignUpState(
      isFinished: true
    );
  }

  factory SignUpState.registered() {
    return SignUpState(
      isRegistered: true
    );
  }

  factory SignUpState.registering() {
    return SignUpState(
      isRegistering: true
    );
  }

  factory SignUpState.accountRegisterFailed() {
    return SignUpState(
      isAccountRegisterFailed: true
    );
  }

  factory SignUpState.profileRegisterFailed() {
    return SignUpState(
      isProfileRegisterFailed: true
    );
  }

  factory SignUpState.ageSelected(int age) {
    return SignUpState(
      isAgeSelected: true,
      age: age
    );
  }

  factory SignUpState.maleSelected() {
    return SignUpState(
      isMaleSelected: true,
      gender: '남자'
    );
  }

  factory SignUpState.femaleSelected() {
    return SignUpState(
      isFemaleSelected: true,
      gender: '여자'
    );
  }
}