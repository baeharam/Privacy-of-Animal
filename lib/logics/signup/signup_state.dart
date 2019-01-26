import 'package:privacy_of_animal/bloc_helpers/bloc_event_state.dart';

class SignUpState extends BlocState {
  final bool isEmailPasswordRegistered;
  final bool isProfiileRegistered;
  final bool isEmailPasswordRegistering;
  final bool isProfileRegistering;
  final bool isEmailPasswordFailed;
  final bool isProfileFailed;

  SignUpState({
    this.isEmailPasswordRegistered: false,
    this.isProfiileRegistered: false,
    this.isEmailPasswordRegistering: false,
    this.isProfileRegistering: false,
    this.isEmailPasswordFailed: false,
    this.isProfileFailed: false
  });

  factory SignUpState.notEmailPasswordRegistered() {
    return SignUpState(
      isEmailPasswordRegistered: false,
      isProfiileRegistered: false,
      isEmailPasswordRegistering: false,
      isProfileRegistering: false,
      isEmailPasswordFailed: false,
      isProfileFailed: false
    );
  }

  factory SignUpState.emailPasswordRegistered() {
    return SignUpState(
      isEmailPasswordRegistered: true,
      isProfiileRegistered: false,
      isEmailPasswordRegistering: false,
      isProfileRegistering: false,
      isEmailPasswordFailed: false,
      isProfileFailed: false
    );
  }

  factory SignUpState.profileRegistered() {
    return SignUpState(
      isEmailPasswordRegistered: true,
      isProfiileRegistered: true,
      isEmailPasswordRegistering: false,
      isProfileRegistering: false,
      isEmailPasswordFailed: false,
      isProfileFailed: false
    );
  }

  factory SignUpState.emailPasswordRgistering() {
    return SignUpState(
      isEmailPasswordRegistered: false,
      isProfiileRegistered: false,
      isEmailPasswordRegistering: true,
      isProfileRegistering: false,
      isEmailPasswordFailed: false,
      isProfileFailed: false
    );
  }

  factory SignUpState.profileRegistering() {
    return SignUpState(
      isEmailPasswordRegistered: true,
      isProfiileRegistered: false,
      isEmailPasswordRegistering: false,
      isProfileRegistering: true,
      isEmailPasswordFailed: false,
      isProfileFailed: false
    );
  }

  factory SignUpState.emailPasswordFailed() {
    return SignUpState(
      isEmailPasswordRegistered: false,
      isProfiileRegistered: false,
      isEmailPasswordRegistering: false,
      isProfileRegistering: false,
      isEmailPasswordFailed: true,
      isProfileFailed: false
    );
  }

  factory SignUpState.profileFailed() {
    return SignUpState(
      isEmailPasswordRegistered: false,
      isProfiileRegistered: false,
      isEmailPasswordRegistering: false,
      isProfileRegistering: false,
      isEmailPasswordFailed: false,
      isProfileFailed: true
    );
  }
}